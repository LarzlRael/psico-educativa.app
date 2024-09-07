import 'package:psico_educativa_app/models/models.dart';
import 'package:psico_educativa_app/services/services.dart';
import 'package:psico_educativa_app/shared/validations.dart';

Future<CourseModel?> getCourseById(int idCourse) async {
  final resp =
      await Request.sendAuthRequest(RequestType.get, 'course/course-detail/$idCourse');

  return validateStatus(resp!.statusCode) ? courseModelFromJson(resp.body) : null;
}