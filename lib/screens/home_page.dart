// ignore_for_file: unused_field

import 'dart:io';

import 'package:document_scanner_flutter/document_scanner_flutter.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? _scannedImage;

  void _startScan(BuildContext context) async {
    var image = await DocumentScannerFlutter.launch(context);
    if (image != null) {
      setState(() {
        _scannedImage = image;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Document Scanner"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 38),
            ElevatedButton(
              onPressed: () => _startScan(context),
              child: Text("Scan Object"),
            ),
            SizedBox(height: 38),
            if (_scannedImage != null)
              Image.file(
                _scannedImage!,
                width: 500,
                height: 500,
              ),
            if (_scannedImage == null)
              Center(
                child: Text(
                  "You have not scanned a document yet",
                  style: TextStyle(fontSize: 20),
                  // textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
