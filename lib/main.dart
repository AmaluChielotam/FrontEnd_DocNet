import 'package:flutter/material.dart';
import 'package:flutterprojects/screens/chat.dart';
import 'screens/auth/signup.dart';
import 'package:flutterprojects/screens/auth/login.dart';
import 'package:flutterprojects/screens/auth/otp.dart';
import 'package:flutterprojects/screens/auth/forgot_password.dart';
import 'package:flutterprojects/screens/auth/verify_reset_password.dart';
import 'package:flutterprojects/screens/specialization.dart';
import 'package:flutterprojects/screens/home.dart';

void main() {
  runApp(DoctorConnectApp());
}

class DoctorConnectApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DoctorConnect',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Color(0xFF2D5B8F),
        colorScheme: ColorScheme.light(
          primary: Color(0xFF2D5B8F),
          secondary: Color(0xFF4CAF50),
          background: Color(0xFFF8F9FA),
        ),
        fontFamily: 'Inter',
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Color(0xFF2D5B8F)),
          titleTextStyle: TextStyle(
            color: Color(0xFF2D5B8F),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: ChatScreen(conversation: conversation),
      debugShowCheckedModeBanner: false,
      routes: {
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignupScreen(),
        '/verify-otp': (context) => VerifyOtpScreen(),
        '/forgot-password': (context) => ForgotPasswordScreen(),
        '/verify-reset-password': (context) => VerifyResetPasswordScreen(),
        '/choose-specialty': (context) => ChooseSpecialtyScreen(),
        '/home': (context) => HomeScreen(),
      },
    );
  }
}