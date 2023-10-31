import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';

import 'BoardingPass.dart';

class VoucherUpload extends StatefulWidget {
  final String selectRoute;

  VoucherUpload({required this.selectRoute});

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
                    selectRoute: widget.selectRoute,
                  )),
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
