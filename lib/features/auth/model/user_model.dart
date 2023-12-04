import 'dart:convert';

import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String? uid;
  final String? name;
  final String? email;
  final String? imageUrl;
  final String? phone;
  final String? location;
  const UserModel(
      {this.uid,
      this.name,
      this.email,
      this.imageUrl,
      this.phone,
      this.location});

  @override
  List<Object?> get props => [uid, name, imageUrl, phone, email, location];

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (uid != null) {
      result.addAll({'uid': uid});
    }
    if (name != null) {
      result.addAll({'name': name});
    }
    if (email != null) {
      result.addAll({'email': email});
    }
    if (imageUrl != null) {
      result.addAll({'imageUrl': imageUrl});
    }
    if (phone != null) {
      result.addAll({'phone': phone});
    }
    if (location != null) {
      result.addAll({'location': location});
    }

    return result;
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      name: map['name'],
      email: map['email'],
      imageUrl: map['imageUrl'],
      phone: map['phone'],
      location: map['location'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));
}
