import 'package:flutter/material.dart';
import 'package:notes_app/add_notes.dart';
import 'package:notes_app/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
      routes: {
        "addNotes" : (context)=> AddNotesScreen()
      },
    );
  }
}