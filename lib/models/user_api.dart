// To parse this JSON data, do
//
//     final userApi = userApiFromJson(jsonString);

part of 'models.dart';

UserApi userApiFromJson(String str) => UserApi.fromJson(json.decode(str));

String userApiToJson(UserApi data) => json.encode(data.toJson());

class UserApi {
  final int id;
  final String username;
  final DateTime createdAt;
  final dynamic phone;
  final dynamic profileImageUrl;
  final dynamic profileImageId;
  final List<String> roles;
  final String accessToken;

  UserApi({
    required this.id,
    required this.username,
    required this.createdAt,
    required this.phone,
    required this.profileImageUrl,
    required this.profileImageId,
    required this.roles,
    required this.accessToken,
  });

  factory UserApi.fromJson(Map<String, dynamic> json) => UserApi(
        id: json["id"],
        username: json["username"],
        createdAt: DateTime.parse(json["createdAt"]),
        phone: json["phone"],
        profileImageUrl: json["profileImageUrl"],
        profileImageId: json["profileImageId"],
        roles: List<String>.from(json["roles"].map((x) => x)),
        accessToken: json["accessToken"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "createdAt": createdAt.toIso8601String(),
        "phone": phone,
        "profileImageUrl": profileImageUrl,
        "profileImageId": profileImageId,
        "roles": List<dynamic>.from(roles.map((x) => x)),
        "accessToken": accessToken,
      };
}
