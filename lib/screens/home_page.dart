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
                // onPressed: () async {
                //   await getImage(
                //     image != null
                //         ? Image.file(
                //             File(image!.path),
                //             // fit: BoxFit.fitWidth,
                //           )
                //         : Container(),
                //   );
                // },
                onPressed: getImage,
                child: Text("Get Image"),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                // onPressed: () async {
                //   // scanText(image!.path as XFile);
                //   //scanText(XFile(image!.path));
                //   await scanText(image!);
                // },
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
    final RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);

    // final inputImage = InputImage.fromFilePath(image.path);
    // final textRecognizer = TextRecognizer();
    // final recognizedText = await textRecognizer.processImage(inputImage);

    // final textDetector = GoogleMlKit.vision.textDetector();
    // RecognizedText recognizedText = await textDetector.processImage(inputImage);
    // await textDetector.close();
    // return recognizedText.text;

    for (TextBlock block in recognizedText.blocks) {
      for (TextLine line in block.lines) {
        scannedText += line.text + "\n";
      }
    }

    log("$scannedText");
    Navigator.of(context).pop();
    setState(() {});

    // for (TextBlock block in recognizedText.blocks) {
    //   setState(() {
    //     scannedText += block.text + "\n";
    //   });
    // }

    // Navigator.of(context).pop();
    // Navigator.of(context).push(
    //   MaterialPageRoute(
    //     builder: (context) => ScannedText(
    //       text: "",
    //     ),
    //   ),
    // );
  }

  Future getImage() async {
    // final pickedFile = await ImagePicker().pickImage(
    //     source: image != null ? ImageSource.gallery : ImageSource.camera);

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

  // Future getImage() async {
  //   var pickedImage;
  //   showBottomSheet(
  //     context: context,
  //     builder: (context) {
  //       return Column(
  //         mainAxisAlignment: MainAxisAlignment.spaceAround,
  //         children: [
  //           ListTile(
  //             leading: Icon(
  //               Icons.camera_alt_outlined,
  //             ),
  //             title: Text(
  //               "Camera",
  //             ),
  //             onTap: () {
  //               setState(() {
  //                 pickedImage =
  //                     ImagePicker().pickImage(source: ImageSource.camera);
  //                 if (pickedImage != null) {
  //                   image = pickedImage;
  //                   scanText(image!);
  //                 } else {
  //                   final snackBar = SnackBar(
  //                     content: Text(
  //                       "No image selected",
  //                     ),
  //                   );
  //                   // print("No image selected");
  //                 }
  //               });
  //             },
  //           ),
  //           ListTile(
  //             leading: Icon(
  //               Icons.photo_library_rounded,
  //             ),
  //             title: Text(
  //               "Photo Library",
  //             ),
  //             onTap: () {
  //               setState(() {
  //                 pickedImage =
  //                     ImagePicker().pickImage(source: ImageSource.gallery);
  //                 if (pickedImage != null) {
  //                   scanText(image!);
  //                 } else {
  //                   final snackBar = SnackBar(
  //                     content: Text(
  //                       "No image selected",
  //                     ),
  //                   );
  //                   // print("No image selected");
  //                 }
  //               });
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
}
