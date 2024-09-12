// To parse this JSON data, do
//
//     final userApi = userApiFromJson(jsonString);

part of 'models.dart';

// To parse this JSON data, do
//
//     final userApi = userApiFromJson(jsonString);

UserApi userApiFromJson(String str) => UserApi.fromJson(json.decode(str));

String userApiToJson(UserApi data) => json.encode(data.toJson());

class UserApi {
  final int id;
  final String username;
  final String email;
  final String? firstName; // Cambiado a String?
  final String? lastName; // Cambiado a String?
  final String? location; // Cambiado a String?
  final DateTime createdAt;
  final String? phone; // Cambiado a String?
  final String? profileImageUrl; // Cambiado a String?
  final String? profileImageId; // Cambiado a String?
  final String? shippingAddress; // Cambiado a String?
  final String? address; // Cambiado a String?
  final List<String> roles;
  final String accessToken;

  UserApi({
    required this.id,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.location,
    required this.createdAt,
    required this.phone,
    required this.profileImageUrl,
    required this.profileImageId,
    required this.shippingAddress,
    required this.address,
    required this.roles,
    required this.accessToken,
  });

  factory UserApi.fromJson(Map<String, dynamic> json) => UserApi(
        id: json["id"],
        username: json["username"],
        email: json["email"],
        firstName: json["firstName"] ?? "", // Manejo de nulos
        lastName: json["lastName"] ?? "",
        location: json["location"] ?? "",
        createdAt: DateTime.parse(json["createdAt"]),
        phone: json["phone"] ?? "",
        profileImageUrl: json["profileImageUrl"] ?? "",
        profileImageId: json["profileImageId"] ?? "",
        shippingAddress: json["shippingAddress"] ?? "",
        address: json["address"] ?? "",
        roles: List<String>.from(json["roles"].map((x) => x)),
        accessToken: json["accessToken"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
        "firstName": firstName ?? "", // Manejo de nulos
        "lastName": lastName ?? "",
        "location": location ?? "",
        "createdAt": createdAt.toIso8601String(),
        "phone": phone ?? "",
        "profileImageUrl": profileImageUrl ?? "",
        "profileImageId": profileImageId ?? "",
        "shippingAddress": shippingAddress ?? "",
        "address": address ?? "",
        "roles": List<dynamic>.from(roles.map((x) => x)),
        "accessToken": accessToken,
      };
}
