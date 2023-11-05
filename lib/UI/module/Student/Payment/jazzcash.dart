import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class JazzCashPage extends StatefulWidget {
  final String selectRoute;
  final String fee;

  const JazzCashPage({
    required this.title,
    required this.selectRoute,
    required this.fee,
  });

  final String title;

  @override
  State<JazzCashPage> createState() => _JazzCashPageState();
}

class _JazzCashPageState extends State<JazzCashPage> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController sapidController = TextEditingController();
  Future<void> makePaymentRequest() async {
    try {
      var url =
          "https://sandbox.jazzcash.com.pk/ApplicationAPI/API/Payment/DoTransaction";

      var response = await http.post(Uri.parse(url), body: {
        "pp_Version": "1.1",
        "pp_TxnType": "MWALLET",
        "pp_Language": "EN",
        "pp_MerchantID": "MC60793",
        "pp_SubMerchantID": "",
        "pp_Password": "83ybwuvf30",
        "pp_BankID": "",
        "pp_ProductID": "",
        "pp_TxnRefNo": "T20231020115116",
        "pp_Amount": "10000",
        "pp_TxnCurrency": "PKR",
        "pp_TxnDateTime": "20231020115116",
        "pp_BillReference": "billref",
        "pp_Description": "Description of transaction",
        "pp_TxnExpiryDateTime": "20231020115116",
        "pp_ReturnURL":
            "https://sandbox.jazzcash.com.pk/ApplicationAPI/API/Payment/DoTransaction",
        "pp_SecureHash":
            "19BE198D52665A43F4105BDA41AA072FB7911574F466EBA491A4927C55D69D65",
        "ppmpf_1": "nameController.text",
        "ppmpf_2": "sapidController.text",
        "ppmpf_3": "03129131662",
        "ppmpf_4": "",
        "ppmpf_5": ""
      });

      if (response.statusCode == 200) {
        // Payment was successful
        _showPaymentStatusDialog(
            'Payment Successful', 'Your payment was successful.');
      } else {
        // Payment was not successful
        _showPaymentStatusDialog('Payment not Successful', 'Check Api Logs.');
      }
    } catch (e) {
      // Handle exceptions
      print('Error: $e');
      _showPaymentStatusDialog('Payment not Successful', '.');
    }
  }

  void _showPaymentStatusDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 30),
                    child: Image.asset(
                      'assets/jazzcash.png',
                      width: 80,
                      height: 80,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Pay with your Jazz Cash Account.\nPlease make sure you have enough\nbalance in your account',
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Align(
                  alignment: Alignment
                      .topLeft, // Align the large image at the top-left
                  child: Image.asset(
                    'assets/jazzinstruction.png',
                    width: 300,
                    height: 400,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: nameController,
                    decoration:
                        InputDecoration(labelText: 'JazzCash Account Number'),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  'Total Amount:',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 190,
                ),
                // Add your total amount value here
                Text(
                  widget.fee,
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ), // Add the money unit or value here
              ],
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: makePaymentRequest,
              child: Text('Make Payment'),
            ),
          ],
        ),
      ),
    );
  }
}
