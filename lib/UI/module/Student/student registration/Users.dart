import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:test_project/UI/module/Student/student%20registration/stu-registration.dart';

import '../../Manager/manager_registration/man_registration.dart';
import 'Start.dart';

// class User extends StatelessWidget {
//   String email;
//   String role; // "student", "manager", "driver", "guardian"
//
//   User(this.email, this.role);
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         body: Stack(children: [
//           Container(
//             width: double.infinity,
//             height: double.infinity,
//             decoration: BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage("assets/user.png"),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.only(left: 100, top: 330),
//             child:
//                 Column(mainAxisAlignment: MainAxisAlignment.center, children: [
//               Container(
//                 height: 45,
//                 width: 150,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   color: Colors.indigo,
//                 ),
//                 child: ElevatedButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => Start(),
//                       ),
//                     );
//                   },
//                   child: const Center(
//                     child: Text(
//                       'Student',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontFamily: "Oswald",
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 10),
//
//               Container(
//                 height: 45,
//                 width: 150,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   color: Colors.indigo,
//                 ),
//                 child: ElevatedButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => Start(),
//                       ),
//                     );
//                   },
//                   child: const Center(
//                     child: Text(
//                       'Driver',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontFamily: "Oswald",
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//
//               SizedBox(height: 10),
//
//               Container(
//                 height: 45,
//                 width: 150,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   color: Colors.indigo,
//                 ),
//                 child: ElevatedButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => Start(),
//                       ),
//                     );
//                   },
//                   child: const Center(
//                     child: Text(
//                       'Guardain',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontFamily: "Oswald",
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//
//               SizedBox(height: 10),
//
//               Container(
//                 height: 45,
//                 width: 150,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   color: Colors.indigo,
//                 ),
//                 child: ElevatedButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => Start(),
//                       ),
//                     );
//                   },
//                   child: const Center(
//                     child: Text(
//                       'Manager',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontFamily: "Oswald",
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               // ),
//             ]),
//           ),
//         ]),
//       ),
//     );
//   }
// }

class RollButton extends StatelessWidget {
  final String email;
  final String role;

  RollButton({required this.email, required this.role});

  // final user = RollButton(email: "user@example.com", role: "student");
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/user.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 100, top: 330),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RoleButton(
                    role: "Student",
                    onPressed: () {
                      navigateToRole("student");
                    },
                  ),
                  SizedBox(height: 10),
                  RoleButton(
                    role: "Driver",
                    onPressed: () {
                      navigateToRole("driver");
                    },
                  ),
                  SizedBox(height: 10),
                  RoleButton(
                    role: "Guardian",
                    onPressed: () {
                      navigateToRole("guardian");
                    },
                  ),
                  SizedBox(height: 10),
                  RoleButton(
                    role: "Manager",
                    onPressed: () {
                      navigateToRole("manager");
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // void navigateToRole(String role, BuildContext context) {
  //   // You can handle navigation here based on the selected role
  //   if (role == "student") {
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(builder: (context) => register()),
  //     );
  //   }
  //   // } else if (role == "driver") {
  //   //   Navigator.push(
  //   //     context,
  //   //     MaterialPageRoute(builder: (context) => DriverScreen()),
  //   //   );
  //   // } else if (role == "guardian") {
  //   //   Navigator.push(
  //   //     context,
  //   //     MaterialPageRoute(builder: (context) => GuardianScreen()),
  //   //   );
  //   // }
  //   else if (role == "manager") {
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(builder: (context) => manageRegister()),
  //     );
  //   }
  // }

  void navigateToRole(String role) {
    // Use Get.toNamed to navigate to the specified route
    if (role == "student") {
      Get.toNamed('/student');
    } else if (role == "driver") {
      Get.toNamed('/driver');
    } else if (role == "guardian") {
      Get.toNamed('/guardian');
    } else if (role == "manager") {
      Get.toNamed('/manager');
    }
  }
}

class RoleButton extends StatelessWidget {
  final String role;
  final VoidCallback onPressed;

  RoleButton({required this.role, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.indigo,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Center(
          child: Text(
            role,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontFamily: "Oswald",
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
