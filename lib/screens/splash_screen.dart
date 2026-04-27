import 'package:flutter/material.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'VOYAGE',
              style: TextStyle(
                color: Colors.white,
                fontSize: 48,
                letterSpacing: 8.0,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(height: 200),
            Text(
              'The Collection Of Clothing Brand',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 12,
                letterSpacing: 2.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
