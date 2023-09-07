//                       validator: (value) {
//                         if (value!.isEmpty) {
//                           return 'Enter Email';
//                         }
//                         return null;
//                       },
//                     ),
//
//                     TextFormField(
//                       decoration: InputDecoration(
//                         hintText: 'Phone no',
//                         fillColor: Colors.white,
//                         filled: true,
//                         prefixIcon: Icon(
//                           Icons.add_call,
//                           color: Colors.indigoAccent,
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderSide:
//                               BorderSide(color: const Color(0xffE4E7EB)),
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderSide:
//                               const BorderSide(color: Colors.indigoAccent),
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                     ),
//
//                     TextFormField(
//                       decoration: InputDecoration(
//                         hintText: 'Sap id',
//                         fillColor: Colors.white,
//                         filled: true,
//                         prefixIcon: Icon(
//                           Icons.numbers,
//                           color: Colors.indigoAccent,
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderSide:
//                               BorderSide(color: const Color(0xffE4E7EB)),
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderSide:
//                               const BorderSide(color: Colors.indigoAccent),
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                     ),
//
//                     TextFormField(
//                       decoration: InputDecoration(
//                         hintText: 'Address',
//                         fillColor: Colors.white,
//                         filled: true,
//                         prefixIcon: Icon(
//                           Icons.home,
//                           color: Colors.indigoAccent,
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderSide:
//                               BorderSide(color: const Color(0xffE4E7EB)),
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderSide:
//                               const BorderSide(color: Colors.indigoAccent),
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                     ),
//
//                     TextFormField(
//                       keyboardType: TextInputType.text,
//                       controller: passwordController,
//                       decoration: InputDecoration(
//                         hintText: 'Password',
//                         fillColor: Colors.white,
//                         filled: true,
//                         suffixIcon: Icon(Icons.lock),
//                         prefixIcon: Icon(
//                           Icons.lock_open,
//                           color: Colors.indigoAccent,
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderSide:
//                               BorderSide(color: const Color(0xffE4E7EB)),
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderSide:
//                               const BorderSide(color: Colors.indigoAccent),
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                       validator: (value) {
//                         if (value!.isEmpty) {
//                           return 'Enter Email';
//                         }
//                         return null;
//                       },
//                     ),
//
//                     TextFormField(
//                       decoration: InputDecoration(
//                         hintText: 'Confirm Password',
//                         fillColor: Colors.white,
//                         filled: true,
//                         suffixIcon: Icon(Icons.lock),
//                         prefixIcon: Icon(
//                           Icons.lock_open,
//                           color: Colors.indigoAccent,
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderSide:
//                               BorderSide(color: const Color(0xffE4E7EB)),
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderSide:
//                               const BorderSide(color: Colors.indigoAccent),
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                     ),
//
//                     // Rest of the code...
//
//                     GestureDetector(
//                       onTap: () {
//                         // Add your desired functionality here when the container is tapped.
//                         // For example, you can open a dialog, navigate to a new page, etc.
//                       },
//                       child: Container(
//                         height: 50,
//                         width: 180,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                           color: Colors.indigo,
//                         ),
//                         child: ElevatedButton(
//                           onPressed: () {
//                             if (_formKey.currentState!.validate()) {
//                               final user = UserModel(
//                                 fullName: fullnameController.text.trim(),
//                                 Password: passwordController.text.trim(),
//                                 phoneNo: phonenoController.text.trim(),
//                                 ConfirmPassword:
//                                     confirmpasswordController.text.trim(),
//                                 email: emailController.text.trim(),
//                               );
//
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => login(),
//                                 ),
//                               );
//                             }
//                           },
//                           child: const Center(
//                             child: Text(
//                               'Create Account',
//                               textAlign: TextAlign.center,
//                               style: TextStyle(
//                                 fontSize: 18,
//                                 fontFamily: "Oswald",
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     )
//                   ]),
//                 ),
//               ),
//             )),
//       ]),
//     );
//   }
// }

// class TrianglePainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     var path = Path();
//     path.lineTo(size.width / 0.5, 0);
//
//     var controlPoint = Offset(size.width * 0.50, size.height * 0.55);
//     var endPoint = Offset(0, size.height / 3.80);
//
//     path.quadraticBezierTo(
//       controlPoint.dx,
//       controlPoint.dy,
//       endPoint.dx,
//       endPoint.dy,
//     );
//
//     var paint = Paint()
//       ..color = Colors.blue
//       ..style = PaintingStyle.fill;
//
//     canvas.drawPath(path, paint);
//   }
//
//   @override
//   bool shouldRepaint(TrianglePainter oldDelegate) => false;
// }
//
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/services.dart';
//
// class RegisterPage extends StatefulWidget {
//   static String tag = 'register-page';
//   @override
//   _RegisterPageState createState() => new _RegisterPageState();
// }
//
// class _RegisterPageState extends State<RegisterPage> {
//   // Create a global key that will uniquely identify the Form widget and allow
//   // us to validate the form
//   //
//   // Note: This is a GlobalKey<FormState>, not a GlobalKey<MyCustomFormState>!
//   final _formKey = GlobalKey<FormState>();
//   final emailTextEditController = new TextEditingController();
//   final firstNameTextEditController = new TextEditingController();
//   final lastNameTextEditController = new TextEditingController();
//   final passwordTextEditController = new TextEditingController();
//   final confirmPasswordTextEditController = new TextEditingController();
//
//   final FocusNode _emailFocus = FocusNode();
//   final FocusNode _firstNameFocus = FocusNode();
//   final FocusNode _lastNameFocus = FocusNode();
//   final FocusNode _passwordFocus = FocusNode();
//   final FocusNode _confirmPasswordFocus = FocusNode();
//
//   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
//
//   String _errorMessage = '';
//
//   void processError(final PlatformException error) {
//     setState(() {
//       _errorMessage = error.message!;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(
//           child: Form(
//               key: _formKey,
//               child: ListView(
//                 shrinkWrap: true,
//                 padding: EdgeInsets.only(top: 36.0, left: 24.0, right: 24.0),
//                 children: <Widget>[
//                   Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: Text(
//                       'Register',
//                       style: TextStyle(fontSize: 36.0, color: Colors.black87),
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: Text(
//                       '$_errorMessage',
//                       style: TextStyle(fontSize: 14.0, color: Colors.red),
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.symmetric(vertical: 8.0),
//                     child: TextFormField(
//                       validator: (value) {
//                         if (value!.isEmpty || !value.contains('@')) {
//                           return 'Please enter a valid email.';
//                         }
//                         return null;
//                       },
//                       controller: emailTextEditController,
//                       keyboardType: TextInputType.emailAddress,
//                       autofocus: true,
//                       textInputAction: TextInputAction.next,
//                       focusNode: _emailFocus,
//                       onFieldSubmitted: (term) {
//                         FocusScope.of(context).requestFocus(_firstNameFocus);
//                       },
//                       decoration: InputDecoration(
//                         hintText: 'Email',
//                         contentPadding:
//                             EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(32.0)),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.symmetric(vertical: 8.0),
//                     child: TextFormField(
//                       validator: (value) {
//                         if (value!.isEmpty) {
//                           return 'Please enter your first name.';
//                         }
//                         return null;
//                       },
//                       controller: firstNameTextEditController,
//                       keyboardType: TextInputType.text,
//                       autofocus: false,
//                       textInputAction: TextInputAction.next,
//                       focusNode: _firstNameFocus,
//                       onFieldSubmitted: (term) {
//                         FocusScope.of(context).requestFocus(_lastNameFocus);
//                       },
//                       decoration: InputDecoration(
//                         hintText: 'First Name',
//                         contentPadding:
//                             EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(32.0)),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.symmetric(vertical: 8.0),
//                     child: TextFormField(
//                       validator: (value) {
//                         if (value.isEmpty) {
//                           return 'Please enter your last name.';
//                         }
//                         return null;
//                       },
//                       controller: lastNameTextEditController,
//                       keyboardType: TextInputType.text,
//                       autofocus: false,
//                       textInputAction: TextInputAction.next,
//                       focusNode: _lastNameFocus,
//                       onFieldSubmitted: (term) {
//                         FocusScope.of(context).requestFocus(_passwordFocus);
//                       },
//                       decoration: InputDecoration(
//                         hintText: 'Last Name',
//                         contentPadding:
//                             EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(32.0)),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.symmetric(vertical: 8.0),
//                     child: TextFormField(
//                       validator: (value) {
//                         if (value.length < 8) {
//                           return 'Password must be longer than 8 characters.';
//                         }
//                         return null;
//                       },
//                       autofocus: false,
//                       obscureText: true,
//                       controller: passwordTextEditController,
//                       textInputAction: TextInputAction.next,
//                       focusNode: _passwordFocus,
//                       onFieldSubmitted: (term) {
//                         FocusScope.of(context)
//                             .requestFocus(_confirmPasswordFocus);
//                       },
//                       decoration: InputDecoration(
//                         hintText: 'Password',
//                         contentPadding:
//                             EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(32.0)),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.symmetric(vertical: 8.0),
//                     child: TextFormField(
//                       autofocus: false,
//                       obscureText: true,
//                       controller: confirmPasswordTextEditController,
//                       focusNode: _confirmPasswordFocus,
//                       textInputAction: TextInputAction.done,
//                       validator: (value) {
//                         if (passwordTextEditController.text.length > 8 &&
//                             passwordTextEditController.text != value) {
//                           return 'Passwords do not match.';
//                         }
//                         return null;
//                       },
//                       decoration: InputDecoration(
//                         hintText: 'Confirm Password',
//                         contentPadding:
//                             EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(32.0)),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(top: 10.0),
//                     child: RaisedButton(
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(24),
//                       ),
//                       onPressed: () {
//                         if (_formKey.currentState.validate()) {
//                           _firebaseAuth
//                               .createUserWithEmailAndPassword(
//                                   email: emailTextEditController.text,
//                                   password: passwordTextEditController.text)
//                               .then((onValue) {
//                             Firestore.instance
//                                 .collection('users')
//                                 .document(onValue.user)
//                                 .setData({
//                               'firstName': firstNameTextEditController.text,
//                               'lastName': lastNameTextEditController.text,
//                             }).then((userInfoValue) {
//                               Navigator.of(context).pushNamed(HomePage.tag);
//                             });
//                           }).catchError((onError) {
//                             processError(onError);
//                           });
//                         }
//                       },
//                       padding: EdgeInsets.all(12),
//                       color: Colors.lightGreen,
//                       child: Text('Sign Up'.toUpperCase(),
//                           style: TextStyle(color: Colors.white)),
//                     ),
//                   ),
//                   Padding(
//                       padding: EdgeInsets.zero,
//                       child: FlatButton(
//                         child: Text(
//                           'Cancel',
//                           style: TextStyle(color: Colors.black54),
//                         ),
//                         onPressed: () {
//                           Navigator.pop(context);
//                         },
//                       ))
//                 ],
//               ))),
//     );
//   }
// }

//
//
//
//
//

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:test_project/Authentication/models/User_model.dart';
import 'package:test_project/UI/registration/Util/utils.dart';
import 'package:test_project/UI/registration/login.dart';

import '../../Authentication/Auth_reprository/User_Repository/user_repository.dart';
import '../widgets/round_button.dart';

class register extends StatefulWidget {
  const register({Key? key}) : super(key: key);

  @override
  State<register> createState() => _registerState();
}

class _registerState extends State<register> {
  bool loading = false;
  final _formkey = GlobalKey<FormState>();
  final fullnameController = TextEditingController();
  final emailController = TextEditingController();
  final sapidController = TextEditingController();
  final addressController = TextEditingController();
  final phonenoController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();

  final userrepo = Get.put(UserRepository());

  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void register() {
    setState(() {
      loading = true;
    });
    _auth
        .createUserWithEmailAndPassword(
            email: emailController.text.toString(),
            password: passwordController.text.toString())
        .then((value) {
      utils().toastMessage(value.user!.email.toString());

      // Add the transition to the login screen
      Navigator.push(
        context,
        PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 500),
          pageBuilder: (context, animation, secondaryAnimation) =>
              LoginScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            var begin = Offset(4.0, 0.0);
            var end = Offset.zero;
            var curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);

            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        ),
      );

      setState(() {
        loading = false;
      });
    }).onError((error, stackTrace) {
      utils().toastMessage(error.toString());
      setState(() {
        loading = false;
      });
    });
  }

  Future<void> createUser(UserModel user) async {
    await userrepo.createUser(user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Registration',
            style: TextStyle(color: Colors.blue),
          ),
        ),
        body: Stack(children: [
          Container(
            // Wrap with Container
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/backgroundd.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Wrap with Container

          Padding(
            padding:
                const EdgeInsets.only(left: 110, top: 0, right: 110, bottom: 0),
            child: Image(
              height: 150,
              width: 120,
              image: AssetImage('assets/logo.png'),
            ),
          ),

          Padding(
              padding: const EdgeInsets.only(
                  left: 10, top: 150, right: 10, bottom: 0),
              child: SingleChildScrollView(
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
                              controller: fullnameController,
                              decoration: const InputDecoration(
                                  hintText: 'Full name ',
                                  suffixIcon: Icon(Icons.person)),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'please enter name';
                                }
                                return null;
                              }),
                          const SizedBox(
                            height: 10,
                          ),
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
                              controller: phonenoController,
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                  hintText: 'phone no',
                                  suffixIcon: Icon(Icons.add_call)),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter phone no';
                                }
                                return null;
                              }),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                              controller: sapidController,
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                  hintText: 'Sap Id',
                                  suffixIcon: Icon(Icons.numbers)),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Sap Id';
                                }
                                return null;
                              }),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                              controller: addressController,
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                  hintText: 'Address',
                                  suffixIcon: Icon(Icons.home)),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter Address';
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
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                              controller: confirmpasswordController,
                              keyboardType: TextInputType.text,
                              obscureText: true,
                              decoration: const InputDecoration(
                                  hintText: ' Confirm password',
                                  suffixIcon: Icon(Icons.lock_open)),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Reenter password';
                                }
                                return null;
                              }),
                        ],
                      )),
                  SizedBox(
                    height: 50,
                  ),
                  RoundButton(
                    title: 'Create Account',
                    loading: loading,
                    onTap: () {
                      if (_formkey.currentState!.validate()) {
                        final user = UserModel(
                          Sapid: sapidController.text.trim(),
                          fullName: fullnameController.text.trim(),
                          email: emailController.text.trim(),
                          phoneNo: phonenoController.text.trim(),
                          Address: addressController.text.trim(),
                          Password: passwordController.text.trim(),
                          ConfirmPassword:
                              confirmpasswordController.text.trim(),
                        );

                        register();
                        UserRepository.instances.createUser(user);

                        // Corrected the line here
                      }
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => LoginScreen()));
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account?"),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()));
                          },
                          child: Text("Login"))
                    ],
                  )
                ],
              )))
        ]));
  }
}
