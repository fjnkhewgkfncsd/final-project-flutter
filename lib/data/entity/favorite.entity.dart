class Favorite {
  final int id;
  final int historyId;

  const Favorite({
    required this.id,
    required this.historyId,
  });
  factory Favorite.fromMap(Map<String, dynamic> map) {
    return Favorite(
      id: map['id'],
      historyId: map['historyId'],
    );
  }
}