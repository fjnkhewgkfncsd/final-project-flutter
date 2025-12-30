import 'entity/quiz.entity.dart';
import '../../domain/model/quiz.model.dart';
import '../mapper/question.mapper.dart';

class QuizMapper{
  static Quiz toDomain(QuizEntity entity){
    return Quiz(
      id: entity.id,
      emergencyId: entity.emergencyId,
      questions: entity.questions.map((qEntity) => QuestionMapper.toDomain(qEntity)).toList(),
    );
  }

  static QuizEntity toEntity(Quiz domain){
    return QuizEntity(
      id: domain.id,
      emergencyId: domain.emergencyId,
      questions: domain.questions.map((qDomain) => QuestionMapper.toEntity(qDomain)).toList(),
    );
  }
}