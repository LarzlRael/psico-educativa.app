part of '../screens.dart';

class NewCoursePromoScreen extends HookConsumerWidget {
  final int idCourse;
  static const routeName = "/new-course-promo";

  const NewCoursePromoScreen({super.key, required this.idCourse});

  @override
  Widget build(BuildContext context, ref) {
    final courseNotifierProviderN = ref.watch(courseNotifierProvider.notifier);
    final courseState = ref.watch(courseNotifierProvider);
    useEffect(() {
      /* courseNotifierProviderN.getCourseDetails(idCourse).then((value) {}); */
      Future.microtask(
          () => courseNotifierProviderN.getCourseDetails(idCourse));
    }, []);
    return Scaffold(
        body: courseState.isLoading
            ? SizedBox.expand(child: Center(child: CircularProgressIndicator()))
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('${courseState.counter}'),
                  Text('${courseState.courseSelected?.id}'),
                  Text('${courseState.courseSelected?.courseName}'),
                  TextButton(
                      onPressed: () {
                        ref
                            .read(courseNotifierProvider.notifier)
                            .clearCurrentCourse();
                        inspect(courseState);
                        print(
                            "Estado después de limpiar: ${courseState.courseSelected}");
                      },
                      child: Text('limpiar current course')),
                  TextButton(
                      onPressed: () {
                        ref
                            .read(courseNotifierProvider.notifier)
                            .addCounterPLus1();
                        
                        print(
                            "Estado después de limpiar: ${courseState.courseSelected}");
                      },
                      child: Text('Aumentar +1'))
                ],
              ));
  }
}
