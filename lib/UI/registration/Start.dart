import 'package:flutter/material.dart';
import 'package:test_project/UI/registration/Users.dart';
import 'package:test_project/UI/registration/registration.dart';

void main() {
  runApp(Start());
}

class Start extends StatelessWidget {
  const Start({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // backgroundColor: Colors.cyan[100],
        body: SafeArea(
          child: Column(children: [
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Center(
                child: const Image(
                  height: 550,
                  width: 350,
                  image: AssetImage('assets/Stu anima.jpg'),
                ),
              ),
            ]),

            Column(children: [
              const Center(
                  child: Text(
                'Efficient and reliable shift-based transport for students',
                style: TextStyle(
                    fontSize: 20, fontFamily: "Oswald", color: Colors.black),
              )),
              const Center(
                  child: Text(
                ' Our shift-based transport service offers an exclusive interface designed for the convienece of university students',
                style: TextStyle(
                    fontSize: 10, fontFamily: "Oswald", color: Colors.black),
              )),
            ]),
            //Get Started button
            SizedBox(
              height: 10,
            ),

            Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 10),
              child: Container(
                height: 50,
                width: 150,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.indigo),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => User(),
                      ),
                    );
                  },
                  child: const Center(
                    child: Text(
                      'Get Started',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 18,
                          fontFamily: "Oswald",
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
