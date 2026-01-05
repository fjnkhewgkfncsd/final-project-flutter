import '../entity/favoriteView.entity.dart';
import '../../domain/model/favoriteView.model.dart';

class FavoriteViewMapper{
  static FavoriteViewModel toDomain(FavoriteViewEntity entity){
    return FavoriteViewModel(
      id: entity.id,
      historyId: entity.historyId,
      icon: entity.icon,
      title: entity.title,
      timestamp: entity.timestamp,
      category: entity.category,
    );
  }
}