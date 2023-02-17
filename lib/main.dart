import 'package:flutter/material.dart';
import 'package:pdfscanner/screens/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Document Scanner",
      home: HomePage(),
    ),
  );
}
