import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';

import 'BoardingPass.dart';

class VoucherUpload extends StatefulWidget {
  final String selectRoute;
  final String fee;
  VoucherUpload({required this.selectRoute, required this.fee});

  @override
  State<VoucherUpload> createState() => _VoucherUploadState();
}

class _VoucherUploadState extends State<VoucherUpload> {
  bool showUploadButton = true;
  bool showUploadIcon = false;

  Future<void> _openVoucherFilePicker() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        // Handle the selected file, for example, you can upload it here
        // The file details can be accessed from result.files
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => BoardingPass(
                  selectRoute: widget.selectRoute, fee: widget.fee)),
        );
      }
    } catch (e) {
      // Handle any errors that occur during the file picking process
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Voucher Upload'),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          if (showUploadIcon)
            IconButton(
              icon: Icon(
                Icons.cloud_upload_outlined, // Your desired icon
                color: Colors.white,
              ),
              onPressed: () {
                _openVoucherFilePicker(); // Handle the upload action
              },
            ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (showUploadButton)
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    showUploadButton = false;
                    showUploadIcon = true;
                  });
                },
                child: Text('Upload Voucher'),
              ),
            if (showUploadIcon)
              GestureDetector(
                onTap: () {
                  _openVoucherFilePicker(); // Handle the upload action
                },
                child: DottedBorder(
                  borderType: BorderType.Rect,
                  color: Colors.grey,
                  strokeWidth: 2,
                  child: Container(
                    width: 270,
                    height: 270,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.cloud_upload_outlined,
                          size: 100,
                          color: Colors.grey,
                        ),
                        Text(
                          'Click the icon to upload',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class VoucherUpload extends StatelessWidget {
//   final String selectRoute;
// //
//   VoucherUpload({required this.selectRoute});
// //
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: StampVoucherScreen(),
//     );
//   }
// }
//
// class StampVoucherScreen extends StatefulWidget {
//   @override
//   _StampVoucherScreenState createState() => _StampVoucherScreenState();
// }
//
// class _StampVoucherScreenState extends State<StampVoucherScreen> {
//   TextEditingController feesController = TextEditingController();
//   bool isPaid = false;
//
//   // Firebase Firestore instance
//   final FirebaseFirestore firestore = FirebaseFirestore.instance;
//
//   void uploadStampVoucher() async {
//     int? fees = int.tryParse(feesController.text);
//
//     if (fees == null || fees <= 0) {
//       // Show an error message if fees are not valid
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Invalid fees amount')),
//       );
//       return;
//     }
//
//     if (!isPaid) {
//       // Show an error message if the voucher is not paid
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Voucher is not paid')),
//       );
//       return;
//     }
//
//     // Upload the stamp voucher to Firestore
//     await firestore.collection('stamp_vouchers').add({
//       'fees': fees,
//       'isPaid': isPaid,
//     });
//
//     // Clear the input fields
//     feesController.clear();
//     setState(() {
//       isPaid = false;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Stamp Voucher Upload'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: <Widget>[
//             TextField(
//               controller: feesController,
//               decoration: InputDecoration(labelText: 'Fees'),
//               keyboardType: TextInputType.number,
//             ),
//             Row(
//               children: <Widget>[
//                 Text('Is Paid: '),
//                 Checkbox(
//                   value: isPaid,
//                   onChanged: (value) {
//                     setState(() {
//                       isPaid = value!;
//                     });
//                   },
//                 ),
//               ],
//             ),
//             ElevatedButton(
//               onPressed: uploadStampVoucher,
//               child: Text('Upload Voucher'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
