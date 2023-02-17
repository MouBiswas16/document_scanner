// ignore_for_file: unused_local_variable

import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String scannedText = ""; // _text
  XFile? image; // _image

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Document Scanner"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 38),
              ElevatedButton(
                onPressed: getImage,
                child: Text("Get Image"),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: scanText,
                child: Text("Scan Object"),
              ),
              if (image != null)
                Image.file(
                  File(image!.path),
                  fit: BoxFit.fitWidth,
                ),
              Text("$scannedText"),
            ],
          ),
        ),
      ),
    );
  }

  Future scanText() async {
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    if (image == null) {
      log("got null on image file");
      return;
    }

    InputImage inputImage = InputImage.fromFilePath(image!.path);
    final textRecognizer = TextRecognizer();
    final recognizedText = await textRecognizer.processImage(inputImage);

    for (TextBlock block in recognizedText.blocks) {
      for (TextLine line in block.lines) {
        scannedText += line.text + "\n";
      }
    }

    log("$scannedText");
    Navigator.of(context).pop();
    setState(() {});
  }

  Future getImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        image = pickedFile;
      } else {
        print("No image selected");
      }
    });
  }
}
