// lib/cubit/flashcard_cubit.dart
import 'dart:convert';
import 'package:flashcard_quiz_app/cubit/flashcard_state.dart';
import 'package:flashcard_quiz_app/models/flashcard.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FlashcardCubit extends Cubit<FlashcardState> {
  static const _flashcardsKey = 'flashcards';

  FlashcardCubit() : super(FlashcardInitial());

  Future<void> loadFlashcards() async {
    emit(FlashcardLoading());
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? flashcardsJson = prefs.getString(_flashcardsKey);

      if (flashcardsJson != null) {
        final List<dynamic> decodedData = json.decode(flashcardsJson);
        final List<Flashcard> flashcards = decodedData
            .map((json) => Flashcard.fromJson(json as Map<String, dynamic>))
            .toList();
        if (flashcards.isEmpty) {
          emit(FlashcardEmpty());
        } else {
          emit(FlashcardLoaded(flashcards: flashcards));
        }
      } else {
        emit(FlashcardEmpty());
      }
    } catch (e) {
      emit(FlashcardError('Failed to load flashcards: ${e.toString()}'));
    }
  }

  Future<void> _saveFlashcards(List<Flashcard> flashcards) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String encodedData = json.encode(
        flashcards.map((card) => card.toJson()).toList(),
      );
      await prefs.setString(_flashcardsKey, encodedData);
    } catch (e) {
      // In a real app, you might want to log this error or show a toast
      print('Failed to save flashcards: ${e.toString()}');
    }
  }

  void addFlashcard(String question, String answer) {
    if (state is FlashcardLoaded) {
      final currentState = state as FlashcardLoaded;
      final newFlashcard = Flashcard(question: question, answer: answer);
      final updatedFlashcards = List<Flashcard>.from(currentState.flashcards)
        ..add(newFlashcard);
      emit(
        currentState.copyWith(
          flashcards: updatedFlashcards,
          currentIndex: updatedFlashcards.length - 1,
        ),
      ); // Go to the new card
      _saveFlashcards(updatedFlashcards);
    } else if (state is FlashcardEmpty || state is FlashcardInitial) {
      final newFlashcard = Flashcard(question: question, answer: answer);
      final updatedFlashcards = [newFlashcard];
      emit(FlashcardLoaded(flashcards: updatedFlashcards, currentIndex: 0));
      _saveFlashcards(updatedFlashcards);
    }
  }

  void editFlashcard(String id, String newQuestion, String newAnswer) {
    if (state is FlashcardLoaded) {
      final currentState = state as FlashcardLoaded;
      final updatedFlashcards = currentState.flashcards.map((card) {
        if (card.id == id) {
          return card.copyWith(
            question: newQuestion,
            answer: newAnswer,
            updatedAt: DateTime.now(),
          );
        }
        return card;
      }).toList();
      emit(currentState.copyWith(flashcards: updatedFlashcards));
      _saveFlashcards(updatedFlashcards);
    }
  }

  void deleteFlashcard(String id) {
    if (state is FlashcardLoaded) {
      final currentState = state as FlashcardLoaded;
      final updatedFlashcards = currentState.flashcards
          .where((card) => card.id != id)
          .toList();

      if (updatedFlashcards.isEmpty) {
        emit(FlashcardEmpty());
        _saveFlashcards([]); // Clear data in storage
      } else {
        // Adjust current index if the deleted card was the current one or if it affected the subsequent card's index
        int newIndex = currentState.currentIndex;
        if (newIndex >= updatedFlashcards.length) {
          newIndex = updatedFlashcards.length - 1;
        }
        emit(
          currentState.copyWith(
            flashcards: updatedFlashcards,
            currentIndex: newIndex,
            showAnswer: false, // Reset answer view
          ),
        );
        _saveFlashcards(updatedFlashcards);
      }
    }
  }

  void nextCard() {
    if (state is FlashcardLoaded) {
      final currentState = state as FlashcardLoaded;
      if (currentState.currentIndex < currentState.flashcards.length - 1) {
        emit(
          currentState.copyWith(
            currentIndex: currentState.currentIndex + 1,
            showAnswer: false,
          ),
        );
      }
    }
  }

  void previousCard() {
    if (state is FlashcardLoaded) {
      final currentState = state as FlashcardLoaded;
      if (currentState.currentIndex > 0) {
        emit(
          currentState.copyWith(
            currentIndex: currentState.currentIndex - 1,
            showAnswer: false,
          ),
        );
      }
    }
  }

  void toggleAnswer() {
    if (state is FlashcardLoaded) {
      final currentState = state as FlashcardLoaded;
      emit(currentState.copyWith(showAnswer: !currentState.showAnswer));
    }
  }

  void goToCard(int index) {
    if (state is FlashcardLoaded) {
      final currentState = state as FlashcardLoaded;
      if (index >= 0 && index < currentState.flashcards.length) {
        emit(currentState.copyWith(currentIndex: index, showAnswer: false));
      }
    }
  }
}
