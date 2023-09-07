import 'package:flutter/material.dart';
import 'package:test_project/UI/Module/Bus%20Booking/Camera.dart';

class payment extends StatelessWidget {
  const payment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.cyan[100],
        appBar: AppBar(
          title: const Text('Payment Option'),
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                Center(
                  child: Image.asset(
                    'assets/payfee map.png',
                    width: 500,
                    height: 220,
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Pick Up',
                      prefixIcon: Icon(Icons.location_on),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Destination',
                      prefixIcon: Icon(Icons.location_on),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(right: 40),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'Pay Fee                                                    8000',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Opacity(
                              opacity: 0.8,
                              child: Container(
                                margin: const EdgeInsets.only(right: 20),
                                width: 132,
                                height: 132,
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/voucher.png',
                                      width: 80,
                                      height: 80,
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Text(
                                          'Cash',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Icon(Icons.download,
                                            color: Colors.white),
                                        IconButton(
                                          icon: Icon(Icons.upload,
                                              color: Colors.white),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => camera(),
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            Opacity(
                              opacity: 0.8,
                              child: Container(
                                margin: const EdgeInsets.only(right: 10),
                                width: 132,
                                height: 132,
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/tickets.png',
                                      width: 80,
                                      height: 80,
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Text(
                                          'JazzCash',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Icon(Icons.upload, color: Colors.white),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
