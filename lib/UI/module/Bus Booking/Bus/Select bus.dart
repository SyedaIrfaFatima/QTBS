import 'package:flutter/material.dart';
import 'package:test_project/UI/Module/Bus%20Booking/Nearbystop.dart';
import 'package:test_project/UI/Module/Bus%20Booking/payment.dart';
import 'package:test_project/UI/module/Bus%20Booking/Nearbystop.dart';

class MyBus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        color: Colors.blue,
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          // appBar: AppBar(
          //   title: Text('Select Bus'),
          //   leading: IconButton(
          //     icon: Icon(
          //       Icons.arrow_back,
          //       color: Colors.white,
          //     ),
          //     // onPressed: () {
          //     //   Navigator.pop(
          //     //       context,
          //     //       MaterialPageRoute(
          //     //         builder: (context) => NearbyStop (),
          //     //       ));
          //     // },
          //   ),
          // ),
          body: Stack(children: [
            const SizedBox(
              height: 80,
            ),
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/Bus background.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            Column(mainAxisAlignment: MainAxisAlignment.end, children: [
              Center(
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const SizedBox(height: 3),
                  Image.asset(
                    'assets/bus_icon.png',
                    width: 60,
                    height: 60,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  const Text(
                    'LSV1297',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ]),
              ),
              Container(
                  width: 350,
                  margin: const EdgeInsets.only(top: 20.0),
                  decoration: BoxDecoration(
                    color: Colors.lightBlue[100],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => payment(),
                        ),
                      );
                    },
                    child: Row(children: [
                      Column(
                        children: [
                          const Text(
                            'Islamabad Express Way',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          const Text(
                            '6:00-12:00',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 80,
                      ),
                      Column(
                        children: [
                          child:const Text(
                            'description',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => payment(),
                                  ),
                                );
                              },
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          const Text(
                            ' 4 seats',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),



                    ]),
                  )),
              SizedBox(
                height: 15,
              ),
              Center(
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const SizedBox(height: 3),
                  Image.asset(
                    'assets/bus_icon.png',
                    width: 60,
                    height: 60,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  const Text(
                    'LSV1297',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ]),
              ),
              Container(
                  width: 350,
                  margin: const EdgeInsets.only(top: 20.0),
                  decoration: BoxDecoration(
                    color: Colors.lightBlue[100],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => payment(),
                        ),
                      );
                    },
                    child: Row(children: [
                      Column(
                        children: [
                          const Text(
                            'Islamabad Express Way',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          const Text(
                            '6:00-12:00',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 80,
                      ),
                      Column(
                        children: [
                          const Text(
                            'description',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          const Text(
                            ' 4 seats',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ]),
                  )),
              SizedBox(
                height: 15,
              ),
              Center(
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const SizedBox(height: 3),
                  Image.asset(
                    'assets/bus_icon.png',
                    width: 60,
                    height: 60,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  const Text(
                    'LSV1297',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ]),
              ),
              Container(
                  width: 350,
                  margin: const EdgeInsets.only(top: 20.0),
                  decoration: BoxDecoration(
                    color: Colors.lightBlue[100],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => payment(),
                        ),
                      );
                    },
                    child: Row(children: [
                      Column(
                        children: [
                          const Text(
                            'Islamabad Express Way',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          const Text(
                            '6:00-12:00',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 80,
                      ),
                      Column(
                        children: [
                          const Text(
                            'description',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          const Text(
                            ' 4 seats',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ]),
                  )),
            ]),
          ]),
        ));
  }
}
