import 'dart:developer';

import 'package:psico_educativa_app/services/courses_service.dart'
    as CoursesService;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:psico_educativa_app/models/models.dart';

import '../services/services.dart';

final courseNotifierProvider =
    StateNotifierProvider<CourseNotifier, CoursesState>(
  (ref) => CourseNotifier(ref),
);

class CourseNotifier extends StateNotifier<CoursesState> {
  final Ref ref; // Añade `Ref`

  CourseNotifier(this.ref)
      : super(CoursesState(
          courses: [],
          courseSelected: null,
          isLoading: false,
        )) {}

  Future<void> getCourseDetails(int idCourse) async {
    state = state.copyWith(isLoading: true);
    /* final getCourseInfo = await CoursesService.getCourseById(idCourser); */
    final getCourseInfo = await sendGenericRequest<CourseModel>(
        'course/course-detail/$idCourse', courseModelFromJson);
    inspect(getCourseInfo);
    state = state.copyWith(isLoading: false, courseSelected: getCourseInfo);
  }
}

class CoursesState {
  final List<CourseModel> courses;
  final CourseModel? courseSelected;
  final bool isLoading;

  CoursesState(
      {this.courseSelected, required this.isLoading, required this.courses});

  CoursesState copyWith({
    List<CourseModel>? courses,
    CourseModel? courseSelected,
    bool? isLoading,
  }) {
    return CoursesState(
      /* message: message ?? this.message, */
      courses: courses ?? this.courses,
      courseSelected: courseSelected ?? this.courseSelected,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
