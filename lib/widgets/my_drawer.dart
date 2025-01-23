import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker/screens/start_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});
  @override
  MyDrawerState createState() => MyDrawerState();
}

class MyDrawerState extends State<MyDrawer> {
  Future<void> deleteCollection(CollectionReference collectionRef) async {
    const int batchSize = 100;
    QuerySnapshot snapshot;

    do {
      snapshot = await collectionRef.limit(batchSize).get();

      for (var doc in snapshot.docs) {
        await doc.reference.delete();
      }
    } while (snapshot.size > 0);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color(0xFFA8D5BA),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 40,
                  child: Icon(
                    Icons.account_circle,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  '${FirebaseAuth.instance.currentUser!.email}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          ExpansionTile(
            leading: const Icon(Icons.account_circle),
            title: const Text('User'),
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.delete),
                title: const Text('Delete Account'),
                onTap: () {
                  _showDeleteConfirmationDialog(context);
                },
              ),
            ],
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const StartScreen()),
                (Route<dynamic> route) => false,
              );
            },
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext parentContext) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Account'),
          content: const Text('Are you sure you want to delete this account?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () {
                Navigator.of(context).pop();
                _deleteAccount(parentContext);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteAccount(BuildContext context) async {
    try {
      await deleteCollection(FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('habits'));

      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .delete();
      await FirebaseAuth.instance.currentUser!.delete();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Your account has been deleted.')),
        );

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const StartScreen()),
          (Route<dynamic> route) => false,
        );
      }
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.message}')),
        );
      }
    }
  }
}
