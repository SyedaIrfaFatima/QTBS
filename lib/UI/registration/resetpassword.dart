import 'package:flutter/material.dart';
import 'package:test_project/UI/registration/login.dart';

import 'forgetpassword.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          padding:
              const EdgeInsets.only(left: 110, top: 0, right: 110, bottom: 0),
          child: Image(
            height: 150,
            width: 120,
            image: AssetImage('assets/logo.png'),
          ),
        ),
        Column(
          children: [
            SizedBox(
              height: 200,
            ),
            Column(children: [
              Padding(
                  padding: EdgeInsets.only(left: 20, right: 125),
                  child: Text(
                    'Rest Your Password',
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
                  padding: EdgeInsets.only(left: 40, right: 40),
                  child: Text(
                    'Need to reset your password? No problem! Just Click the button below',
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: "Oswald",
                        color: Colors.black),
                  )),
            ]),
            const SizedBox(
              height: 40,
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.indigo,
              ),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => forgetpassword(),
                    ),
                  );
                },
                child: const Center(
                  child: Text(
                    'Rest your Password',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: "Oswald",
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
