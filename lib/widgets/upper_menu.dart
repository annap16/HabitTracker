import 'package:flutter/material.dart';
import 'package:habit_tracker/screens/main_view.dart';
import '../screens/all_habits_screen.dart';

class UpperMenu extends StatelessWidget {
  final List<IconData> icons = const [
    Icons.menu,
    Icons.today,
    Icons.receipt,
    Icons.info,
  ];

  const UpperMenu({super.key});

  void _onMenuTap(BuildContext context) {
    Scaffold.of(context).openDrawer();
  }

  void _onTodayTap(BuildContext context) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const MainView()));
  }

  void _onReceiptTap(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const AllHabitsScreen()),
    );
  }

  void _onInfoTap(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Welcome to Habit Tracker!"),
          content: SingleChildScrollView(
            child: Text(
              "\nStay on top of your goals and build better habits with ease."
              "\n\n- Set daily, weekly, or monthly habits."
              "\n\n- Get reminders to stay consistent."
              "\n\n- Stay motivated as you achieve your goals!"
              "\n\nReady to create the best version of yourself? Let’s get started!",
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Close"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<VoidCallback> actions = [
      () => _onMenuTap(context),
      () => _onTodayTap(context),
      () => _onReceiptTap(context),
      () => _onInfoTap(context),
    ];

    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: icons.asMap().entries.map((entry) {
          int index = entry.key;
          IconData icon = entry.value;

          return GestureDetector(
            onTap: actions[index],
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  size: 40,
                  color: Colors.black,
                ),
                const SizedBox(height: 5),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
