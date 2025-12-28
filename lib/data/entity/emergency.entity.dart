class Emergency {
  final int id;
  final String name;
  final String image;

  const Emergency({
    required this.id,
    required this.name,
    required this.image,
  });

  factory Emergency.fromMap(Map<String, dynamic> map) {
    return Emergency(
      id: map['emergencyId'],
      name: map['emergencyName'],
      image: map['emergencyImage'],
    );
  }
}