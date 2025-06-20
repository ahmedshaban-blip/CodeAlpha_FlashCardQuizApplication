// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flashcard_quiz_app/cubit/flashcard_cubit.dart';
import 'package:flashcard_quiz_app/cubit/flashcard_state.dart';
import 'package:flashcard_quiz_app/screens/add_edit_flashcard_screen.dart';
import 'package:flashcard_quiz_app/screens/flashcard_display.dart';
import 'package:flashcard_quiz_app/screens/flashcard_list_screen.dart';

class FlashCardStudy extends StatelessWidget {
  const FlashCardStudy({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flashcard Study'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.list_alt_rounded),
            tooltip: 'All Flashcards',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => FlashcardListScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            tooltip: 'Add Flashcard',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AddEditFlashcardScreen(),
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
          }

          if (state is FlashcardError) {
            return Center(
              child: Text(
                'Oops! ${state.message}',
                style: theme.textTheme.bodyLarge,
              ),
            );
          }

          if (state is FlashcardEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.menu_book_outlined,
                      size: 80,
                      color: theme.colorScheme.primary,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'No flashcards yet!',
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Tap below to create your first flashcard and start learning.',
                      style: theme.textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const AddEditFlashcardScreen(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.add),
                      label: const Text('Create Flashcard'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        textStyle: const TextStyle(fontSize: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          if (state is FlashcardLoaded) {
            final flashcard = state.flashcards[state.currentIndex];

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Expanded(
                    child: FlashcardDisplay(
                      flashcard: flashcard,
                      showAnswer: state.showAnswer,
                      onTap: () =>
                          context.read<FlashcardCubit>().toggleAnswer(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FilledButton.icon(
                        onPressed: state.currentIndex > 0
                            ? () =>
                                  context.read<FlashcardCubit>().previousCard()
                            : null,
                        icon: const Icon(Icons.arrow_back),
                        label: const Text('Previous'),
                      ),
                      Text(
                        '${state.currentIndex + 1} of ${state.flashcards.length}',
                        style: theme.textTheme.titleMedium,
                      ),
                      FilledButton.icon(
                        onPressed:
                            state.currentIndex < state.flashcards.length - 1
                            ? () => context.read<FlashcardCubit>().nextCard()
                            : null,
                        icon: const Icon(Icons.arrow_forward),
                        label: const Text('Next'),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }

          return const SizedBox.shrink(); // fallback
        },
      ),
    );
  }
}
