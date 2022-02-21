import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationApi {
  static final _notification = FlutterLocalNotificationsPlugin();
  static final onNotifications = BehaviorSubject<String?>();

  static Future _notificationDetails() async {
    return const NotificationDetails(
        android: AndroidNotificationDetails(
          'channel id',
          'channel name',
          'channel description',
          importance: Importance.max,
        ),
        iOS: IOSNotificationDetails());
  }

  Future init({bool initScheduled = false}) async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios = IOSInitializationSettings();
    const settings = InitializationSettings(android: android, iOS: ios);

    ///when app is closed
    final details = await _notification.getNotificationAppLaunchDetails();
    if (details?.payload != null && details!.didNotificationLaunchApp) {
      onNotifications.add(details.payload);
    }

    tz.initializeTimeZones();
    final localtimezone = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(localtimezone));
    await _notification.initialize(settings,
        onSelectNotification: (payload) async {
      onNotifications.add(payload);
    });
  }

  static Future showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async =>
      _notification.show(id, title, body, await _notificationDetails(),
          payload: payload);

  Future showScheduleNotification(
          {int id = 0,
          String? title,
          String? body,
          String? payload,
          required DateTime scheduledDate}) async =>
      _notification.zonedSchedule(
          id,
          title,
          body,
          tz.TZDateTime.from(scheduledDate, tz.local),
          await _notificationDetails(),
          payload: payload,
          androidAllowWhileIdle: true,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime);

  void cancelAll() => _notification.cancelAll();
}
