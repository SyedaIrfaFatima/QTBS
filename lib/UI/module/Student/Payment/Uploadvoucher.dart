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
//         FirebaseStorage.instance.ref().child('vouchers/${user.uid}');
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
//                 elevation: 5,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(10),
//                   child: GestureDetector(
//                     onTap: () => _getImage(),
//                     child: Image.file(
//                       _image!,
//                       width: 360,
//                       height: 340,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//               )
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

  VoucherUpload({required this.selectRoute, required this.fee});

  @override
  State<VoucherUpload> createState() => _VoucherUploadState();
}

class _VoucherUploadState extends State<VoucherUpload> {
  bool _isVerifying = false;
  File? _image;
  bool _showUploadButton = true;

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp(); // Initialize Firebase
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

  // Future<void> _uploadVoucher() async {
  //   setState(() {
  //     _isVerifying = true;
  //   });
  //
  //   try {
  //     final user = FirebaseAuth.instance.currentUser;
  //     if (user != null) {
  //       final storageReference =
  //           FirebaseStorage.instance.ref().child('vouchers/${user.uid}');
  //
  //       // Upload image to Firebase Cloud Storage
  //       if (_image != null) {
  //         await storageReference.putFile(_image!);
  //
  //         // Get the download URL of the uploaded image
  //         final downloadURL = await storageReference.getDownloadURL();
  //         print('Image uploaded. Download URL: $downloadURL');
  //
  //         // Store the voucher URL in Firestore
  //         await FirebaseFirestore.instance
  //             .collection('Vouchers')
  //             .doc(user.uid)
  //             .set({
  //           'studentId': user.uid,
  //           'voucherURL': downloadURL,
  //           // Add other relevant information like timestamp, selectRoute, fee, etc.
  //         });
  //
  //         setState(() {
  //           _showUploadButton = false;
  //         });
  //       }
  //     }
  //
  //     // Simulate voucher verification delay.
  //     await Future.delayed(Duration(seconds: 3));
  //   } catch (e) {
  //     print('Error uploading image: $e');
  //   } finally {
  //     setState(() {
  //       _isVerifying = false;
  //     });
  //   }
  // }

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
            'status': 'pending', // Add a status field to track voucher status
          });

          setState(() {
            _showUploadButton = false;
          });
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
      }
    } catch (e) {
      print('Error uploading image: $e');
    } finally {
      setState(() {
        _isVerifying = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
              _image != null
                  ? Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: GestureDetector(
                          onTap: () => _getImage(),
                          child: Image.file(
                            _image!,
                            width: 360,
                            height: 340,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    )
                  : Container(),
              SizedBox(height: 20),
              if (_showUploadButton && !_isVerifying)
                ElevatedButton(
                  onPressed: () async {
                    await _getImage();
                    _uploadVoucher();
                  },
                  child: Text('Upload Voucher'),
                ),
              if (_isVerifying) SizedBox(height: 20),
              if (_isVerifying) Text('Your voucher is verifying...'),
            ],
          ),
        ),
      ),
    );
  }
}

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
//
//   @override
//   void initState() {
//     super.initState();
//     Firebase.initializeApp(); // Initialize Firebase
//   }
//
//   Future<void> _getImageAndUpload() async {
//     final imagePicker = ImagePicker();
//     final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
//
//     if (pickedFile != null) {
//       setState(() {
//         _image = File(pickedFile.path);
//       });
//
//       await _uploadVoucher();
//     }
//   }
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
//           // Navigate to the boarding pass screen
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) =>
//                   BoardingPass(selectRoute: 'selectRoute', fee: 'fee'),
//             ),
//           );
//         }
//       }
//
//       // Simulate voucher verification delay.
//       await Future.delayed(Duration(seconds: 5));
//
//       // Check if the voucher is accepted by the manager
//       final voucherSnapshot = await FirebaseFirestore.instance
//           .collection('Vouchers')
//           .doc(user?.uid)
//           .get();
//
//       if (voucherSnapshot.exists) {
//         final status = voucherSnapshot['status'];
//         if (status == 'rejected') {
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
//               GestureDetector(
//                 onTap: () => _getImageAndUpload(),
//                 child: Container(
//                   width: 200,
//                   height: 200,
//                   decoration: BoxDecoration(
//                     color: Colors.grey[300],
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: _image != null
//                       ? Image.file(
//                           _image!,
//                           width: 200,
//                           height: 200,
//                           fit: BoxFit.cover,
//                         )
//                       : Icon(
//                           Icons.upload_file,
//                           size: 100,
//                         ),
//                 ),
//               ),
//               SizedBox(height: 20),
//               if (_isVerifying) Text('Your voucher is verifying...'),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

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
//
//   @override
//   void initState() {
//     super.initState();
//     Firebase.initializeApp(); // Initialize Firebase
//     _loadVoucherImage();
//   }
//
//   // Check if there is an uploaded image and load it
//   Future<void> _loadVoucherImage() async {
//     final user = FirebaseAuth.instance.currentUser;
//     if (user != null) {
//       final storageReference =
//           FirebaseStorage.instance.ref().child('vouchers/${user.uid}');
//
//       try {
//         final downloadURL = await storageReference.getDownloadURL();
//         setState(() {
//           _image = File(downloadURL);
//         });
//       } catch (e) {
//         // No uploaded image found, do nothing
//       }
//     }
//   }
//
//   Future<void> _getImageAndUpload() async {
//     final imagePicker = ImagePicker();
//     final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
//
//     if (pickedFile != null) {
//       setState(() {
//         _image = File(pickedFile.path);
//       });
//
//       await _uploadVoucher();
//     }
//   }
//
//   Future<void> _uploadVoucher() async {
//     // ... (unchanged code for voucher upload)
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
//               GestureDetector(
//                 onTap: () => _getImageAndUpload(),
//                 child: Container(
//                   width: 200,
//                   height: 200,
//                   decoration: BoxDecoration(
//                     color: Colors.grey[300],
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: _image != null
//                       ? Image.file(
//                           _image!,
//                           width: 200,
//                           height: 200,
//                           fit: BoxFit.cover,
//                         )
//                       : Icon(
//                           Icons.upload_file,
//                           size: 100,
//                         ),
//                 ),
//               ),
//               SizedBox(height: 20),
//               if (_isVerifying) Text('Your voucher is verifying...'),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

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
//   String? _voucherURL;
//
//   @override
//   void initState() {
//     super.initState();
//     Firebase.initializeApp(); // Initialize Firebase
//     _loadVoucherStatus();
//   }
//
//   Future<void> _loadVoucherStatus() async {
//     final user = FirebaseAuth.instance.currentUser;
//     if (user != null) {
//       final voucherSnapshot = await FirebaseFirestore.instance
//           .collection('Vouchers')
//           .doc(user.uid)
//           .get();
//
//       if (voucherSnapshot.exists) {
//         final status = voucherSnapshot['status'];
//         if (status == 'accepted' || status == 'pending') {
//           // Fetch the voucher URL
//           setState(() {
//             _voucherURL = voucherSnapshot['voucherURL'];
//             _showUploadButton = false;
//           });
//         }
//       }
//     }
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
//             'status': 'pending',
//           });
//
//           // Display the uploaded voucher image when tapped
//           _showUploadedVoucher(downloadURL);
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
//           // Manager rejected the voucher, handle rejection
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
//   // Function to display the uploaded image when tapped
//   void _showUploadedVoucher(String downloadURL) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           content: GestureDetector(
//             onTap: () {
//               Navigator.pop(context);
//               // Handle the tap action, e.g., navigate to a detailed view
//             },
//             child: Image.network(
//               downloadURL,
//               width: 360,
//               height: 340,
//               fit: BoxFit.cover,
//             ),
//           ),
//         );
//       },
//     );
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
//               _voucherURL != null
//                   ? Card(
//                       elevation: 5,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(10),
//                         child: GestureDetector(
//                           onTap: () {
//                             // Display the uploaded voucher image when tapped
//                             _showUploadedVoucher(_voucherURL!);
//                           },
//                           child: Image.network(
//                             _voucherURL!,
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
