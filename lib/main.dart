import 'package:flutter/material.dart';
import 'package:to_do_list/pages/auth_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To do list',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white
      ),
      textTheme: TextTheme(
        headlineSmall: TextStyle(fontSize: 16, color: Colors.white)
      ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue, 
            foregroundColor: Colors.white, 
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          ),
        ), 
      ),
      home: AuthPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}


