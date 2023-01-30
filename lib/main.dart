import 'package:flutter/material.dart';
import 'package:pdfscanner/screens/home_page.dart';

void main(List<String> args) {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Document Scanner",
      home: HomePage(),
    ),
  );
}
