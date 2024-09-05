part of 'models.dart';

// To parse this JSON data, do
//
//     final payloadNotificationModel = payloadNotificationModelFromJson(jsonString);

PayloadNotificationModel payloadNotificationModelFromJson(String str) =>
    PayloadNotificationModel.fromJson(json.decode(str));

String payloadNotificationModelToJson(PayloadNotificationModel data) =>
    json.encode(data.toJson());

class PayloadNotificationModel {
  final String idCourse;
  final String notificationType;
  final String pageDestination;

  PayloadNotificationModel({
    required this.idCourse,
    required this.notificationType,
    required this.pageDestination,
  });

  factory PayloadNotificationModel.fromJson(Map<String, dynamic> json) =>
      PayloadNotificationModel(
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
