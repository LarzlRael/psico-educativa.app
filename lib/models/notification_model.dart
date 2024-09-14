
part of 'models.dart';

// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);
List<NotificationModel> notificationsModelFromJson(String str) => List<NotificationModel>.from(json.decode(str).map((x) => NotificationModel.fromJson(x)));
String notificationsModelToJson(List<NotificationModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

NotificationModel oneNotificationFromJson(String str) => NotificationModel.fromJson(json.decode(str));
String oneNotificationModelToJson(NotificationModel data) => json.encode(data.toJson());


Data oneDataFromJson(String str) => Data.fromJson(json.decode(str));

String oneDataToJson(Data data) => json.encode(data.toJson());

class NotificationModel {
    final String title;
    final String body;
    final String? imageUrl;
    final Data? data;
    final int id;
    final bool read;
    final int status;
    final bool visible;
    final DateTime createdAt;

    NotificationModel({
        required this.title,
        required this.body,
        required this.imageUrl,
        required this.data,
        required this.id,
        required this.read,
        required this.status,
        required this.visible,
        required this.createdAt,
    });

    factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
        title: json["title"],
        body: json["body"],
        imageUrl: json["imageUrl"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        id: json["id"],
        read: json["read"],
        status: json["status"],
        visible: json["visible"],
        createdAt: DateTime.parse(json["createdAt"]),
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "body": body,
        "imageUrl": imageUrl,
        "data": data?.toJson(),
        "id": id,
        "read": read,
        "status": status,
        "visible": visible,
        "createdAt": createdAt.toIso8601String(),
    };
}

class Data {
  final String? idCourse;
  final String? notificationType;
  final String? pageDestination;

  Data({
    this.idCourse,
    this.notificationType,
    this.pageDestination,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        idCourse: json["idCourse"],
        notificationType: json["notificationType"],
        pageDestination: json["pageDestination"],
  );

  Map<String, dynamic> toJson() => {
        "idCourse": idCourse,
        "notificationType": notificationType,
        "pageDestination": pageDestination,
  };
}
