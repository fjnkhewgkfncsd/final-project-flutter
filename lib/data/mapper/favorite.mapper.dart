import '../entity/favorite.entity.dart';
import '../../domain/model/favorite.model.dart';
import './history.mapper.dart';

class FavoriteMapper {
  static Favorite toDomain(FavoriteEntity entity){
    return Favorite(
      id: entity.favId,
      history: HistoryMapper.toModel(entity.history)
    );
  }

  // static FavoriteEntity toEntity(Favorite model){
  //   return FavoriteEntity(id: model.id, history: HistoryMapper.toEntity(model.history));
  // }
}