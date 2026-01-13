import '../interface/Irepository.interface.dart';
import '../model/history.model.dart';

class HistoryService {
  final IHistoryRepo _historyRepo;

  HistoryService(this._historyRepo);

  Future<List<History>> getAllHistories() async {
    return await _historyRepo.getAllHistories();
  }
  Future<History?> getHistoryById(int id) async {
    return await _historyRepo.getById(id);
  }
  Future<int> addHistory(int quizId) async {
    return await _historyRepo.insertHistory(quizId);
  }
  Future<void> deleteHistory(int id) async {
    await _historyRepo.deleteHistory(id);
  }
}