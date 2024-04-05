import 'dart:convert';

class Place {
  final String name;
  final double latitude;
  final double longitude;
  final String country;
  final int rating;
  bool isLiked;
  Place({
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.country,
    required this.rating,
    this.isLiked = false,
  });

  Place copyWith({
    String? name,
    double? latitude,
    double? longitude,
    String? country,
  }) {
    return Place(
      name: name ?? this.name,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      country: country ?? this.country,
      rating: rating,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'latitude': latitude,
      'longitude': longitude,
      'country': country,
      'rating': rating,
    };
  }

  factory Place.fromMap(Map<String, dynamic> map) {
    return Place(
      name: map['name'] as String,
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
      country: map['country'] as String,
      rating: map['rating'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Place.fromJson(String source) =>
      Place.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Place(name: $name, latitude: $latitude, longitude: $longitude, country: $country, rating: $rating)';
  }

  @override
  bool operator ==(covariant Place other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.latitude == latitude &&
        other.longitude == longitude &&
        other.country == country &&
        other.rating == rating;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        latitude.hashCode ^
        longitude.hashCode ^
        country.hashCode ^
        rating.hashCode;
  }
}
