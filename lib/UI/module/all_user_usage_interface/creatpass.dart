import 'package:flutter/material.dart';

import 'forgetpassword.dart';

// void main() {
//   runApp(const crtnewpass());
// }

class crtnewpass extends StatelessWidget {
  final String selectRoute;
  final String fee;
  final String voucherDocumentID;

  crtnewpass(
      {required this.selectRoute,
      required this.fee,
      required this.voucherDocumentID});

  // This widget is the root of your application.
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
                  builder: (context) => forgetpassword(
                    selectRoute: selectRoute,
                    fee: fee,
                    voucherDocumentID: '',
                  ),
                ),
              );
            },
          ),
        ),
        body: SafeArea(
          child: Column(children: [
            SizedBox(
              height: 50,
            ),
            Center(
              child: const Image(
                height: 150,
                width: 120,
                image: AssetImage('assets/logo.png'),
              ),
            ),
            Column(
              children: [
                Padding(
                    padding: EdgeInsets.only(right: 45),
                    child: Text(
                      'Create new Password',
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
                    padding: EdgeInsets.only(left: 0),
                    child: Text(
                      'Your new password must be different \n from previous used passwords',
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
              padding: EdgeInsets.only(left: 20, right: 20, top: 10),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'Password',
                  fillColor: Colors.white,
                  filled: true,
                  suffixIcon: Icon(Icons.visibility_off_outlined),
                  prefixIcon: Icon(
                    Icons.lock_open,
                    color: Colors.blue,
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.indigo),
                      borderRadius: BorderRadius.circular(20)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.blue),
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
                padding: EdgeInsets.only(right: 100),
                child: Text(
                  'Must be atleast 8 character',
                  style: TextStyle(
                      fontSize: 14,
                      fontFamily: "Oswald",
                      color: Colors.grey[600]),
                )),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 10),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'Confirm Password',
                  fillColor: Colors.white,
                  filled: true,
                  suffixIcon: Icon(Icons.visibility_off_outlined),
                  prefixIcon: Icon(
                    Icons.lock_open,
                    color: Colors.blue,
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.indigo),
                      borderRadius: BorderRadius.circular(20)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.blue),
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
                padding: EdgeInsets.only(right: 100),
                child: Text(
                  'Both password must match ',
                  style: TextStyle(
                      fontSize: 14,
                      fontFamily: "Oswald",
                      color: Colors.grey[600]),
                )),
            const SizedBox(
              height: 5,
            ),
            Container(
              height: 50,
              width: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.indigoAccent[400]),
              child: const Center(
                child: Text(
                  'Next',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18, fontFamily: "Oswald", color: Colors.white),
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
          ]),
        ),
      ),
    );
  }
}
