import 'dart:convert';
import 'package:flutter/foundation.dart';

import 'package:roam/models/place_model.dart';
import 'package:roam/models/trip_model.dart';

class UserModel {
  final String uid;
  String? email;
  String? username;
  final String profilePic;
  final bool isAuthenticated;
  final List<Place> preferences;
  final List<Trip> trips;
  UserModel({
    required this.uid,
    required this.profilePic,
    required this.isAuthenticated,
    required this.preferences,
    required this.trips,
    this.email,
    this.username,
  });

  UserModel copyWith(
      {String? uid,
      String? email,
      String? username,
      String? profilePic,
      bool? isAuthenticated,
      List<Place>? preferences,
      List<Trip>? trips}) {
    return UserModel(
        uid: uid ?? this.uid,
        email: email ?? this.email,
        username: username ?? this.username,
        profilePic: profilePic ?? this.profilePic,
        isAuthenticated: isAuthenticated ?? this.isAuthenticated,
        preferences: preferences ?? this.preferences,
        trips: trips ?? this.trips);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'email': email,
      'username': username,
      'profilePic': profilePic,
      'isAuthenticated': isAuthenticated,
      'preferences': preferences.map((x) => x.toMap()).toList(),
      'trips': trips.map((y) => y.toMap()).toList()
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] as String,
      email: map['email'] as String?,
      username: map['username'] as String?,
      profilePic: map['profilePic'] as String,
      isAuthenticated: map['isAuthenticated'] as bool,
      preferences: (map['preferences'] as List<dynamic>?)
              ?.map<Place>((x) => Place.fromMap(x as Map<String, dynamic>))
              .toList() ??
          [],
      trips: (map['trips'] as List<dynamic>?)
              ?.map<Trip>((y) => Trip.fromMap(y as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(uid: $uid, email: $email, username: $username, profilePic: $profilePic, isAuthenticated: $isAuthenticated, preferences: $preferences, trips: $trips)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.email == email &&
        other.username == username &&
        other.profilePic == profilePic &&
        other.isAuthenticated == isAuthenticated &&
        listEquals(other.preferences, preferences) &&
        listEquals(other.trips, trips);
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        email.hashCode ^
        username.hashCode ^
        profilePic.hashCode ^
        isAuthenticated.hashCode ^
        preferences.hashCode ^
        trips.hashCode;
  }
}
