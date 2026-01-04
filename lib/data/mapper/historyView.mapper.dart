import '../entity/historyView.entity.dart';
import '../../domain/model/historyView.model.dart';
class HistoryViewMapper{
  static HistoryViewModel toViewModel(HistoryViewEntity entity){
    return HistoryViewModel(
      id: entity.id,
      quizId:  entity.quizId,
      timestamp: entity.timestamp,
      icon: entity.icon,
      title: entity.title,
      category: entity.category,
    );
  }
}