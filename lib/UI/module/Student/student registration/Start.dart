import 'package:flutter/material.dart';
import 'package:test_project/UI/module/Student/student%20registration/Users.dart';
import 'package:test_project/UI/module/Student/student%20registration/stu-registration.dart';

class Start extends StatelessWidget {
  final String selectRoute;
  final String fee;
  final String voucherDocumentID;
  Start(
      {required this.selectRoute,
      required this.fee,
      required this.voucherDocumentID});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // backgroundColor: Colors.cyan[100],
        body: Stack(children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.only(left: 5, right: 5, top: 265),
            child: Column(children: [
              Center(
                child: const Image(
                  height: 320,
                  width: 400,
                  image: AssetImage('assets/Stu anima.jpg'),
                ),
              ),
            ]),
          ),

          Padding(
            padding: EdgeInsets.only(left: 20, right: 10, top: 600),
            child: Column(
              children: [
                Text(
                  'Efficient and reliable shift-based transport for students',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, // Makes the text bold
                      fontStyle:
                          FontStyle.italic, // Adds an italic style for elegance
                      fontSize: 18, // Adjust the font size as needed
                      color: Colors
                          .black, // Change the color to your desired color
                      letterSpacing:
                          1.2, // Adjust the letter spacing for elegance

                      fontFamily: "Oswald"),
                ),
                const Center(
                    child: Text(
                  ' Our shift-based transport service offers an exclusive interface designed for the convienece of university students',
                  style: TextStyle(
                    fontFamily: "Oswald",
                    fontStyle: FontStyle.italic,
                    fontSize: 12,
                    color: Colors.black,
                    letterSpacing: 1.2,
                  ),
                )),
              ],
            ),
          ),
          //Get Started button
          SizedBox(
            height: 10,
          ),

          Padding(
            padding: EdgeInsets.only(left: 100, right: 10, top: 690),
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
                      builder: (context) => register(
                        selectRoute: selectRoute,
                        fee: fee,
                        voucherDocumentID: voucherDocumentID,
                      ),
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
    );
  }
}
