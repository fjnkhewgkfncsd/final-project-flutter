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

  Future <void> addFavorite(int historyId) async {
    await _favoriteRepo.insertFavorite(historyId);
  }

  Future<void> deleteFavorite(int id) async {
    await _favoriteRepo.deleteFavorite(id);
  }

  Future<List<Favorite>> getFavoriteViews() async {
    return await _favoriteRepo.getFavoriteViews();
  }
  
  Future<void> deleteFavoriteByHistoryId(int historyId) async {
    await _favoriteRepo.deleteFavoriteByHistoryId(historyId);
  }
}