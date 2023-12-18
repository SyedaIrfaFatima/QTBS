import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'package:test_project/UI/module/Driver/driver_registration/dregisteration.dart';
import 'package:test_project/UI/module/Guardian/guardian_registration/gregistration.dart';

import '../Manager/manager_registration/man_registration.dart';
import '../Student/student registration/Start.dart';

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
                      navigateToRole("student", context);
                    },
                  ),
                  SizedBox(height: 10),
                  RoleButton(
                    role: "Driver",
                    onPressed: () {
                      navigateToRole("driver", context);
                    },
                  ),
                  SizedBox(height: 10),
                  RoleButton(
                    role: "Guardian",
                    onPressed: () {
                      navigateToRole("guardian", context);
                    },
                  ),
                  SizedBox(height: 10),
                  RoleButton(
                    role: "Manager",
                    onPressed: () {
                      navigateToRole("manager", context);
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

  void navigateToRole(String role, BuildContext context) {
    // You can handle navigation here based on the selected role
    if (role == "student") {
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //
      //       builder: (context) => Start(
      //             selectRoute: '',
      //             fee: '',
      //             voucherDocumentID: '',
      //             voucherURL: '',
      //             bus: '',
      //           )
      //   ),
      // );
      Navigator.push(
        context,
        PageTransition(
          child: Start(
            selectRoute: '',
            fee: '',
            voucherDocumentID: '',
            voucherURL: '',
            bus: '',
          ), // Replace with the screen you want to navigate to
          type: PageTransitionType
              .rightToLeft, // or any other transition type you prefer
          duration: Duration(seconds: 1), // Specify your desired duration
        ),
      );
    } else if (role == "driver") {
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => dregister()),
      // );
      Navigator.push(
        context,
        PageTransition(
          child: dregister(), // Replace with the screen you want to navigate to
          type: PageTransitionType
              .rightToLeft, // or any other transition type you prefer
          duration: Duration(seconds: 1), // Specify your desired duration
        ),
      );
    } else if (role == "guardian") {
      // Navigator.push(
      //   context,
      //   // MaterialPageRoute(
      //   //     builder: (context) => gregisteration(selectRoute: "", fee: "")),\
      //
      // );
      Navigator.push(
        context,
        PageTransition(
          child: gregisteration(
              selectRoute: "",
              fee: ""), // Replace with the screen you want to navigate to
          type: PageTransitionType
              .rightToLeft, // or any other transition type you prefer
          duration: Duration(seconds: 1), // Specify your desired duration
        ),
      );
    } else if (role == "manager") {
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => manageRegister()),
      // );

      Navigator.push(
        context,
        PageTransition(
          child:
              manageRegister(), // Replace with the screen you want to navigate to
          type: PageTransitionType
              .rightToLeft, // or any other transition type you prefer
          duration: Duration(seconds: 1), // Specify your desired duration
        ),
      ); // Update the UI to show that item 1 was selected
    }
  }

  // void navigateToRole(String role) {
  //   // Use Get.toNamed to navigate to the specified route
  //   if (role == "student") {
  //     Get.toNamed('/student');
  //   } else if (role == "driver") {
  //     Get.toNamed('/driver');
  //   } else if (role == "guardian") {
  //     Get.toNamed('/guardian');
  //   } else if (role == "manager") {
  //     Get.toNamed('/manager');
  //   }
  // }

//   void navigateToRole(
//     String role,
//   ) {
//     if (role == "student") {
//       Get.toNamed('/student');
//     } else if (role == "driver") {
//       Get.toNamed('/driver');
//     } else if (role == "guardian") {
//       Get.toNamed('/guardian');
//     } else if (role == "manager") {
//       Get.toNamed('/manager');
//     }
//   }
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
