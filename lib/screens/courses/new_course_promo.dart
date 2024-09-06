part of '../screens.dart';

class NewCoursePromo extends StatelessWidget {
  const NewCoursePromo({super.key, required this.idCourse});

  final int idCourse;
  static const routeName = "/new-course-promo";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('$idCourse'),
      ),
    );
  }
}
