import 'package:flutter/material.dart';
import '../../domain/model/answer.model.dart';
class ChoiceButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Answer answer;
  const ChoiceButton({
    super.key,
    required this.answer,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 2,
          backgroundColor: Colors.red[300],
          minimumSize: const Size.fromHeight(50),
          maximumSize: const Size.fromHeight(100),
        ),
        onPressed:onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25.0),
          child: Center(
            child: Text(answer.answerTitle,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}