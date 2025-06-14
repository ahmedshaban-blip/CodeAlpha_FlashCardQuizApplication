// lib/screens/add_edit_flashcard_screen.dart
import 'package:flashcard_quiz_app/cubit/flashcard_cubit.dart';
import 'package:flashcard_quiz_app/models/flashcard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddEditFlashcardScreen extends StatefulWidget {
  final Flashcard? flashcard; // Null for add, present for edit

  const AddEditFlashcardScreen({super.key, this.flashcard});

  @override
  State<AddEditFlashcardScreen> createState() => _AddEditFlashcardScreenState();
}

class _AddEditFlashcardScreenState extends State<AddEditFlashcardScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _questionController;
  late TextEditingController _answerController;

  @override
  void initState() {
    super.initState();
    _questionController = TextEditingController(
      text: widget.flashcard?.question ?? '',
    );
    _answerController = TextEditingController(
      text: widget.flashcard?.answer ?? '',
    );
  }

  @override
  void dispose() {
    _questionController.dispose();
    _answerController.dispose();
    super.dispose();
  }

  void _saveFlashcard() {
    if (_formKey.currentState!.validate()) {
      final question = _questionController.text;
      final answer = _answerController.text;

      if (widget.flashcard == null) {
        // Add new flashcard
        context.read<FlashcardCubit>().addFlashcard(question, answer);
      } else {
        // Edit existing flashcard
        context.read<FlashcardCubit>().editFlashcard(
          widget.flashcard!.id,
          question,
          answer,
        );
      }
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.flashcard == null ? 'Add Flashcard' : 'Edit Flashcard',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _questionController,
                decoration: const InputDecoration(
                  labelText: 'Question',
                  border: OutlineInputBorder(),
                ),
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a question';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _answerController,
                decoration: const InputDecoration(
                  labelText: 'Answer',
                  border: OutlineInputBorder(),
                ),
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an answer';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: _saveFlashcard,
                icon: const Icon(Icons.save),
                label: Text(
                  widget.flashcard == null ? 'Add Flashcard' : 'Save Changes',
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50), // Full width button
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
