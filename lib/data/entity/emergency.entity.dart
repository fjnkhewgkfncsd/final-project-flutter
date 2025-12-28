class EmergencyEntity {
  final int id;
  final String name;
  final String image;

  const EmergencyEntity({
    required this.id,
    required this.name,
    required this.image,
  });

  factory EmergencyEntity.fromMap(Map<String, dynamic> map) {
    return EmergencyEntity(
      id: map['emergencyId'],
      name: map['emergencyName'],
      image: map['emergencyImage'],
    );
  }
}