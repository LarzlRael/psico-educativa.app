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
            courses: [], courseSelected: null, isLoading: false, counter: 0)) {}

  Future<void> getCourseDetails(int idCourse) async {
    state = state.copyWith(isLoading: true);
    /* final getCourseInfo = await CoursesService.getCourseById(idCourser); */
    final getCourseInfo = await sendGenericRequest<CourseModel>(
        'course/course-detail/$idCourse', courseModelFromJson);
    inspect(getCourseInfo);
    state = state.copyWith(isLoading: false, courseSelected: getCourseInfo);
  }

  void clearCurrentCourse() {
    print('limpirando estado');
    state = state.copyWith(isLoading: false, courseSelected: null);
    inspect(state);
  }

  void addCounterPLus1() {
    state = state.copyWith(counter: state.counter + 1);
  }

  void getCourses()async{
  state = state.copyWith(isLoading: true);
    /* final getCourseInfo = await CoursesService.getCourseById(idCourser); */
    final getCourseInfo = await sendGenericRequest<List<CourseModel>>(
        'course', coursesModelFromJson);
    inspect(getCourseInfo);
    state = state.copyWith(isLoading: false, courses: getCourseInfo);
  }
}

class CoursesState {
  final List<CourseModel> courses;
  final CourseModel? courseSelected;
  final bool isLoading;
  final int counter;

  CoursesState({
    this.courseSelected,
    required this.isLoading,
    required this.courses,
    required this.counter,
  });

  CoursesState copyWith(
      {List<CourseModel>? courses,
      CourseModel? courseSelected,
      bool? isLoading,
      int? counter}) {
    return CoursesState(
      /* message: message ?? this.message, */
      courses: courses ?? this.courses,
      courseSelected: courseSelected ?? this.courseSelected,
      isLoading: isLoading ?? this.isLoading,
      counter: counter ?? this.counter,
    );
  }
}
