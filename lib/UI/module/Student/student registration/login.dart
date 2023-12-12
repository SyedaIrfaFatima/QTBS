import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_project/UI/module/Student/Payment/fee_voucher.dart';

import 'package:test_project/UI/module/Student/student%20routes/regionn.dart';
import 'package:test_project/UI/module/all_user_usage_interface/forgetpassword.dart';
import 'package:test_project/UI/module/Student/student%20registration/stu-registration.dart';
import '../../all_user_usage_interface/Util/utils.dart';
import '../HomeScreen/Homee.dart';
import '../../../widgets/round_button.dart';

class LoginScreen extends StatefulWidget {
  final String selectRoute;
  final String voucherDocumentID;
  final String voucherURL;
  final String fee;
  final String bus;
  LoginScreen(
      {required this.selectRoute,
      required this.fee,
      required this.bus,
      required this.voucherDocumentID,
      required this.voucherURL});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loading = false;
  final _formkey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final _auth = FirebaseAuth.instance;
  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void login() {
    setState(() {
      loading = true;
    });
    _auth
        .signInWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text.toString())
        .then((value) async {
      // Check if the user is authenticated
      if (value.user != null) {
        final userId = value.user!.uid;
        final busRegistrationCollection =
            FirebaseFirestore.instance.collection('BusRegistrations');

        // Check if the user has registered for any bus
        QuerySnapshot<Map<String, dynamic>> querySnapshot =
            await busRegistrationCollection
                .where('userId', isEqualTo: userId)
                .get();

        //   if (querySnapshot.size > 0) {
        //     // The user is authenticated and has registered for a bus, navigate to the home screen
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(
        //           builder: (context) => Home(
        //                 selectRoute: widget.selectRoute,
        //                 fee: '',
        //               )), // Replace with your home screen class
        //     );
        //   } else {
        //     // The user is authenticated but has not registered for a bus, navigate to the region screen
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(builder: (context) => regionnnn()),
        //     );
        //   }
        // }
        print("Query Snapshot Size: ${querySnapshot.size}");

        if (querySnapshot.size > 0) {
          // The user is authenticated and has registered for a bus, fetch the route and fee from Firebase
          final data = querySnapshot.docs.first.data() as Map<String, dynamic>;
          print("Data: $data");
          final route = data[
              'Route']; // Replace 'route' with the actual field name in your Firestore document
          final fee = data['fees'];
          print("Fee: $fee");
          final bus = data['busNumber'];
          print("bus: $bus");
          final voucherDocumentID = data['voucher'];
          print("voucher: $voucherDocumentID");
          final voucherURl = data['voucherurl'];
          print("voucherURL: $voucherURl");

          // Replace 'fee' with the actual field name in your Firestore document
          print(
              'Voucher Document ID before navigation: ${widget.voucherDocumentID}');
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Home(
                selectRoute: route ?? widget.selectRoute,
                fees: fee ?? widget.fee,
                busnumber: bus ?? widget.bus,
                voucherDocumentID:
                    voucherDocumentID ?? widget.voucherDocumentID,
                voucherURL: voucherURl ?? widget.voucherURL,
              ),
            ),
          );
        } else {
          // The user is authenticated but has not registered for a bus, navigate to the region screen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => regionnnn()),
          );
        }

        setState(() {
          loading = false;
        });
      }
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
      utils().toastMessage(error.toString());
      setState(() {
        loading = false;
      });
    });
  }

  // void login() {
  //   setState(() {
  //     loading = true;
  //   });
  //   _auth
  //       .signInWithEmailAndPassword(
  //           email: emailController.text,
  //           password: passwordController.text.toString())
  //       .then((value) async {
  //     // Check if the user is authenticated
  //     if (value.user != null) {
  //       final userId = value.user!.uid;
  //       final usersCollection = FirebaseFirestore.instance.collection('Users');
  //
  //       // Retrieve the user's role from Firestore
  //       DocumentSnapshot<Map<String, dynamic>> userDoc =
  //           await usersCollection.doc(userId).get();
  //
  //       if (userDoc.exists) {
  //         final userRole = userDoc.data()?['role'];
  //
  //         if (userRole == 'manager') {
  //           // Navigate to manager screen
  //           Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //               builder: (context) => mdashboard(),
  //             ),
  //           );
  //         } else if (userRole == 'student') {
  //           // Navigate to student screen
  //           Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //               builder: (context) => Home(
  //                 selectRoute: widget.selectRoute,
  //                 fees: widget.fee,
  //                 busnumber: '',
  //               ),
  //             ),
  //           );
  //         } else {
  //           // Handle other roles if needed
  //           print("Unknown role: $userRole");
  //         }
  //       } else {
  //         print("User document not found");
  //       }
  //
  //       setState(() {
  //         loading = false;
  //       });
  //     }
  //   }).onError((error, stackTrace) {
  //     debugPrint(error.toString());
  //     utils().toastMessage(error.toString());
  //     setState(() {
  //       loading = false;
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    print('Voucher Document ID in Home: ${widget.voucherDocumentID}');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'Login',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Stack(children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/backgroundd.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: emailController,
                            decoration: const InputDecoration(
                                hintText: 'Email',
                                suffixIcon: Icon(Icons.alternate_email)),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter email';
                              }
                              return null;
                            }),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                            controller: passwordController,
                            keyboardType: TextInputType.text,
                            obscureText: true,
                            decoration: const InputDecoration(
                                hintText: 'password',
                                suffixIcon: Icon(Icons.lock_open)),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter password';
                              }
                              return null;
                            }),
                      ],
                    )),
                SizedBox(
                  height: 40,
                ),
                RoundButton(
                  title: 'Login',
                  loading: loading,
                  onTap: () {
                    if (_formkey.currentState!.validate()) {
                      login();
                    }
                  },
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => forgetpassword(
                                      selectRoute: widget.selectRoute,
                                      fee: widget.fee,
                                      voucherDocumentID:
                                          widget.voucherDocumentID,
                                      voucherURL: widget.voucherURL,
                                      bus: widget.bus,
                                    )));
                      },
                      child: Text("Forgot password")),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?"),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => register(
                                        selectRoute: widget.selectRoute,
                                        fee: widget.fee,
                                        voucherDocumentID:
                                            widget.voucherDocumentID,
                                        voucherURL: widget.voucherURL,
                                        bus: widget.bus,
                                      )));
                        },
                        child: Text("Sign up"))
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                // InkWell(
                //     onTap: () {
                //       Navigator.push(
                //           context,
                //           MaterialPageRoute(
                //               builder: (context) => loginWithphonenumber()));
                //     },
                //     child: Container(
                //       height: 50,
                //       decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(50),
                //           border: Border.all(
                //             color: Colors.black,
                //           )),
                //       child: Center(
                //         child: Text('Login with phone'),
                //       ),
                //     ))
              ]),
        )
      ]),
    );
  }
}
