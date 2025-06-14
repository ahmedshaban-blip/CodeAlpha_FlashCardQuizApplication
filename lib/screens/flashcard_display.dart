// lib/widgets/flashcard_display.dart
import 'dart:math';
import 'package:flashcard_quiz_app/models/flashcard.dart';
import 'package:flutter/material.dart';

class FlashcardDisplay extends StatefulWidget {
  final Flashcard flashcard;
  final bool showAnswer;
  final VoidCallback onTap;

  const FlashcardDisplay({
    super.key,
    required this.flashcard,
    required this.showAnswer,
    required this.onTap,
  });

  @override
  State<FlashcardDisplay> createState() => _FlashcardDisplayState();
}

class _FlashcardDisplayState extends State<FlashcardDisplay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = Tween<double>(
      begin: 0,
      end: pi,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void didUpdateWidget(covariant FlashcardDisplay oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.showAnswer != oldWidget.showAnswer) {
      if (widget.showAnswer) {
        // Show answer - animate forward
        _controller.forward();
      } else {
        // Show question - animate backward
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          final isShowingFront = _animation.value < pi / 2;
          final transform = Matrix4.identity()
            ..setEntry(3, 2, 0.001) // Perspective
            ..rotateY(_animation.value);

          return Transform(
            transform: transform,
            alignment: Alignment.center,
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Container(
                constraints: const BoxConstraints(
                  minHeight: 200,
                  minWidth: double.infinity,
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: isShowingFront
                        ? Text(
                            widget.flashcard.question,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headlineSmall
                                ?.copyWith(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                ),
                          )
                        : Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.identity()..rotateY(pi),
                            child: Text(
                              widget.flashcard.answer,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headlineSmall
                                  ?.copyWith(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
