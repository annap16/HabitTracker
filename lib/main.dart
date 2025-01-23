import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/start_screen.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AndroidAlarmManager.initialize();
  await AndroidAlarmManager.cancel(0);
  await AndroidAlarmManager.cancel(1);
  await AndroidAlarmManager.cancel(2);
  await AndroidAlarmManager.cancel(3);
  await AndroidAlarmManager.cancel(4);
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Habit Tracker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const StartScreen(),
    );
  }
}
