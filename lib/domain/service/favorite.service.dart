import '../interface/Irepository.interface.dart';
import '../model/favorite.model.dart';

class FavoriteService {
  final IFavoriteRepo _favoriteRepo;

  FavoriteService(this._favoriteRepo);

  Future<Favorite?> getFavoriteById(int id) async {
    return await _favoriteRepo.getById(id);
  }

  Future<List<Favorite>> getFavorites() async {
    return await _favoriteRepo.getAllFavorites();
  }

  Future <void> addFavorite(Favorite favorite) async {
    await _favoriteRepo.insertFavorite(favorite);
  }

  Future<void> deleteFavorite(int id) async {
    await _favoriteRepo.deleteFavorite(id);
  }
}