part of 'models.dart';


List<CourseModel> coursesModelFromJson(String str) => List<CourseModel>.from(json.decode(str).map((x) => CourseModel.fromJson(x)));

String coursesModelToJson(List<CourseModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

CourseModel courseModelFromJson(String str) => CourseModel.fromJson(json.decode(str));

String courseModelToJson(CourseModel data) => json.encode(data.toJson());

class CourseModel {
    final int id;
    final String courseName;
    final String courseDescription;
    final int coursePrice;
    final DateTime startDate;
    final DateTime endDate;
    final int duration;
    final String? imageUrl;
    final String? publicImageId;
    final String requirements;
    final String status;

    CourseModel({
        required this.id,
        required this.courseName,
        required this.courseDescription,
        required this.coursePrice,
        required this.startDate,
        required this.endDate,
        required this.duration,
        required this.imageUrl,
        required this.publicImageId,
        required this.requirements,
        required this.status,
    });

    factory CourseModel.fromJson(Map<String, dynamic> json) => CourseModel(
        id: json["id"],
        courseName: json["courseName"],
        courseDescription: json["courseDescription"],
        coursePrice: json["coursePrice"],
        startDate: DateTime.parse(json["startDate"]),
        endDate: DateTime.parse(json["endDate"]),
        duration: json["duration"],
        imageUrl: json["imageUrl"],
        publicImageId: json["publicImageId"],
        requirements: json["requirements"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "courseName": courseName,
        "courseDescription": courseDescription,
        "coursePrice": coursePrice,
        "startDate": startDate.toIso8601String(),
        "endDate": endDate.toIso8601String(),
        "duration": duration,
        "imageUrl": imageUrl,
        "publicImageId": publicImageId,
        "requirements": requirements,
        "status": status,
    };
}
