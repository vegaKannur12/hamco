import 'package:flutter/material.dart';
import 'package:hamco/screen/notification/notificationApi.dart';
import 'package:hamco/screen/notification/secondScreen.dart';

class NotificationButtonScreen extends StatefulWidget {
  const NotificationButtonScreen({Key? key}) : super(key: key);

  @override
  State<NotificationButtonScreen> createState() =>
      _NotificationButtonScreenState();
}

class _NotificationButtonScreenState extends State<NotificationButtonScreen> {
  int i = 5;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    NotificationApi.init();
    listenNotifications();
    // if (i == 5) {
    //   NotificationApi.showNotification(
    //       title: "anusha", body: "njfdkjfkjdnk", payload: "kjdzfjk");
    // }
  }

  void listenNotifications() {
    NotificationApi.onNotifications.stream.listen(onClickedNotification);
  }

  void onClickedNotification(String? payload) => Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SecondScreen(
                  payload: payload!,
                )),
      );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("notication"),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 300,
              child: ElevatedButton(
                  onPressed: () => NotificationApi.showNotification(
                      title: "anusha",
                      body: "njfdkjfkjdnk",
                      payload: "kjdzfjk"),
                  child: Text("simple notification")),
            ),
            Container(
              width: 300,
              child: ElevatedButton(
                  onPressed: () {
                    NotificationApi.showScheduledNotification(
                        title: 'Dinner',
                        body: "tody at 6pm",
                        payload: 'dinner_6pm',
                        scheduledDate:
                            DateTime.now().add(Duration(seconds: 12)));

                    final snackBar = SnackBar(
                      content: Text(
                        "Scheduled in 12 sec",
                        style: TextStyle(fontSize: 23),
                      ),
                      backgroundColor: Colors.green,
                    );
                    ScaffoldMessenger.of(context)
                      ..removeCurrentSnackBar()
                      ..showSnackBar(snackBar);
                  },
                  child: Text("scheduled notification")),
            ),
            // ElevatedButton(onPressed: () {}, child: Text("remove not"))
          ],
        ),
      ),
    );
  }
}
