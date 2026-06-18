import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/loginpage.dart';
import 'screens/signuppage.dart';
import 'screens/homepage.dart';
import 'screens/phone_verification.dart';
import 'screens/welcomepage.dart'; // Import the WelcomePage

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Finance AI',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 0, 0, 0),
        primaryColor: Colors.white,
      ),
      initialRoute: '/home',
      routes: {
        '/': (context) => const WelcomePage(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen(),
        '/home': (context) => const HomeScreen(),
        '/phone_verification': (context) => PhoneVerificationScreen(phoneNumber: ''),
      },
    );
  }
}
