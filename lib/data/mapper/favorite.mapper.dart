import '../entity/favorite.entity.dart';
import '../../domain/model/favorite.model.dart';

class FavoriteMapper {
  static Favorite toDomain(FavoriteEntity entity){
    return Favorite(
      id: entity.id,
      historyId:entity.historyId
    );
  }

  static FavoriteEntity toEntity(Favorite model){
    return FavoriteEntity(id: model.id, historyId: model.historyId);
  }
}