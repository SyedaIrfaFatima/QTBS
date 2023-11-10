import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'UI/module/Student/Profile/profile_controller.dart';
import 'UI/module/Student/student registration/Start.dart';
import 'UI/module/Student/student registration/Users.dart';
import 'UI/module/Manager/manager_registration/man_registration.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp().then((value) => Get.put(Authcontroller()));
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     Get.put(ProfileController());
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: RollButton(
//         role: 'student',
//         email: '',
//       ),
//     );
//   }
// }

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensure that Flutter is initialized
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ProfileController());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/rollButton',
      getPages: [
        GetPage(
            name: '/rollButton',
            page: () => RollButton(role: 'student', email: '')),
        GetPage(
            name: '/student',
            page: () => Start(
                  selectRoute: '',
                  fee: '',
                )),
        // GetPage(name: '/driver', page: () => DriverScreen()),
        // GetPage(name: '/guardian', page: () => GuardianScreen()),
        GetPage(name: '/manager', page: () => manageRegister()),
      ], // Set the initial route to your RollButton screen
    );
  }
}
