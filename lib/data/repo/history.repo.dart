import '../mapper/history.mapper.dart';
import '../../domain/interface/Irepository.interface.dart';
import '../service/controller/history.controller.dart';
import '../../domain/model/history.model.dart';

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
  Future<int> insertHistory(History history) async {
    final entiry = HistoryMapper.toEntity(history);
    return await _historyController.insertHistory(entiry);
  }

  @override
  Future<int> deleteHistory(int id) async {
    return await _historyController.deleteHistory(id);
  }
}