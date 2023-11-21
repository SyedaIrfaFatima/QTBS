import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:test_project/UI/module/Driver/driver_registration/dregisteration.dart';

import 'UI/module/Student/Profile/profile_controller.dart';
import 'UI/module/Student/student registration/Start.dart';
import 'UI/module/Student/student registration/Users.dart';
import 'UI/module/Manager/manager_registration/man_registration.dart';
import 'UI/module/Student/student registration/stu-registration.dart';
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

// void main() async {
//   WidgetsFlutterBinding
//       .ensureInitialized(); // Ensure that Flutter is initialized
//   await Firebase.initializeApp(); // Initialize Firebase
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     Get.put(ProfileController());
//     return GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       // initialRoute: '/rollButton',
//       initialRoute: '/',
//       // getPages: [
//       //   GetPage(
//       //       name: '/rollButton',
//       //       page: () => RollButton(role: 'student', email: '')),
//       //   GetPage(
//       //       name: '/student',
//       //       page: () => Start(
//       //             selectRoute: '',
//       //             fee: '',
//       //           )),
//       //   // GetPage(name: '/driver', page: () => DriverScreen()),
//       //   // GetPage(name: '/guardian', page: () => GuardianScreen()),
//       //   GetPage(name: '/manager', page: () => manageRegister()),
//       // ], // Set the initial route to your RollButton screen
//
//       routes: {
//         '/': (context) => RollButton(email: email, role: role),
//         '/student': (context) => Start(
//               selectRoute: '',
//               fee: '',
//             ),
//         '/driver': (context) => dregister(),
//         '/guardian': (context) => dregister(),
//         '/manager': (context) => manageRegister(),
//       },
//     );
//   }
// }

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MyApp(email: "user@example.com", role: "student"));
// }
//
// class MyApp extends StatelessWidget {
//   final String email;
//   final String role;
//
//   const MyApp({required this.email, required this.role, Key? key})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     Get.put(ProfileController());
//     return GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       initialRoute: '/',
//       routes: {
//         '/': (context) => RollButton(email: email, role: role),
//         '/student': (context) => Start(
//               selectRoute: '',
//               fee: '',
//             ),
//         '/driver': (context) => dregister(),
//         '/guardian': (context) => dregister(),
//         '/manager': (context) => manageRegister(),
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp(email: "user@example.com", role: "manager"));
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class MyApp extends StatelessWidget {
  final String email;
  final String role;

  const MyApp({required this.email, required this.role, Key? key})
      : super(key: key);

  // Future<void> requestNotificationPermissions() async {
  //   const AndroidNotificationChannel channel = AndroidNotificationChannel(
  //     'fee_channel', // ID
  //     'Fee Notifications', // Title
  //     description: 'Notifications for fee payments',
  //     importance: Importance.high,
  //     playSound: true,
  //   );
  //
  //   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //       FlutterLocalNotificationsPlugin();
  //
  //   await flutterLocalNotificationsPlugin
  //       .resolvePlatformSpecificImplementation<
  //           AndroidFlutterLocalNotificationsPlugin>()
  //       ?.createNotificationChannel(channel);
  // }

  @override
  Widget build(BuildContext context) {
    Get.put(ProfileController());

    // requestNotificationPermissions();

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => RollButton(email: email, role: role),
        '/student': (context) => Start(
              selectRoute: '',
              fee: '',
            ),
        '/driver': (context) => dregister(),
        '/guardian': (context) => dregister(),
        '/manager': (context) => manageRegister(),
      },
    );
  }
}
