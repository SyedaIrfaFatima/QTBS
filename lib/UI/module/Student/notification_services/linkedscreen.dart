import 'package:flutter/material.dart';

import 'notification.dart';

class linkedscreen extends StatefulWidget {
  const linkedscreen({Key? key}) : super(key: key);

  @override
  State<linkedscreen> createState() => _linkedscreenState();
}

class _linkedscreenState extends State<linkedscreen> {
  Notificationserices notificationserices = Notificationserices();
  void initState() {
    super.initState();
    notificationserices.requestNotificationPermission();
    notificationserices.firebaseInit();
    notificationserices.isTokenRefresh();
    notificationserices.getDeviceToken().then((value) {
      print('device token');
      print(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
