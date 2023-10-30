import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart' ;
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationApi {
  static final _notification = FlutterLocalNotificationsPlugin();
  static final onNotifications = BehaviorSubject<String?>();

  static Future _notificationDetails() async {
    return NotificationDetails(
        android: AndroidNotificationDetails('channel id', 'channel name',
            importance: Importance.max));
  }

  static Future init({bool initScheduled = false}) async {
    tz.initializeTimeZones();
    final android = AndroidInitializationSettings('@mipmap/ic_launcher');
    final settings = InitializationSettings(android: android);
    await _notification.initialize(settings,
        onSelectNotification: ((payload) async {
      onNotifications.add(payload);
    }));
  }

  static Future showNotification(
          {int id = 0, String? title, String? body, String? payload}) async =>
      _notification.show(id,
       title,
       body,
       await _notificationDetails(),
       payload: payload);


  static Future showScheduledNotification(
          {int id = 0, String? title, String? body, String? payload,required DateTime scheduledDate}) async =>
      _notification.zonedSchedule(id,
       title,
       body,
       tz.TZDateTime.from(scheduledDate,tz. local),
       await _notificationDetails(),
       payload: payload,
       androidAllowWhileIdle: true,
       uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,  
       matchDateTimeComponents: DateTimeComponents.time, 
       );
}
