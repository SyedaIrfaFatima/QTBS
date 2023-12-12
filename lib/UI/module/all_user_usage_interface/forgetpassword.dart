import 'package:email_auth/email_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_project/UI/module/Student/student%20registration/login.dart';
import 'package:test_project/UI/widgets/round_button.dart';

import 'Util/utils.dart';

class forgetpassword extends StatefulWidget {
  final String selectRoute;
  final String fee;
  final String bus;
  final String voucherDocumentID;
  final String voucherURL;
  forgetpassword(
      {required this.selectRoute,
      required this.fee,
      required this.bus,
      required this.voucherDocumentID,
      required this.voucherURL});

  @override
  State<forgetpassword> createState() => _forgetpasswordState();
}

class _forgetpasswordState extends State<forgetpassword> {
  final TextEditingController _emailController = TextEditingController();

  final auth = FirebaseAuth.instance;

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
                    builder: (context) => LoginScreen(
                      selectRoute: widget.selectRoute,
                      fee: widget.fee,
                      voucherDocumentID: widget.voucherDocumentID,
                      voucherURL: widget.voucherURL,
                      bus: widget.bus,
                    ),
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
            ]),
          ]),
        ));
  }
}
