import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

class UserModel {
  UserModel({
    required this.name,
    required this.age,
    required this.phoneNo,
    this.userId,
  });

  factory UserModel.fromJson(QueryDocumentSnapshot<Map<String, dynamic>> json) {
    final data = json.data();
    return UserModel(
      userId: json.id,
      name: data['name'] as String,
      age: data['age'] as int,
      phoneNo: data['phone_no'] as String,
    );
    // return _$UserModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'age': age,
      'phone_no': phoneNo,
    };
  }

  String? userId;
  String? name;
  int age;
  @JsonKey(name: 'phone_no')
  String phoneNo;
}
