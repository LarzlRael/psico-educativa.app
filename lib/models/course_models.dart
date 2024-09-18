part of 'models.dart';

// To parse this JSON data, do
//
//     final coursesModel = coursesModelFromJson(jsonString);

// To parse this JSON data, do
//
//     final coursesModel = coursesModelFromJson(jsonString);



List<CourseModel> coursesModelFromJson(String str) => List<CourseModel>.from(json.decode(str).map((x) => CourseModel.fromJson(x)));

String coursesModelToJson(List<CourseModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

CourseModel courseModelFromJson(String str) => CourseModel.fromJson(json.decode(str));

class CourseModel {
    final int id;
    final String courseName;
    final String courseDescription;
    final int coursePrice;
    final int duration;
    final String durationUnit;
    final String modality;
    final String? imageUrl;
    final List<ProfessorCourse> professors;

    CourseModel({
        required this.id,
        required this.courseName,
        required this.courseDescription,
        required this.coursePrice,
        required this.duration,
        required this.durationUnit,
        required this.modality,
        required this.imageUrl,
        required this.professors,
    });

    factory CourseModel.fromJson(Map<String, dynamic> json) => CourseModel(
        id: json["id"],
        courseName: json["courseName"],
        courseDescription: json["courseDescription"],
        coursePrice: json["coursePrice"],
        duration: json["duration"],
        durationUnit: json["durationUnit"],
        modality: json["modality"],
        imageUrl: json["imageUrl"],
        professors: List<ProfessorCourse>.from(json["professors"].map((x) => ProfessorCourse.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "courseName": courseName,
        "courseDescription": courseDescription,
        "coursePrice": coursePrice,
        "duration": duration,
        "durationUnit": durationUnit,
        "modality": modality,
        "imageUrl": imageUrl,
        "professors": List<dynamic>.from(professors.map((x) => x.toJson())),
    };
}

class ProfessorCourse {
    final int id;
    final String professionalTitle;
    final UserProfessor? user;

    ProfessorCourse({
        required this.id,
        required this.professionalTitle,
        required this.user,
    });

    factory ProfessorCourse.fromJson(Map<String, dynamic> json) => ProfessorCourse(
        id: json["id"],
        professionalTitle: json["professionalTitle"],
        user: json["user"] == null ? null : UserProfessor.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "professionalTitle": professionalTitle,
        "user": user?.toJson(),
    };
}

class UserProfessor {
    final String? firstName;
    final String? lastName;
    final String? urlImage;

    UserProfessor({
        required this.firstName,
        required this.lastName,
        required this.urlImage,
    });

    factory UserProfessor.fromJson(Map<String, dynamic> json) => UserProfessor(
        firstName: json["firstName"],
        lastName: json["lastName"],
        urlImage: json["urlImage"],
    );

    Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "urlImage": urlImage,
    };
}

