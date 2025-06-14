// lib/screens/home_screen.dart
import 'package:flashcard_quiz_app/cubit/flashcard_cubit.dart';
import 'package:flashcard_quiz_app/cubit/flashcard_state.dart';
import 'package:flashcard_quiz_app/screens/add_edit_flashcard_screen.dart';
import 'package:flashcard_quiz_app/screens/flashcard_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flashcard_quiz_app/screens/flashcard_list_screen.dart';

class FlashCardStudy extends StatelessWidget {
  const FlashCardStudy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flashcard Study'),
        actions: [
          IconButton(
            icon: const Icon(Icons.list),
            tooltip: 'View All Flashcards',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => FlashcardListScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Add New Flashcard',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AddEditFlashcardScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<FlashcardCubit, FlashcardState>(
        builder: (context, state) {
          if (state is FlashcardLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FlashcardError) {
            return Center(child: Text('Error: ${state.message}'));
          } else if (state is FlashcardEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('No flashcards yet!'),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const AddEditFlashcardScreen(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Create Your First Flashcard'),
                  ),
                ],
              ),
            );
          } else if (state is FlashcardLoaded) {
            final currentFlashcard = state.flashcards[state.currentIndex];
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Expanded(
                    child: FlashcardDisplay(
                      flashcard: currentFlashcard,
                      showAnswer: state.showAnswer,
                      onTap: () =>
                          context.read<FlashcardCubit>().toggleAnswer(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton.icon(
                          onPressed: state.currentIndex > 0
                              ? () => context
                                    .read<FlashcardCubit>()
                                    .previousCard()
                              : null,
                          icon: const Icon(Icons.arrow_back),
                          label: const Text('Previous'),
                        ),
                        Text(
                          '${state.currentIndex + 1} of ${state.flashcards.length}',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        ElevatedButton.icon(
                          onPressed:
                              state.currentIndex < state.flashcards.length - 1
                              ? () => context.read<FlashcardCubit>().nextCard()
                              : null,
                          icon: const Icon(Icons.arrow_forward),
                          label: const Text('Next'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
          return const SizedBox.shrink(); // Fallback for unhandled states
        },
      ),
    );
  }
}
