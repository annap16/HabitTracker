import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

enum ReminderFrequency { daily, weekly, monthly }

class Habit {
  String id;
  String name;
  bool isCompleted;
  ReminderFrequency frequency;
  int detailedFrequency;
  int executionCount;
  String? description;
  String color;
  DateTime? lastUpdated;

  Habit({
    this.id = '',
    required this.name,
    this.isCompleted = false,
    required this.frequency,
    this.detailedFrequency = 1,
    this.description,
    this.color = '#A8D5BA',
    this.executionCount = 0,
    this.lastUpdated,
  });

  factory Habit.fromMap(Map<String, dynamic> data, String documentId) {
    return Habit(
      id: documentId,
      name: data['name'],
      isCompleted: data['isCompleted'],
      frequency: _frequencyFromString(data['frequency']),
      detailedFrequency: data['detailedFrequency'] ?? 1,
      description: data['description'],
      color: data['color'],
      executionCount: data['executionCount'] ?? 0,
      lastUpdated: data['lastUpdated'] != null
          ? (data['lastUpdated'] as Timestamp).toDate()
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'isCompleted': isCompleted,
      'frequency': frequency.toString().split('.').last,
      'detailedFrequency': detailedFrequency,
      'description': description,
      'color': color,
      'executionCount': executionCount,
      'lastUpdated': lastUpdated,
    };
  }

  static ReminderFrequency _frequencyFromString(String frequency) {
    switch (frequency) {
      case 'daily':
        return ReminderFrequency.daily;
      case 'weekly':
        return ReminderFrequency.weekly;
      case 'monthly':
        return ReminderFrequency.monthly;
      default:
        return ReminderFrequency.daily;
    }
  }

  Future<void> addHabit() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    lastUpdated = DateTime.now();

    CollectionReference habits = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('habits');
    DocumentReference docRef = await habits.add(toMap());
    id = docRef.id;
  }

  Future<void> updateHabit() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('habits')
        .doc(id)
        .update(toMap());
  }

  Future<void> deleteHabit() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('habits')
        .doc(id)
        .delete();
  }

  static Stream<List<Habit>> streamHabits({required bool showCompleted}) {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('habits')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => Habit.fromMap(doc.data(), doc.id))
              .where((habit) => habit.isCompleted == showCompleted)
              .toList(),
        );
  }

  static Stream<List<Habit>> streamAllHabits() {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('habits')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => Habit.fromMap(
                  doc.data(),
                  doc.id,
                ),
              )
              .toList(),
        );
  }

  Future<void> toggleCompletion(BuildContext context) async {
    if (isCompleted) {
      await showDialog(
        context: context,
        builder: (context) {
          final TextEditingController inputController = TextEditingController();
          String? errorText;

          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: const Text('Changed Completed Times'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Enter a value between 0 and $detailedFrequency:'),
                    const SizedBox(height: 10),
                    TextField(
                      controller: inputController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: 'Value',
                        errorText: errorText,
                      ),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      final int? value = int.tryParse(inputController.text);
                      if (value != null &&
                          value >= 0 &&
                          value <= detailedFrequency) {
                        executionCount = value;
                        Navigator.pop(context);
                      } else {
                        setState(() {
                          errorText =
                              'Invalid value. Enter a number between 0 and $detailedFrequency.';
                        });
                      }
                    },
                    child: const Text('Submit'),
                  ),
                ],
              );
            },
          );
        },
      );
      if (executionCount < detailedFrequency) {
        isCompleted = !isCompleted;
      }
    }
    final userId = FirebaseAuth.instance.currentUser!.uid;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('habits')
        .doc(id)
        .update({
      'isCompleted': isCompleted,
      'executionCount': executionCount,
    });
  }
}
