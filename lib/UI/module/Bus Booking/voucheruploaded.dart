import 'package:flutter/material.dart';

import 'BoardingPass.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Paid Voucher',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: VoucherUpload(),
    );
  }
}

class VoucherUpload extends StatefulWidget {
  @override
  State<VoucherUpload> createState() => _VoucherUploadState();
}

class _VoucherUploadState extends State<VoucherUpload> {
  void navigateToDonePage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BoardingPassApp()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan[100],
      appBar: AppBar(
        title: Text('Paid Voucher'),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.share,
              color: Colors.white,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Center(
                child: Image(
                  height: 150,
                  width: 120,
                  image: AssetImage('assets/logo.png'),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 40.0),
                width: MediaQuery.of(context).size.width,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.lightBlue,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
              ),
              GestureDetector(
                onTap: navigateToDonePage,
                child: Center(
                  child: Image(
                    width: 350,
                    image: AssetImage('assets/Paid fee voucher.png'),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10.0),
                width: MediaQuery.of(context).size.width,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.lightBlue,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
