import 'dart:convert';

CoursesDetailModel coursesDetailModelFromJson(String str) =>
    CoursesDetailModel.fromJson(json.decode(str));

String coursesDetailModelToJson(CoursesDetailModel data) =>
    json.encode(data.toJson());

class CoursesDetailModel {
  final int id;
  final String courseName;
  final String courseDescription;
  final int coursePrice;
  final DateTime startDate;
  final DateTime endDate;
  final int duration;
  final String durationUnit;
  final String modality;
  final String? imageUrl;
  final String? material;
  final String? notes;
  final String? virtualPlatform;
  final String? informationContact;
  final List<ProfessorsCourseDetail> professors;

  CoursesDetailModel({
    required this.id,
    required this.courseName,
    required this.courseDescription,
    required this.coursePrice,
    required this.startDate,
    required this.endDate,
    required this.duration,
    required this.durationUnit,
    required this.modality,
    required this.notes,
    required this.imageUrl,
    required this.material,
    required this.virtualPlatform,
    required this.informationContact,
    required this.professors,
  });

  factory CoursesDetailModel.fromJson(Map<String, dynamic> json) =>
      CoursesDetailModel(
        id: json["id"],
        courseName: json["courseName"],
        courseDescription: json["courseDescription"],
        coursePrice: json["coursePrice"],
        startDate: DateTime.parse(json["startDate"]),
        endDate: DateTime.parse(json["endDate"]),
        duration: json["duration"],
        notes: json["notes"],
        durationUnit: json["durationUnit"],
        modality: json["modality"],
        imageUrl: json["imageUrl"],
        material: json["material"],
        virtualPlatform: json["virtualPlatform"],
        informationContact: json["informationContact"],
        professors: List<ProfessorsCourseDetail>.from(
            json["professors"].map((x) => ProfessorsCourseDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "courseName": courseName,
        "courseDescription": courseDescription,
        "coursePrice": coursePrice,
        "startDate": startDate.toIso8601String(),
        "endDate": endDate.toIso8601String(),
        "duration": duration,
        "durationUnit": durationUnit,
        "modality": modality,
        "imageUrl": imageUrl,
        "virtualPlatform": virtualPlatform,
        "material": material,
        "notes": notes,
        "informationContact": informationContact,
        "professors": List<dynamic>.from(professors.map((x) => x.toJson())),
      };
}

class ProfessorsCourseDetail {
  final int id;
  final String professionalTitle;
  final String expertise;
  final UserCourseDetail? user;

  ProfessorsCourseDetail({
    required this.id,
    required this.professionalTitle,
    required this.expertise,
    required this.user,
  });

  factory ProfessorsCourseDetail.fromJson(Map<String, dynamic> json) =>
      ProfessorsCourseDetail(
        id: json["id"],
        professionalTitle: json["professionalTitle"],
        expertise: json["expertise"],
        user: json["user"] == null ? null : UserCourseDetail.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "professionalTitle": professionalTitle,
        "expertise": expertise,
        "user": user?.toJson(),
      };
}

class UserCourseDetail {
  final String? firstName;
  final String? lastName;
  final String? profileImageUrl;

  UserCourseDetail({
    required this.firstName,
    required this.lastName,
    required this.profileImageUrl,
  });

  factory UserCourseDetail.fromJson(Map<String, dynamic> json) => UserCourseDetail(
        firstName: json["firstName"],
        lastName: json["lastName"],
        profileImageUrl: json["profileImageUrl"],
      );

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "profileImageUrl": profileImageUrl,
      };
}
