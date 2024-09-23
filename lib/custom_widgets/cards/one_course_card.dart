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
    return FadeIn(
      child: Container(
        width: 200,
        height: 260,
        decoration: BoxDecoration(
          color: Colors.white,
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
              Container(
                margin:
                    const EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SimpleText(
                      (courserName.length > 30
                              ? '${courserName.substring(0, 30)}...'
                              : courserName)
                          .toCapitalize(),
                      fontSize: 16,
                      padding: const EdgeInsets.only(bottom: 5, top: 5),
                      fontWeight: FontWeight.w700,
                    ),
                    /*  Column(
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
                  }).toList()), */
                    SimpleText(
                      (courserDescription.length > 40
                              ? '${courserDescription.substring(0, 40)}...'
                              : courserDescription)
                          .toCapitalize(),
                      padding: const EdgeInsets.only(top: 2.5),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}

class OneCourseCardShimmer extends StatelessWidget {
  const OneCourseCardShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShimmerWidget(
            margin: EdgeInsets.symmetric(vertical: 5),
            shape: ShimmerShape.rounded,
            height: 100,
            borderRadius: 20,
          ),
          ShimmerWidget(
            height: 17,
            margin: EdgeInsets.symmetric(vertical: 5),
            shape: ShimmerShape.rounded,
            borderRadius: 15,
          ),
          ShimmerWidget(
            height: 14,
            borderRadius: 15,
            margin: EdgeInsets.symmetric(vertical: 5),
            shape: ShimmerShape.rounded,
          ),
          ShimmerWidget(
            height: 20,
            width: 50,
            borderRadius: 20,
            margin: EdgeInsets.symmetric(vertical: 5),
            shape: ShimmerShape.rounded,
          ),
        ],
      ),
    );
  }
}
