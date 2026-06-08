class Character {
  final int id;
  final String name;
  final String image;
  final String status;
  final String species;
  final bool isFavorite;

  Character({
    required this.id,
    required this.name,
    required this.image,
    required this.status,
    required this.species,
    this.isFavorite = false,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      status: json['status'],
      species: json['species'],
    );
  }

  Character copyWith({bool? isFavorite}) {
    return Character(
      id: id,
      name: name,
      image: image,
      status: status,
      species: species,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}