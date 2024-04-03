import 'dart:convert';
import 'package:flutter/foundation.dart';

import 'package:roam/models/attraction_model.dart';

class Place {
  final String id;
  final String name;
  final String description;
  final String placeImg;
  final String country;
  final double rating;
  final List<Attraction> attractions;
  Place({
    required this.id,
    required this.name,
    required this.description,
    required this.placeImg,
    required this.country,
    required this.rating,
    required this.attractions,
  });

  Place copyWith({
    String? id,
    String? name,
    String? description,
    String? placeImg,
    String? country,
    double? rating,
    List<Attraction>? attractions,
  }) {
    return Place(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      placeImg: placeImg ?? this.placeImg,
      country: country ?? this.country,
      rating: rating ?? this.rating,
      attractions: attractions ?? this.attractions,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'placeImg': placeImg,
      'country': country,
      'rating': rating,
      'attractions': attractions.map((x) => x.toMap()).toList(),
    };
  }

  factory Place.fromMap(Map<String, dynamic> map) {
    return Place(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      placeImg: map['placeImg'] as String,
      country: map['country'] as String,
      rating: map['rating'] as double,
      attractions: List<Attraction>.from(
        (map['attractions'] as List<int>).map<Attraction>(
          (x) => Attraction.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Place.fromJson(String source) =>
      Place.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Place(id: $id, name: $name, description: $description, placeImg: $placeImg, country: $country, rating: $rating, attractions: $attractions)';
  }

  @override
  bool operator ==(covariant Place other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.description == description &&
        other.placeImg == placeImg &&
        other.country == country &&
        other.rating == rating &&
        listEquals(other.attractions, attractions);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        placeImg.hashCode ^
        country.hashCode ^
        rating.hashCode ^
        attractions.hashCode;
  }
}
