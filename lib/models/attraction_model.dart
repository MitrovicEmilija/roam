import 'dart:convert';

class Attraction {
  final String id;
  final String name;
  final String description;
  final String imageAttr;
  final double rating;
  Attraction({
    required this.id,
    required this.name,
    required this.description,
    required this.imageAttr,
    required this.rating,
  });

  Attraction copyWith({
    String? id,
    String? name,
    String? description,
    String? imageAttr,
    double? rating,
  }) {
    return Attraction(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      imageAttr: imageAttr ?? this.imageAttr,
      rating: rating ?? this.rating,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'imageAttr': imageAttr,
      'rating': rating,
    };
  }

  factory Attraction.fromMap(Map<String, dynamic> map) {
    return Attraction(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      imageAttr: map['imageAttr'] as String,
      rating: map['rating'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory Attraction.fromJson(String source) =>
      Attraction.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Attraction(id: $id, name: $name, description: $description, imageAttr: $imageAttr, rating: $rating)';
  }

  @override
  bool operator ==(covariant Attraction other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.description == description &&
        other.imageAttr == imageAttr &&
        other.rating == rating;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        imageAttr.hashCode ^
        rating.hashCode;
  }
}
