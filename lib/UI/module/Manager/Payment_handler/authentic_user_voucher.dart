import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../Authentication/models/User_model.dart';

// class VoucherDisplayScreen extends StatefulWidget {
//   final String voucherDocumentID;
//   final String voucherURL;
//
//   const VoucherDisplayScreen({
//     required this.voucherDocumentID,
//     required this.voucherURL,
//   });
//
//   @override
//   State<VoucherDisplayScreen> createState() => _VoucherDisplayScreenState();
// }
//
// class _VoucherDisplayScreenState extends State<VoucherDisplayScreen> {
//   @override
//   Widget build(BuildContext context) {
//     // Implement your voucher display screen here
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Voucher Display'),
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Text('Voucher Document ID: ${widget.voucherDocumentID}'),
//           SizedBox(height: 20),
//           Image.network(
//             widget.voucherURL,
//             width: 360,
//             height: 340,
//             fit: BoxFit.cover,
//           ),
//           SizedBox(height: 20),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               ElevatedButton(
//                 onPressed: () {
//                   // Implement your accept logic here
//                   showDialog(
//                     context: context,
//                     builder: (context) {
//                       return AlertDialog(
//                         title: Text('Accept Voucher'),
//                         content: Text('Do you want to accept this voucher?'),
//                         actions: [
//                           TextButton(
//                             onPressed: () {
//                               // Implement your accept logic here
//                               Navigator.pop(context);
//                             },
//                             child: Text('Accept'),
//                           ),
//                           TextButton(
//                             onPressed: () {
//                               Navigator.pop(context);
//                             },
//                             child: Text('Cancel'),
//                           ),
//                         ],
//                       );
//                     },
//                   );
//                 },
//                 child: Text('Accept'),
//               ),
//               SizedBox(width: 20),
//               ElevatedButton(
//                 onPressed: () {
//                   // Implement your reject logic here
//                   showDialog(
//                     context: context,
//                     builder: (context) {
//                       return AlertDialog(
//                         title: Text('Reject Voucher'),
//                         content: Text('Do you want to reject this voucher?'),
//                         actions: [
//                           TextButton(
//                             onPressed: () {
//                               // Implement your reject logic here
//                               Navigator.pop(context);
//                             },
//                             child: Text('Reject'),
//                           ),
//                           TextButton(
//                             onPressed: () {
//                               Navigator.pop(context);
//                             },
//                             child: Text('Cancel'),
//                           ),
//                         ],
//                       );
//                     },
//                   );
//                 },
//                 child: Text('Reject'),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

class VoucherDisplayScreen extends StatefulWidget {
  final String voucherDocumentID;
  final String voucherURL;

  const VoucherDisplayScreen({
    required this.voucherDocumentID,
    required this.voucherURL,
  });

  @override
  State<VoucherDisplayScreen> createState() => _VoucherDisplayScreenState();
}

class _VoucherDisplayScreenState extends State<VoucherDisplayScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Voucher Display'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Voucher Document ID: ${widget.voucherDocumentID}'),
          SizedBox(height: 20),
          Image.network(
            widget.voucherURL,
            width: 360,
            height: 340,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Accept logic
                  Navigator.pop(context, true); // Pass 'true' as the result
                },
                child: Text('Accept'),
              ),
              SizedBox(width: 20),
              ElevatedButton(
                onPressed: () {
                  // Reject logic
                  Navigator.pop(context, false); // Pass 'false' as the result
                },
                child: Text('Reject'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
