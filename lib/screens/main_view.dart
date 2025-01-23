import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../classes/habit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/upper_menu.dart';
import '../widgets/bottom_app_bar.dart';
import '../screens/add_habit_screen.dart';
import '../widgets/habit_list.dart';
import '../widgets/my_drawer.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  Stream<Map<String, int>> countHabitsStream() {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('habits')
        .snapshots()
        .map((snapshot) {
      List<Habit> habits = snapshot.docs
          .map((doc) => Habit.fromMap(doc.data(), doc.id))
          .toList();

      int completedCount = habits.where((habit) => habit.isCompleted).length;
      int totalCount = habits.length;

      return {'completed': completedCount, 'total': totalCount};
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Habit Tracker'),
        automaticallyImplyLeading: false,
      ),
      drawer: const MyDrawer(),
      body: Column(
        children: [
          const UpperMenu(),
          Expanded(
            child: HabitList(),
          ),
        ],
      ),
      bottomNavigationBar: StreamBuilder<Map<String, int>>(
        stream: countHabitsStream(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const BottomAppBarWithFloatingButton(
              completedText: '0',
              totalText: '0',
            );
          }

          int completed = snapshot.data!['completed']!;
          int total = snapshot.data!['total']!;

          return BottomAppBarWithFloatingButton(
            completedText: '$completed',
            totalText: '$total',
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddHabitScreen()),
          );
        },
        elevation: 6.0,
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
    );
  }
}
