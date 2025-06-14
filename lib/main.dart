// lib/main.dart
import 'package:flashcard_quiz_app/cubit/flashcard_cubit.dart';
import 'package:flashcard_quiz_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FlashcardCubit()..loadFlashcards(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flashcard Quiz',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: const FlashCardStudy(),
      ),
    );
  }
}
