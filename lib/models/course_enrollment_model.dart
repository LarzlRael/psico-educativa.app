part of 'models.dart';

// To parse this JSON data, do
//
//     final courseEnrollmentModel = courseEnrollmentModelFromJson(jsonString);



CourseEnrollmentModel courseEnrollmentModelFromJson(String str) => CourseEnrollmentModel.fromJson(json.decode(str));

String courseEnrollmentModelToJson(CourseEnrollmentModel data) => json.encode(data.toJson());

class CourseEnrollmentModel {
    final int id;
    final String courseName;
    final String courseDescription;
    final int coursePrice;
    final DateTime startDate;
    final DateTime endDate;
    final int duration;
    final String durationUnit;
    final String modality;
    final String imageUrl;
    final String publicImageId;
    final String requirements;
    final dynamic material;
    final String informationContact;
    final String notes;
    final String status;
    final List<Professor> professors;
    final Form form;

    CourseEnrollmentModel({
        required this.id,
        required this.courseName,
        required this.courseDescription,
        required this.coursePrice,
        required this.startDate,
        required this.endDate,
        required this.duration,
        required this.durationUnit,
        required this.modality,
        required this.imageUrl,
        required this.publicImageId,
        required this.requirements,
        required this.material,
        required this.informationContact,
        required this.notes,
        required this.status,
        required this.professors,
        required this.form,
    });

    factory CourseEnrollmentModel.fromJson(Map<String, dynamic> json) => CourseEnrollmentModel(
        id: json["id"],
        courseName: json["courseName"],
        courseDescription: json["courseDescription"],
        coursePrice: json["coursePrice"],
        startDate: DateTime.parse(json["startDate"]),
        endDate: DateTime.parse(json["endDate"]),
        duration: json["duration"],
        durationUnit: json["durationUnit"],
        modality: json["modality"],
        imageUrl: json["imageUrl"],
        publicImageId: json["publicImageId"],
        requirements: json["requirements"],
        material: json["material"],
        informationContact: json["informationContact"],
        notes: json["notes"],
        status: json["status"],
        professors: List<Professor>.from(json["professors"].map((x) => Professor.fromJson(x))),
        form: Form.fromJson(json["form"]),
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
        "publicImageId": publicImageId,
        "requirements": requirements,
        "material": material,
        "informationContact": informationContact,
        "notes": notes,
        "status": status,
        "professors": List<dynamic>.from(professors.map((x) => x.toJson())),
        "form": form.toJson(),
    };
}

class Form {
    final int id;
    final String name;
    final List<Field> fields;

    Form({
        required this.id,
        required this.name,
        required this.fields,
    });

    factory Form.fromJson(Map<String, dynamic> json) => Form(
        id: json["id"],
        name: json["name"],
        fields: List<Field>.from(json["fields"].map((x) => Field.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "fields": List<dynamic>.from(fields.map((x) => x.toJson())),
    };
}

class Field {
    final int id;
    final String name;
    final String type;
    final dynamic placeholder;
    final String label;
    final dynamic value;

    Field({
        required this.id,
        required this.name,
        required this.type,
        required this.placeholder,
        required this.label,
        required this.value,
    });

    factory Field.fromJson(Map<String, dynamic> json) => Field(
        id: json["id"],
        name: json["name"],
        type: json["type"],
        placeholder: json["placeholder"],
        label: json["label"],
        value: json["value"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "type": type,
        "placeholder": placeholder,
        "label": label,
        "value": value,
    };
}

class Professor {
    final int id;
    final String professionalTitle;
    final String expertise;
    final ProfessorUser user;

    Professor({
        required this.id,
        required this.professionalTitle,
        required this.expertise,
        required this.user,
    });

    factory Professor.fromJson(Map<String, dynamic> json) => Professor(
        id: json["id"],
        professionalTitle: json["professionalTitle"],
        expertise: json["expertise"],
        user: ProfessorUser.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "professionalTitle": professionalTitle,
        "expertise": expertise,
        "user": user.toJson(),
    };
}

class ProfessorUser {
    final int id;
    final String username;
    final String email;
    final String? firstName;
    final dynamic lastName;
    final dynamic location;
    final String password;
    final DateTime createdAt;
    final String authStrategy;
    final dynamic phone;
    final dynamic profileImageUrl;
    final dynamic profileImageId;
    final dynamic shippingAddress;
    final dynamic address;

    ProfessorUser({
        required this.id,
        required this.username,
        required this.email,
        required this.firstName,
        required this.lastName,
        required this.location,
        required this.password,
        required this.createdAt,
        required this.authStrategy,
        required this.phone,
        required this.profileImageUrl,
        required this.profileImageId,
        required this.shippingAddress,
        required this.address,
    });

    factory ProfessorUser.fromJson(Map<String, dynamic> json) => ProfessorUser(
        id: json["id"],
        username: json["username"],
        email: json["email"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        location: json["location"],
        password: json["password"],
        createdAt: DateTime.parse(json["createdAt"]),
        authStrategy: json["authStrategy"],
        phone: json["phone"],
        profileImageUrl: json["profileImageUrl"],
        profileImageId: json["profileImageId"],
        shippingAddress: json["shippingAddress"],
        address: json["address"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
        "location": location,
        "password": password,
        "createdAt": createdAt.toIso8601String(),
        "authStrategy": authStrategy,
        "phone": phone,
        "profileImageUrl": profileImageUrl,
        "profileImageId": profileImageId,
        "shippingAddress": shippingAddress,
        "address": address,
    };
}
