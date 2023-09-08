import 'package:student_attendance/screens/dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';

import './screens/login_screen.dart';
import './screens/verify_email.dart';
import './screens/splash_screen.dart';
import './screens/confirm_qr_scan.dart';
import './screens/attendance_record.dart';
import './screens/all_subject_screen.dart';
import './screens/edit_profile.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ],
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Attendance',
      theme: ThemeData(
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: const Color.fromRGBO(49, 80, 200, 1),
          onPrimary: Colors.white,
          secondary: const Color.fromRGBO(255, 105, 0, 1),
          onSecondary: Colors.white,
          error: Colors.red.shade800,
          onError: Colors.white,
          background: Colors.grey.shade800,
          onBackground: Colors.white,
          surface: Colors.grey.shade800,
          onSurface: Colors.grey.shade700,
        ),
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SplashScreen();
          } else if (snapshot.hasData) {
            return const VerifyEmailScreen();
          }
          return const LoginScreen();
        },
      ),
      routes: {
        VerifyEmailScreen.routeName: (context) => const VerifyEmailScreen(),
        DashBoardScreen.routeName: (context) => const DashBoardScreen(),
        LoginScreen.routeName: (context) => const LoginScreen(),
        ConfirmQRScanScreen.routeName: (context) => const ConfirmQRScanScreen(),
        AttendanceRecordScreen.routeName: (context) =>
        const AttendanceRecordScreen(),
        AllSubjectScreen.routeName: (context) => const AllSubjectScreen(),
        EditProfileScreen.routeName: (context) => const EditProfileScreen(),
        // ReportScreen.routeName:(context)=>const ReportScreen(),
      },
    );
  }
}