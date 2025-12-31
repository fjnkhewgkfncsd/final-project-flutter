import '../mapper/favorite.mapper.dart';
import '../../domain/interface/Irepository.interface.dart';
import '../service/controller/favorite.controller.dart';
import '../../domain/model/favorite.model.dart';

class FavoriteRepoImple implements IFavoriteRepo{
  final FavoriteService _favoriteService = FavoriteService();

  @override
  Future<Favorite?> getById(int id) async {
    final result = await _favoriteService.getFavoriteById(id);
    return result == null ? null : FavoriteMapper.toDomain(result);
  }

  @override
  Future<List<Favorite>> getAllFavorites() async {
    final result = await _favoriteService.getAllFavorites();
    return result.map((map) => FavoriteMapper.toDomain(map)).toList();
  }

  @override
  Future<int> insertFavorite(Favorite model) async {
    return await _favoriteService.insertFavorite(FavoriteMapper.toEntity(model));
  }

  @override
  Future<int>deleteFavorite(int id) async {
    return await _favoriteService.deleteFavorite(id);
  }
}
