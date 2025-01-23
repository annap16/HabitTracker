// import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'notification_service.dart';

// @pragma('vm:entry-point')
// Future<void> invokeNotification() async {
//   await Firebase.initializeApp();

//   final user = FirebaseAuth.instance.currentUser;
//   if (user == null) {
//     return;
//   }

//   final userId = user.uid;
//   final snapshot = await FirebaseFirestore.instance
//       .collection('users')
//       .doc(userId)
//       .collection('habits')
//       .where('isCompleted', isEqualTo: false)
//       .get();

//   int pendingHabitsSize = snapshot.size;
//   if (pendingHabitsSize > 0) {
//     NotificationService notService = NotificationService();
//     await notService.init();
//     notService.showNotification(pendingHabitsSize);
//   }

//   //scheduleNotificationAt20();
// }

// void scheduleNotificationAt12() async {
//   final int alarmId = 3;
//   DateTime now = DateTime.now();
//   DateTime twelveOClock = DateTime(now.year, now.month, now.day, 12);
//   if (twelveOClock.isBefore(now)) {
//     twelveOClock.add(const Duration(days: 1));
//   }
//   await AndroidAlarmManager.oneShotAt(
//     twelveOClock,
//     alarmId,
//     invokeNotification,
//     exact: true,
//     wakeup: true,
//   );
// }

// void scheduleNotificationAt20() async {
//   final int alarmId = 4;
//   DateTime now = DateTime.now();
//   DateTime eightOClockPM = DateTime(now.year, now.month, now.day, 21, 3);
//   if (eightOClockPM.isBefore(now)) {
//     eightOClockPM.add(const Duration(days: 1));
//   }
//   await AndroidAlarmManager.oneShotAt(
//     eightOClockPM,
//     alarmId,
//     invokeNotification,
//     exact: true,
//     wakeup: true,
//   );
// }
