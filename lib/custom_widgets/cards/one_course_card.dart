part of '../custom_widgets.dart';

class OneCourseCard extends StatelessWidget {
  const OneCourseCard(
    this.course, {
    super.key,
    required this.onSelected,
  });
  final CourseModel course;
  final Function(int idCourse) onSelected;

  @override
  Widget build(BuildContext context) {
    final courserName = course.courseName;
    final courserDescription = course.courseDescription;
    final courserPrice = course.coursePrice;
    return Container(
      width: 200,
      height: 300,
      decoration: BoxDecoration(
        /* color: Colors.white, */
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          /* BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ), */
        ],
      ),
      child: GestureDetector(
        onTap: () => onSelected(course.id),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              child: FadeInImage(
                width: double.infinity,
                height: 100,
                fit: BoxFit.cover,
                placeholder: const AssetImage(appIcon),
                image: NetworkImage(course.imageUrl == null ||
                        course.imageUrl!.isEmpty
                    ? 'https://fastly.picsum.photos/id/964/200/300.jpg?hmac=4TmUg5VWiMt4hl9NxKOrX4W3N74VEbYJLbFeZbx3-tE'
                    : course.imageUrl!),
              ),
            ),
            SimpleText(
              courserName.length > 30
                  ? '${courserName.substring(0, 30)}...'
                  : courserName,
              fontSize: 16,
              padding: const EdgeInsets.only(bottom: 5, top: 5),
              fontWeight: FontWeight.w700,
            ),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: course.professors.map((professor) {
                  // Verificamos si hay un user en professor
                  final user = professor.user;
                  if (user?.firstName == null || user?.lastName == null) {
                    return const SizedBox();
                  }
                  return SimpleText(
                    '${professor.professionalTitle} ${user?.firstName ?? 'Unknown'} ${user?.lastName ?? 'Unknown'} ',
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                    color: Colors.green,
                  );
                }).toList()),
            SimpleText(
              courserDescription.length > 40
                  ? '${courserDescription.substring(0, 40)}...'
                  : courserDescription,
              padding: const EdgeInsets.only(top: 5),
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            SimpleText(
              '$courserPrice Bs.',
              padding: const EdgeInsets.only(top: 5),
              fontSize: 18,
              fontWeight: FontWeight.w800,
            )
          ],
        ),
      ),
    );
  }
}
