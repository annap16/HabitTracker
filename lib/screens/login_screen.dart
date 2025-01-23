import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:habit_tracker/screens/main_view.dart';
import 'package:habit_tracker/screens/register_screen.dart';
import '../services/notification_service.dart';
import '../services/reset_lists.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  bool _isPasswordVisible = false;
  String? _errorMessage;

  Future<void> _login() async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      checkForPendingReset();
      scheduleResetAlarmDaily();
      scheduleResetAlarmWeekly();
      scheduleResetAlarmMonthly();
      //scheduleNotificationAt12();
      //scheduleNotificationAt20();

      if (!context.mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MainView()),
        );
      }

      NotificationService notService = NotificationService();
      await notService.init();
      DateTime dateTimeNow = DateTime.now();
      DateTime time12 = DateTime(
          dateTimeNow.year, dateTimeNow.month, dateTimeNow.day, 12, 0, 0, 0, 0);
      if (time12.isBefore(dateTimeNow)) {
        time12 = time12.add(const Duration(days: 1));
      }
      DateTime time20 = DateTime(
          dateTimeNow.year, dateTimeNow.month, dateTimeNow.day, 20, 0, 0, 0, 0);
      if (time20.isBefore(dateTimeNow)) {
        time20 = time20.add(const Duration(days: 1));
      }
      notService.scheduleNotification(time12);
      notService.scheduleNotification(time20);
    } on FirebaseAuthException catch (e) {
      setState(() {
        _errorMessage = e.message;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Log in")),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'E-mail',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _passwordController,
                  obscureText: !_isPasswordVisible,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                if (_errorMessage != null)
                  Text(
                    _errorMessage!,
                    style: const TextStyle(color: Colors.red),
                  ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _login,
                  child: const Text('Log in'),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RegisterScreen()),
                    );
                  },
                  child: const Text("Don't have an account? Register here"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
