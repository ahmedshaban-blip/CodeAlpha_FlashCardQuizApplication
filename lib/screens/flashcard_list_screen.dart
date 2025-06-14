// lib/screens/flashcard_list_screen.dart
import 'package:flashcard_quiz_app/cubit/flashcard_cubit.dart';
import 'package:flashcard_quiz_app/cubit/flashcard_state.dart';
import 'package:flashcard_quiz_app/screens/add_edit_flashcard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FlashcardListScreen extends StatelessWidget {
  const FlashcardListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('All Flashcards')),
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
                  const Text('No flashcards found.'),
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
                    label: const Text('Add New Flashcard'),
                  ),
                ],
              ),
            );
          } else if (state is FlashcardLoaded) {
            return ListView.builder(
              itemCount: state.flashcards.length,
              itemBuilder: (context, index) {
                final flashcard = state.flashcards[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: ListTile(
                    title: Text(flashcard.question),
                    subtitle: Text(
                      flashcard.answer,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          tooltip: 'Edit',
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => AddEditFlashcardScreen(
                                  flashcard: flashcard,
                                ),
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          tooltip: 'Delete',
                          onPressed: () {
                            _showDeleteConfirmationDialog(
                              context,
                              flashcard.id,
                            );
                          },
                        ),
                      ],
                    ),
                    onTap: () {
                      context.read<FlashcardCubit>().goToCard(index);
                      Navigator.of(context).pop(); // Go back to home screen
                    },
                  ),
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddEditFlashcardScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, String flashcardId) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Confirm Deletion'),
          content: const Text(
            'Are you sure you want to delete this flashcard?',
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () {
                context.read<FlashcardCubit>().deleteFlashcard(flashcardId);
                Navigator.of(dialogContext).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
