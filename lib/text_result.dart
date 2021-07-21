import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class Details extends StatefulWidget {
  // final String text;
  //
  // Details(this.text);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  final GlobalKey<ScaffoldState> _key = new GlobalKey<ScaffoldState>();
  final FlutterTts flutterTts = FlutterTts();
  String dummyText =
      'I thought by eliminating half of life, the other half would thrive, but you have shown me… that’s impossible. As long as there are those that remember what was, there will always be those, that are unable to accept what can be. They will resist.';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        title: Text('Details'),
        actions: [
          IconButton(
            icon: Icon(Icons.speaker),
            onPressed: () async {
              await flutterTts.setLanguage('en-US');
              await flutterTts.setPitch(1);
              await flutterTts.speak(dummyText);
            },
          ),
          IconButton(
            icon: Icon(Icons.copy),
            onPressed: () {
              FlutterClipboard.copy(dummyText).then((value) =>
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('Copied'))));
              // _key
              // .currentState
              // .showSnackBar(new SnackBar(content: Text('Copied'))));
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        alignment: Alignment.center,
        height: double.infinity,
        width: double.infinity,
        child:
            SelectableText(dummyText.isEmpty ? 'No Text Available' : dummyText),
      ),
    );
  }
}
