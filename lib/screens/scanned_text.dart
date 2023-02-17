import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';

class ScannedText extends StatefulWidget {
  final String text;
  ScannedText({required this.text});

  @override
  State<ScannedText> createState() => _ScannedTextState();
}

class _ScannedTextState extends State<ScannedText> {
  final GlobalKey<ScaffoldState> _key = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        title: Text("Scanned Text"),
        actions: [
          IconButton(
            icon: Icon(Icons.copy),
            onPressed: () async {
              await FlutterClipboard.copy(widget.text).then((value) => _key
                  .currentState!
                  .showBottomSheet((context) => Text("Copied!")));
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        alignment: Alignment.center,
        height: double.infinity,
        width: double.infinity,
        child: SelectableText(
            widget.text.isEmpty ? "No text Available" : widget.text),
      ),
    );
  }
}
