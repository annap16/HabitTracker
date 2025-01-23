import 'dart:async';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import '../classes/habit.dart';

@pragma('vm:entry-point')
Future<void> resetDailyHabits() async {
  await Firebase.initializeApp();

  final user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    return;
  }

  final userId = user.uid;
  final snapshot = await FirebaseFirestore.instance
      .collection('users')
      .doc(userId)
      .collection('habits')
      .where('frequency', isEqualTo: 'daily')
      .get();

  for (var doc in snapshot.docs) {
    await doc.reference.update({
      'isCompleted': false,
      'executionCount': 0,
      'lastUpdated': DateTime.now(),
    });
  }
  scheduleResetAlarmDaily();
}

@pragma('vm:entry-point')
Future<void> resetWeeklyHabits() async {
  await Firebase.initializeApp();

  final user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    return;
  }

  final userId = user.uid;
  final snapshot = await FirebaseFirestore.instance
      .collection('users')
      .doc(userId)
      .collection('habits')
      .where('frequency', isEqualTo: 'weekly')
      .get();

  for (var doc in snapshot.docs) {
    await doc.reference.update({
      'isCompleted': false,
      'executionCount': 0,
      'lastUpdated': DateTime.now(),
    });
  }
  scheduleResetAlarmWeekly();
}

@pragma('vm:entry-point')
Future<void> resetMonthlyHabits() async {
  await Firebase.initializeApp();

  final user = FirebaseAuth.instance.currentUser;

  if (user == null) {
    return;
  }

  final userId = user.uid;
  final snapshot = await FirebaseFirestore.instance
      .collection('users')
      .doc(userId)
      .collection('habits')
      .where('frequency', isEqualTo: 'monthly')
      .get();

  for (var doc in snapshot.docs) {
    await doc.reference.update({
      'isCompleted': false,
      'executionCount': 0,
      'lastUpdated': DateTime.now(),
    });
  }
  scheduleResetAlarmMonthly();
}

void scheduleResetAlarmDaily() async {
  final int alarmId = 0;
  DateTime now = DateTime.now();
  DateTime midnight =
      DateTime(now.year, now.month, now.day).add(Duration(days: 1));
  await AndroidAlarmManager.oneShotAt(
    midnight,
    alarmId,
    resetDailyHabits,
    exact: true,
    wakeup: true,
  );
}

void scheduleResetAlarmWeekly() async {
  final int alarmId = 1;
  DateTime mondayMidnight = getTimeUntilNextMondayMidnight();

  await AndroidAlarmManager.oneShotAt(
    mondayMidnight,
    alarmId,
    resetWeeklyHabits,
    exact: true,
    wakeup: true,
  );
}

void scheduleResetAlarmMonthly() async {
  final int alarmId = 2;
  DateTime nextMonthMondayMidnight = getTimeUntilNextMonthMidnight();

  await AndroidAlarmManager.oneShotAt(
    nextMonthMondayMidnight,
    alarmId,
    resetMonthlyHabits,
    exact: true,
    wakeup: true,
  );
}

DateTime getTimeUntilNextMondayMidnight() {
  DateTime now = DateTime.now();

  int daysUntilNextMonday = 7 - (now.weekday - DateTime.monday);
  DateTime nextMondayMidnight = DateTime(now.year, now.month, now.day, 0, 0, 0);

  nextMondayMidnight = now.add(Duration(days: daysUntilNextMonday));
  return nextMondayMidnight;
}

DateTime getTimeUntilNextMonthMidnight() {
  DateTime now = DateTime.now();

  DateTime nextMonthFirstDay = DateTime(now.year, now.month + 1, 1);

  DateTime nextMonthMidnight = DateTime(nextMonthFirstDay.year,
      nextMonthFirstDay.month, nextMonthFirstDay.day, 0, 0, 0);

  return nextMonthMidnight;
}

void checkForPendingReset() async {
  await Firebase.initializeApp();

  final user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    return;
  }

  final userId = user.uid;
  final snapshot = await FirebaseFirestore.instance
      .collection('users')
      .doc(userId)
      .collection('habits')
      .get();

  for (var doc in snapshot.docs) {
    Habit habit = Habit.fromMap(doc.data(), doc.id);
    makeUpdateIfNeeded(habit);
  }
}

void makeUpdateIfNeeded(Habit habit) async {
  switch (habit.frequency) {
    case ReminderFrequency.daily:
      if (habit.lastUpdated!.day != DateTime.now().day ||
          (habit.lastUpdated!.day == DateTime.now().day &&
              (habit.lastUpdated!.month != DateTime.now().month ||
                  habit.lastUpdated!.year != DateTime.now().year))) {
        habit.isCompleted = false;
        habit.executionCount = 0;
        habit.lastUpdated = DateTime.now();
        await habit.updateHabit();
      }
      break;
    case ReminderFrequency.weekly:
      Duration difference = DateTime.now().difference(habit.lastUpdated!);
      if (difference.inDays > 7) {
        habit.isCompleted = false;
        habit.executionCount = 0;
        habit.lastUpdated = DateTime.now();
        await habit.updateHabit();
      }
      break;
    case ReminderFrequency.monthly:
      if (habit.lastUpdated!.month != DateTime.now().month ||
          (habit.lastUpdated!.month == DateTime.now().month &&
              habit.lastUpdated!.year != DateTime.now().year)) {
        habit.isCompleted = false;
        habit.executionCount = 0;
        habit.lastUpdated = DateTime.now();
        await habit.updateHabit();
      }
      break;
  }
}
