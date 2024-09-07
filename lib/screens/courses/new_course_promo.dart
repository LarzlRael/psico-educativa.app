part of '../screens.dart';

class NewCoursePromoScreen extends HookConsumerWidget {
  final int idCourse;
  static const routeName = "/new-course-promo";

  const NewCoursePromoScreen({super.key, required this.idCourse});

  @override
  Widget build(BuildContext context, ref) {
    final courseNotifierProviderN = ref.watch(courseNotifierProvider.notifier);
    final courseState = ref.read(courseNotifierProvider);
    useEffect(() {
      /* courseNotifierProviderN.getCourseDetails(idCourse).then((value) {}); */
      Future.microtask(
          () => courseNotifierProviderN.getCourseDetails(idCourse));
    }, []);
    return Scaffold(
        body: courseState.isLoading
            ? Container(child: Center(child: CircularProgressIndicator()))
            : Column(
                children: [
                  Text('${courseState.courseSelected?.id}'),
                  Text('${courseState.courseSelected?.courseName}'),
                ],
              ));
  }
}
