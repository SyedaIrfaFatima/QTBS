import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_project/UI/module/Student/Payment/BoardingPass.dart';

import '../../Manager/Payment_handler/student_voucher_check.dart';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
//
// class VoucherUpload extends StatefulWidget {
//   final String selectRoute;
//   final String fee;
//
//   VoucherUpload({required this.selectRoute, required this.fee});
//
//   @override
//   State<VoucherUpload> createState() => _VoucherUploadState();
// }
//
// class _VoucherUploadState extends State<VoucherUpload> {
//   bool _isVerifying = false;
//   File? _image;
//   bool _showUploadButton = true;
//
//   @override
//   void initState() {
//     super.initState();
//     Firebase.initializeApp(); // Initialize Firebase
//   }
//
//   Future<void> _getImage() async {
//     final imagePicker = ImagePicker();
//     final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
//
//     if (pickedFile != null) {
//       setState(() {
//         _image = File(pickedFile.path);
//         _showUploadButton = true;
//       });
//     }
//   }
//
//   // Future<void> _uploadVoucher() async {
//   //   setState(() {
//   //     _isVerifying = true;
//   //   });
//   //
//   //   try {
//   //     final user = FirebaseAuth.instance.currentUser;
//   //     if (user != null) {
//   //       final storageReference =
//   //           FirebaseStorage.instance.ref().child('vouchers/${user.uid}');
//   //
//   //       // Upload image to Firebase Cloud Storage
//   //       if (_image != null) {
//   //         await storageReference.putFile(_image!);
//   //
//   //         // Get the download URL of the uploaded image
//   //         final downloadURL = await storageReference.getDownloadURL();
//   //         print('Image uploaded. Download URL: $downloadURL');
//   //
//   //         // Store the voucher URL in Firestore
//   //         await FirebaseFirestore.instance
//   //             .collection('Vouchers')
//   //             .doc(user.uid)
//   //             .set({
//   //           'studentId': user.uid,
//   //           'voucherURL': downloadURL,
//   //           // Add other relevant information like timestamp, selectRoute, fee, etc.
//   //         });
//   //
//   //         setState(() {
//   //           _showUploadButton = false;
//   //         });
//   //       }
//   //     }
//   //
//   //     // Simulate voucher verification delay.
//   //     await Future.delayed(Duration(seconds: 3));
//   //   } catch (e) {
//   //     print('Error uploading image: $e');
//   //   } finally {
//   //     setState(() {
//   //       _isVerifying = false;
//   //     });
//   //   }
//   // }
//
//   Future<void> _uploadVoucher() async {
//     setState(() {
//       _isVerifying = true;
//     });
//
//     try {
//       final user = FirebaseAuth.instance.currentUser;
//       if (user != null) {
//         final storageReference =
//             FirebaseStorage.instance.ref().child('vouchers/${user.uid}');
//
//         // Upload image to Firebase Cloud Storage
//         if (_image != null) {
//           await storageReference.putFile(_image!);
//
//           // Get the download URL of the uploaded image
//           final downloadURL = await storageReference.getDownloadURL();
//           print('Image uploaded. Download URL: $downloadURL');
//
//           // Store the voucher URL in Firestore
//           await FirebaseFirestore.instance
//               .collection('Vouchers')
//               .doc(user.uid)
//               .set({
//             'studentId': user.uid,
//             'voucherURL': downloadURL,
//             'status': 'pending', // Add a status field to track voucher status
//           });
//
//           setState(() {
//             _showUploadButton = false;
//           });
//         }
//       }
//
//       // Simulate voucher verification delay.
//       await Future.delayed(Duration(seconds: 59));
//
//       // Check if the voucher is accepted by the manager
//       final voucherSnapshot = await FirebaseFirestore.instance
//           .collection('Vouchers')
//           .doc(user?.uid)
//           .get();
//
//       if (voucherSnapshot.exists) {
//         final status = voucherSnapshot['status'];
//         if (status == 'accepted') {
//           // Manager accepted the voucher, navigate to the boarding pass screen
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) =>
//                   BoardingPass(selectRoute: 'selectRoute', fee: 'fee'),
//             ),
//           );
//         } else if (status == 'rejected') {
//           // Manager rejected the voucher, handle rejection (show an error message or navigate to an error screen)
//           showDialog(
//             context: context,
//             builder: (context) {
//               return AlertDialog(
//                 title: Text('Voucher Rejected'),
//                 content: Text('Your voucher has been rejected by the manager.'),
//                 actions: [
//                   TextButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     child: Text('OK'),
//                   ),
//                 ],
//               );
//             },
//           );
//         }
//       }
//     } catch (e) {
//       print('Error uploading image: $e');
//     } finally {
//       setState(() {
//         _isVerifying = false;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Upload Voucher'),
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               _image != null
//                   ? Card(
//                       elevation: 5,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(10),
//                         child: GestureDetector(
//                           onTap: () => _getImage(),
//                           child: Image.file(
//                             _image!,
//                             width: 360,
//                             height: 340,
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       ),
//                     )
//                   : Container(),
//               SizedBox(height: 20),
//               if (_showUploadButton && !_isVerifying)
//                 ElevatedButton(
//                   onPressed: () async {
//                     await _getImage();
//                     _uploadVoucher();
//                   },
//                   child: Text('Upload Voucher'),
//                 ),
//               if (_isVerifying) SizedBox(height: 20),
//               if (_isVerifying) Text('Your voucher is verifying...'),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class VoucherUpload extends StatefulWidget {
  final String selectRoute;
  final String fee;
  final String? uploadedVoucherURL;
  final void Function(String voucherURL) onVoucherUploaded;
  final void Function(String status) onStatusChanged; // Add this line
// Callback function// Callback function

  VoucherUpload({
    required this.selectRoute,
    required this.fee,
    this.uploadedVoucherURL,
    required this.onVoucherUploaded,
    required this.onStatusChanged,
  });

  @override
  State<VoucherUpload> createState() => _VoucherUploadState();
}

class _VoucherUploadState extends State<VoucherUpload> {
  bool _isVerifying = false;
  File? _image;
  bool _showUploadButton = true;
  String? _uploadedVoucherURL;

  @override
  void initState() {
    super.initState();
    if (Firebase.apps.isEmpty) {
      Firebase.initializeApp();
    }
  }

  Future<void> _getImage() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _showUploadButton = true;
      });
    }
  }

  Future<void> _uploadVoucher() async {
    setState(() {
      _isVerifying = true;
    });

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final storageReference =
            FirebaseStorage.instance.ref().child('vouchers/${user.uid}');

        // Upload image to Firebase Cloud Storage
        if (_image != null) {
          await storageReference.putFile(_image!);

          // Get the download URL of the uploaded image
          final downloadURL = await storageReference.getDownloadURL();
          print('Image uploaded. Download URL: $downloadURL');

          // Store the voucher URL in Firestore
          await FirebaseFirestore.instance
              .collection('Vouchers')
              .doc(user.uid)
              .set({
            'studentId': user.uid,
            'voucherURL': downloadURL,
            'status': 'pending',
          });

          setState(() {
            _showUploadButton = false;
          });

          // Notify the parent widget (home screen) that the voucher has been uploaded
          // if (widget.onVoucherUploaded != null) {
          //   widget.onVoucherUploaded!(downloadURL);
          // }
        }
      }

      // Simulate voucher verification delay.
      await Future.delayed(Duration(seconds: 59));

      // Check if the voucher is accepted by the manager
      final voucherSnapshot = await FirebaseFirestore.instance
          .collection('Vouchers')
          .doc(user?.uid)
          .get();

      if (voucherSnapshot.exists) {
        final status = voucherSnapshot['status'];
        if (status == 'accepted') {
          // Manager accepted the voucher, navigate to the boarding pass screen
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  BoardingPass(selectRoute: 'selectRoute', fee: 'fee'),
            ),
          );
        } else if (status == 'rejected') {
          // Manager rejected the voucher, handle rejection (show an error message or navigate to an error screen)
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Voucher Rejected'),
                content: Text('Your voucher has been rejected by the manager.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        }
        widget.onStatusChanged(
            status); // Notify the parent about the status change
      }
    } catch (e) {
      print('Error uploading image: $e');
    } finally {
      setState(() {
        _isVerifying = false;
      });
    }
  }

  Widget build(BuildContext context) {
    _uploadedVoucherURL = widget.uploadedVoucherURL;
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Voucher'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Display the uploaded voucher URL if available
              if (widget.uploadedVoucherURL != null)
                Text('Uploaded Voucher URL: ${widget.uploadedVoucherURL}'),
              SizedBox(height: 20),
              // Display the image if available
              if (_image != null)
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(
                      _image!,
                      width: 360,
                      height: 340,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              SizedBox(height: 20),
              // Display the Upload Voucher button only if an image is not present
              if (_showUploadButton && !_isVerifying && _image == null)
                ElevatedButton(
                  onPressed: () async {
                    await _getImage();
                    _uploadVoucher();
                  },
                  child: Text('Upload Voucher'),
                ),
              // Display verifying message
              if (_isVerifying) SizedBox(height: 20),
              if (_isVerifying) Text('Your voucher is verifying...'),
            ],
          ),
        ),
      ),
    );
  }
}
