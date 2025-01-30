import 'package:azlistview/azlistview.dart';

class UserModel extends ISuspensionBean {
  final String id;
  final String name;
  final String contactNo;
  final String email;
  String tagIndex;

  UserModel({
    required this.id,
    required this.name,
    required this.contactNo,
    required this.email,
    this.tagIndex = '',
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'contactNo': contactNo,
      'email': email,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json, String id) {
    return UserModel(
      id: id,
      name: json['name'] ?? '',
      contactNo: json['contactNo'] ?? '',
      email: json['email'] ?? '',
    );
  }

  @override
  String getSuspensionTag() => tagIndex;
}
