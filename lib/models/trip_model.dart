import 'dart:convert';
import 'package:flutter/foundation.dart';

class Trip {
  final String id;
  final String placeName;
  final String name;
  final DateTime dateFrom;
  final DateTime dateTo;
  bool isSolo;
  final String creatorUid;
  List<String> members;
  Trip({
    required this.id,
    required this.placeName,
    required this.name,
    required this.dateFrom,
    required this.dateTo,
    required this.isSolo,
    required this.creatorUid,
    required this.members,
  });

  Trip copyWith({
    String? id,
    String? name,
    String? placeName,
    DateTime? dateFrom,
    DateTime? dateTo,
    bool? isSolo,
    String? creatorUid,
    List<String>? members,
  }) {
    return Trip(
      id: id ?? this.id,
      name: name ?? this.name,
      placeName: placeName ?? this.placeName,
      dateFrom: dateFrom ?? this.dateFrom,
      dateTo: dateTo ?? this.dateTo,
      isSolo: isSolo ?? this.isSolo,
      creatorUid: creatorUid ?? this.creatorUid,
      members: members ?? this.members,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'placeName': placeName,
      'dateFrom': dateFrom.millisecondsSinceEpoch,
      'dateTo': dateTo.millisecondsSinceEpoch,
      'isSolo': isSolo,
      'creatorUid': creatorUid,
      'members': members,
    };
  }

  factory Trip.fromMap(Map<String, dynamic> map) {
    return Trip(
      id: map['id'] as String,
      name: map['name'] as String,
      placeName: map['placeName'] as String,
      dateFrom: DateTime.fromMillisecondsSinceEpoch(map['dateFrom'] as int),
      dateTo: DateTime.fromMillisecondsSinceEpoch(map['dateTo'] as int),
      isSolo: map['isSolo'] as bool,
      creatorUid: map['creatorUid'] as String,
      members: List<String>.from(map['members'] ?? []),
    );
  }

  String toJson() => json.encode(toMap());

  factory Trip.fromJson(String source) =>
      Trip.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Trip(id: $id, name: $name, placeName: $placeName, dateFrom: $dateFrom, dateTo: $dateTo,  isSolo: $isSolo, creatorUid: $creatorUid, members: $members)';
  }

  @override
  bool operator ==(covariant Trip other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.placeName == placeName &&
        other.dateFrom == dateFrom &&
        other.dateTo == dateTo &&
        other.isSolo == isSolo &&
        other.creatorUid == creatorUid &&
        listEquals(other.members, members);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        placeName.hashCode ^
        dateFrom.hashCode ^
        dateTo.hashCode ^
        isSolo.hashCode ^
        creatorUid.hashCode ^
        members.hashCode;
  }
}
