import 'dart:convert';
import 'package:flutter/foundation.dart';

class Trip {
  final String id;
  final String placeName;
  final String name;
  final DateTime date;
  bool isSolo;
  List<String> members;
  Trip({
    required this.id,
    required this.placeName,
    required this.name,
    required this.date,
    required this.isSolo,
    required this.members,
  });

  Trip copyWith({
    String? id,
    String? name,
    String? placeName,
    DateTime? date,
    bool? isSolo,
    List<String>? members,
  }) {
    return Trip(
      id: id ?? this.id,
      name: name ?? this.name,
      placeName: placeName ?? this.placeName,
      date: date ?? this.date,
      isSolo: isSolo ?? this.isSolo,
      members: members ?? this.members,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'placeName': placeName,
      'date': date.millisecondsSinceEpoch,
      'isSolo': isSolo,
      'members': members,
    };
  }

  factory Trip.fromMap(Map<String, dynamic> map) {
    return Trip(
      id: map['id'] as String,
      name: map['name'] as String,
      placeName: map['placeName'] as String,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      isSolo: map['isSolo'] as bool,
      members: List<String>.from(map['members'] ?? []),
    );
  }

  String toJson() => json.encode(toMap());

  factory Trip.fromJson(String source) =>
      Trip.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Trip(id: $id, name: $name, placeName: $placeName, date: $date, isSolo: $isSolo, members: $members)';
  }

  @override
  bool operator ==(covariant Trip other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.placeName == placeName &&
        other.date == date &&
        other.isSolo == isSolo &&
        listEquals(other.members, members);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        placeName.hashCode ^
        date.hashCode ^
        isSolo.hashCode ^
        members.hashCode;
  }
}
