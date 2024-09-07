
import 'package:go_router/go_router.dart';
import 'package:psico_educativa_app/models/models.dart';
import 'package:psico_educativa_app/screens/screens.dart';

void goNotificationDestinyPage(
  GoRouter appRouter,
  Data? notificationData,
) {
  switch (notificationData?.pageDestination) {
    case 'new-course-promo':
      appRouter.push(
          '${NewCoursePromoScreen.routeName}/${notificationData?.idCourse}');
      break;
    /* case 'new_offer':
      context.push('/auction_with_offerPage/${notification.idHomework}');
      break;
    case 'homework_finished':
      context.push('/my_homeworks_page', extra: 1);
      break;
    case 'offer_accepted':
      context.push('/pending_homeworks_offers_accepts');
      break; */
    default:
  }
}
