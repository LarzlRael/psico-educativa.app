import 'package:psico_educativa_app/models/models.dart';
import 'package:psico_educativa_app/services/services.dart';

/* TODO improve name funcion */
Future<List<NotificationModel>> getNotificationService() async {
  final resp = await Request.sendRequest(
      RequestType.get, 'notifications/get-notification');
  return notificationsModelFromJson(resp!.body);
}
