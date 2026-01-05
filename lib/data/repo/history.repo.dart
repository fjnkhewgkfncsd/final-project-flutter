import '../mapper/history.mapper.dart';
import '../../domain/interface/Irepository.interface.dart';
import '../service/controller/history.controller.dart';
import '../../domain/model/history.model.dart';
import '../mapper/historyView.mapper.dart';
import '../../domain/model/historyView.model.dart';

class HistoryRepoImpl implements IHistoryRepo {
  final HistoryController _historyController = HistoryController();

  @override
  Future<History?> getById(int id) async {
    final result = await _historyController.getHistoryById(id);
    return result == null ? null : HistoryMapper.toModel(result);
  }

  @override
  Future<List<History>> getAllHistories() async {
    final results = await _historyController.getAllHistory();
    return results.map((entity) => HistoryMapper.toModel(entity)).toList();
  }

  @override
  Future<int> insertHistory(int quizId) async {
    return await _historyController.insertHistory(quizId);
  }

  @override
  Future<int> deleteHistory(int id) async {
    return await _historyController.deleteHistory(id);
  }

  @override
  Future<List<HistoryViewModel>> getAllHistoryViews() async {
    final results = await _historyController.getAllHistoryViews();
    return results.map((entity) => HistoryViewMapper.toViewModel(entity)).toList();
  }
}