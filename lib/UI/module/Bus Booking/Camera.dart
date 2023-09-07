import 'package:flutter/material.dart';
import 'package:test_project/UI/Module/Bus%20Booking/voucheruploaded.dart';

class camera extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Colors.blue,
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => VoucherUpload()),
          );
        },
        child: CircleAvatar(
          backgroundColor: Colors.white,
          radius: 80,
          child: Icon(
            Icons.camera_alt,
            size: 100,
          ),
        ),
      ),
    );
  }
}

class ABCPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Voucher Upload'),
      ),
      body: Center(
        child: Text('Welcome to ABC Page!'),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('Fee Voucher'),
      ),
      // body: Center(
      //   child: MyContainer(),
      // ),
    ),
  ));
}
