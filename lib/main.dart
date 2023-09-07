import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:test_project/Authentication/auth_controller.dart';
import 'package:test_project/UI/Module/Bus%20Booking/Region.dart';

import 'UI/Module/Bus Booking/Route.dart';
import 'UI/Module/Bus Booking/Select bus.dart';
import 'UI/registration/Splash/Splash_Screen.dart';
import 'UI/registration/registration.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) => Get.put(Authcontroller()));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: region(),
    );
  }
}
