import 'package:json_annotation/json_annotation.dart';
import 'package:mongo_dart/mongo_dart.dart';

class UserModel {
  UserModel({
    required this.id,
    required this.name,
    required this.age,
    required this.phone,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'].toString(),
      id: json['_id'] as ObjectId,
      age: json['age'].toString(),
      phone: json['phone'].toString(),
    );
  }

  @JsonKey(name: '_id')
  final ObjectId id;
  final String name;
  final String age;
  final String phone;

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'name': name,
      'age': age,
      'phone': phone,
    };
  }
  //
  // factory UserModel.fromJson(Map<String, dynamic> json) =>
  //     _$UserModelFromJson(json);
  //
  // Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
