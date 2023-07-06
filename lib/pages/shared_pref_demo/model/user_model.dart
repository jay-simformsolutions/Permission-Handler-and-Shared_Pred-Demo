class UserModel {
  const UserModel({
    required this.name,
    required this.location,
    required this.age,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'].toString(),
      age: json['age'].toString(),
      location: json['location'].toString(),
    );
  }

  final String name;
  final String age;
  final String location;

  Map<String, dynamic> toJson() => {
        'name': name,
        'age': age,
        'location': location,
      };
}
