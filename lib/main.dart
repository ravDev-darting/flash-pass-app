import 'package:firebase_core/firebase_core.dart';
import 'package:flash_pass/splash.dart'; // Ensure this points to your splash screen file
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart'; // Compatible with older versions

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Firebase initialization
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key); // Key? syntax for Flutter 3.3.9

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, child) => ResponsiveWrapper.builder(
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          child:
              child, // The home widget (SplashScreenMain) will be passed here
        ),
        defaultScale: true,
        minWidth: 450, // Minimum width for scaling
        defaultName: MOBILE,
        breakpoints: [
          const ResponsiveBreakpoint.resize(450, name: MOBILE), // Mobile
          const ResponsiveBreakpoint.autoScale(800, name: TABLET), // Tablet
          const ResponsiveBreakpoint.autoScale(1200, name: DESKTOP), // Desktop
          const ResponsiveBreakpoint.autoScale(2460,
              name: '4K'), // Large screens
        ], // Optional background
      ),
      home: const SplashScreenMain(), // Your splash screen widget
    );
  }
}
