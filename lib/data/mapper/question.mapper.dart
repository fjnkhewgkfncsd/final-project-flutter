import '../entity/question.entity.dart';
import '../../domain/model/question.model.dart';
import 'choice.mapper.dart';

class QuestionMapper{
  static Question toDomain(QuestionEntity entity){
    return Question(
      questionId: entity.questionId,
      questionTitle: entity.questionTitle,
      choices: entity.choices.map((aEntity) => ChoiceMapper.toDomain(aEntity)).toList(),
    );
  }

  static QuestionEntity toEntity(Question domain){
    return QuestionEntity(
      questionId: domain.questionId,
      questionTitle: domain.questionTitle,
      choices: domain.choices.map((aDomain) => ChoiceMapper.toEntity(aDomain)).toList(),
    );
  }
}