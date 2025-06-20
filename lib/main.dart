import 'package:flutter/material.dart';
import 'package:to_do_list/pages/loading_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white
      ),
      textTheme: TextTheme(
        headlineSmall: TextStyle(fontSize: 16, color: Colors.white)
      ) 
      ),
      home: const LoadingPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}


