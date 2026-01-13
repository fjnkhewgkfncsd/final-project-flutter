import 'package:flutter/material.dart';
import '../../domain/model/question.model.dart';
import '../widget/choiceButton.widget.dart';
import '../../domain/model/choice.model.dart';

class QuestionWidget extends StatelessWidget {
  final Question question;
  final void Function(Choice choice) returnAnswerId;

  const QuestionWidget({
    super.key,
    required this.question,
    required this.returnAnswerId,
  });

  void onAnswerSelected(Choice choice) {
    returnAnswerId(choice);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(top:150, left:20,right:20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  question.questionTitle,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height:30),
              ...question.choices.map(
                (choice) => ChoiceButton(
                  answer: choice,
                  onPressed: () => onAnswerSelected(choice),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
