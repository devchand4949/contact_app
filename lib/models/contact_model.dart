class UserModel {
  final String id;
  final String name;
  final String contactNo;
  final String email;

  UserModel({
    required this.id,
    required this.name,
    required this.contactNo,
    required this.email,
  });

  // Convert UserModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'contactNo': contactNo,
      'email': email,
    };
  }

  // Create UserModel from JSON
  factory UserModel.fromJson(Map<String, dynamic> json, String id) {
    return UserModel(
      id: id,
      name: json['name'] ?? '',
      contactNo: json['contactNo'] ?? '',
      email: json['email'] ?? '',
    );
  }
}
