import 'package:flutter/material.dart';

class BottomAppBarWithFloatingButton extends StatelessWidget {
  final String completedText;
  final String totalText;

  const BottomAppBarWithFloatingButton({
    super.key,
    required this.completedText,
    required this.totalText,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      child: SizedBox(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                '$completedText / $totalText',
                style: const TextStyle(fontSize: 18, color: Colors.black),
              ),
            ),
            const SizedBox(width: 48),
          ],
        ),
      ),
    );
  }
}
