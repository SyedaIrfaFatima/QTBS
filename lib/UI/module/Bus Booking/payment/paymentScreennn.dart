import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class paymentScreen extends StatefulWidget {
  @override
  _paymentScreenState createState() => _paymentScreenState();
}

class _paymentScreenState extends State<paymentScreen> {
  TextEditingController amountController = TextEditingController();
  TextEditingController recipientController = TextEditingController();

  @override
  void dispose() {
    amountController.dispose();
    recipientController.dispose();
    super.dispose();
  }

  Future<void> initiatePayment() async {
    final String easyPaisaEndpoint = 'https://api.easypaisa.com.pk/';
    final String merchantId = 'YOUR_MERCHANT_ID';
    final String apiKey = 'YOUR_API_KEY';

    final String recipientPhoneNumber = recipientController.text;
    final String amount = amountController.text;

    final response = await http.post(
      '$easyPaisaEndpoint/transfer-money' as Uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode({
        'merchantId': merchantId,
        'recipientPhoneNumber': recipientPhoneNumber,
        'amount': amount,
        // Add other required parameters
      }),
    );

    if (response.statusCode == 200) {
      // Handle the transfer response
      final transferResponse = jsonDecode(response.body);
      // Check for success or failure and update your UI accordingly
      // You can display a success message or navigate to a success screen.
    } else {
      // Handle errors
      print('Transfer money failed with status code: ${response.statusCode}');
      // Display an error message to the user or handle the error as needed.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Enter Payment Details',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: recipientController,
              decoration: InputDecoration(
                labelText: 'Recipient Phone Number',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Amount (PKR)',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: initiatePayment,
              child: Text('Initiate Payment'),
            ),
          ],
        ),
      ),
    );
  }
}
