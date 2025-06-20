// lib/screens/add_edit_flashcard_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flashcard_quiz_app/cubit/flashcard_cubit.dart';
import 'package:flashcard_quiz_app/models/flashcard.dart';

class AddEditFlashcardScreen extends StatefulWidget {
  final Flashcard? flashcard;

  const AddEditFlashcardScreen({super.key, this.flashcard});

  @override
  State<AddEditFlashcardScreen> createState() => _AddEditFlashcardScreenState();
}

class _AddEditFlashcardScreenState extends State<AddEditFlashcardScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _questionController;
  late final TextEditingController _answerController;

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
      final question = _questionController.text.trim();
      final answer = _answerController.text.trim();

      if (widget.flashcard == null) {
        context.read<FlashcardCubit>().addFlashcard(question, answer);
      } else {
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
    final theme = Theme.of(context);
    final isEditing = widget.flashcard != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Flashcard' : 'Add Flashcard'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Icon(
                  Icons.question_answer_outlined,
                  size: 64,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _questionController,
                  maxLines: 5,
                  textInputAction: TextInputAction.newline,
                  decoration: InputDecoration(
                    labelText: 'Question',
                    hintText: 'Enter the question here...',
                    filled: true,
                    fillColor: theme.colorScheme.surfaceVariant,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter a question';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _answerController,
                  maxLines: 5,
                  textInputAction: TextInputAction.newline,
                  decoration: InputDecoration(
                    labelText: 'Answer',
                    hintText: 'Enter the answer here...',
                    filled: true,
                    fillColor: theme.colorScheme.surfaceVariant,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter an answer';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: _saveFlashcard,
                    icon: const Icon(Icons.save),
                    label: Text(isEditing ? 'Save Changes' : 'Add Flashcard'),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      textStyle: const TextStyle(fontSize: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
