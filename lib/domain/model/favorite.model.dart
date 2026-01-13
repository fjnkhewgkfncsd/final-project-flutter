import './history.model.dart';
class Favorite {
  final int? id;
  final History history;

  const Favorite({
    this.id,
    required this.history,
  });
}