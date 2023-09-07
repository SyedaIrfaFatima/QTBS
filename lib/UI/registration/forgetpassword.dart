import 'package:email_auth/email_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_project/UI/registration/Util/utils.dart';
import 'package:test_project/UI/registration/creatpass.dart';
import 'package:test_project/UI/registration/login.dart';
import 'package:test_project/UI/widgets/round_button.dart';

class forgetpassword extends StatefulWidget {
  const forgetpassword({Key? key}) : super(key: key);

  @override
  State<forgetpassword> createState() => _forgetpasswordState();
}

class _forgetpasswordState extends State<forgetpassword> {
  final TextEditingController _emailController = TextEditingController();

  final auth = FirebaseAuth.instance;
  // final TextEditingController _otpController=TextEditingController();

//   void sendOTP()async{
//     EmailAuth.sessionName ='Tesy session';
//     var res=await EmailAuth.sendOTP(recieveMail:_emailController.text);
//     if (res){
//       print("OTP send");
//     }
//   }
//
//   void verifyOTP()async{
//     var res= EmailAuth.validate(recieveMail:_otpController.text);
//     if (res){
//       print("OTP verified");
// else{
//   print("we could not send the OTP");
//     }
//     }
//     else{
//       print("invalid OTP");
//     }
//   }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              color: Colors.blue,
              onPressed: () {
                Navigator.pop(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                );
              },
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
              padding: const EdgeInsets.only(
                  left: 110, top: 0, right: 110, bottom: 0),
              child: Image(
                height: 150,
                width: 120,
                image: AssetImage('assets/logo.png'),
              ),
            ),
            Column(children: [
              SizedBox(
                height: 170,
              ),
              Column(
                children: [
                  Padding(
                      padding: EdgeInsets.only(right: 150),
                      child: Text(
                        'Forget Password',
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: "Oswald",
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                      padding: EdgeInsets.only(right: 25),
                      child: Text(
                        'Enter the email associated with your account',
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: "Oswald",
                            color: Colors.black),
                      )),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  // Wrap the two TextFormField widgets in a Column
                  children: [
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: 'Email address',
                        fillColor: Colors.white,
                        filled: true,
                        prefixIcon: Icon(
                          Icons.email,
                          color: Color((0Xff323F4B)),
                        ),
                        // suffixIcon: TextButton(
                        // child: Text("send OTP"),
                        // onPressed: () => sendOTP(),
                        // ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),

              RoundButton(
                  title: 'forget',
                  onTap: () {
                    auth
                        .sendPasswordResetEmail(
                            email: _emailController.text.toString())
                        .then((value) {
                      utils().toastMessage(
                          'we have sent you email to recover password, please check email');
                    }).onError((error, stackTrace) {
                      utils().toastMessage(error.toString());
                    });
                  })

              // Container(
              //   height: 50,
              //   width: 250,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(10),
              //     color: Colors.indigo,
              //   ),
              //   child: ElevatedButton(
              //     onPressed: () {
              //       Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //           builder: (context) => forgetpassword(),
              //         ),
              //       );
              //     },
              //     child: const Center(
              //       child: Text(
              //         'Send verification code',
              //         textAlign: TextAlign.center,
              //         style: TextStyle(
              //           fontSize: 18,
              //           fontFamily: "Oswald",
              //           color: Colors.white,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
            ]),
          ]),
        ));
  }
}
