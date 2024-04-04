// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Place {
  final String name;
  final double latitude;
  final double longitude;
  final String country;
  Place({
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.country,
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
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'latitude': latitude,
      'longitude': longitude,
      'country': country,
    };
  }

  factory Place.fromMap(Map<String, dynamic> map) {
    return Place(
      name: map['name'] as String,
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
      country: map['country'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Place.fromJson(String source) =>
      Place.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Place(name: $name, latitude: $latitude, longitude: $longitude, country: $country)';
  }

  @override
  bool operator ==(covariant Place other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.latitude == latitude &&
        other.longitude == longitude &&
        other.country == country;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        latitude.hashCode ^
        longitude.hashCode ^
        country.hashCode;
  }
}
