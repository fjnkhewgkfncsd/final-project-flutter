import 'entity/question.entity.dart';
import '../../domain/model/question.model.dart';
import './answer.mapper.dart';

class QuestionMapper{
  static Question toDomain(QuestionEntity entity){
    return Question(
      questionId: entity.questionId,
      questionTitle: entity.questionTitle,
      quizId: entity.quizId,
      answers: entity.answers.map((aEntity) => AnswerMapper.toDomain(aEntity)).toList(),
    );
  }

  static QuestionEntity toEntity(Question domain){
    return QuestionEntity(
      questionId: domain.questionId,
      questionTitle: domain.questionTitle,
      quizId: domain.quizId,
      answers: domain.answers.map((aDomain) => AnswerMapper.toEntity(aDomain)).toList(),
    );
  }
}