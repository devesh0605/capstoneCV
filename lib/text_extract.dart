import 'dart:io';

import 'package:capstone_cv/text_result.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';

class GetText extends StatefulWidget {
  @override
  _GetTextState createState() => _GetTextState();
}

class _GetTextState extends State<GetText> {
  String _text = '';
  bool isImagePicked = false;
  late PickedFile _image;
  final picker = ImagePicker();
  final textDetector = GoogleMlKit.vision.textDetector();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Text Recognition'),
          actions: [
            FlatButton(
              onPressed: getImageFromCamera,
              //onPressed: scanText,
              child: Text(
                'Camera',
                style: TextStyle(color: Colors.white),
              ),
            ),
            FlatButton(
              onPressed: getImageFromGallery,
              //onPressed: scanText,
              child: Text(
                'Gallery',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          tooltip: 'Click To Scan',
          onPressed: () async {
            final inputImage = InputImage.fromFilePath(_image.path);
            final RecognisedText recognisedText =
                await textDetector.processImage(inputImage);
            String text = recognisedText.text;
            for (TextBlock block in recognisedText.blocks) {
              final Rect rect = block.rect;
              final List<Offset> cornerPoints = block.cornerPoints;
              final String text = block.text;
              final List<String> languages = block.recognizedLanguages;

              for (TextLine line in block.lines) {
                // Same getters as TextBlock
                for (TextElement element in line.elements) {
                  // Same getters as TextBlock
                }
              }
            }
            print(text);

            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return Details(
                text: text,
              );
            }));
          },
          child: Icon(Icons.search),
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          child: isImagePicked
              ? Image.file(
                  File(_image.path),
                  fit: BoxFit.fitWidth,
                )
              : Container(),
        ));
  }

  // Future scanText() async {
  //   showDialog(
  //       context: context,
  //       child: Center(
  //         child: CircularProgressIndicator(),
  //       ));
  //   final FirebaseVisionImage visionImage =
  //   FirebaseVisionImage.fromFile(File(_image.path));
  //   final TextRecognizer textRecognizer =
  //   FirebaseVision.instance.textRecognizer();
  //   final VisionText visionText =
  //   await textRecognizer.processImage(visionImage);
  //
  //   for (TextBlock block in visionText.blocks) {
  //     for (TextLine line in block.lines) {
  //       _text += line.text + '\n';
  //     }
  //   }
  //
  //   Navigator.of(context).pop();
  //   Navigator.of(context)
  //       .push(MaterialPageRoute(builder: (context) => Details(_text)));
  // }

  Future getImageFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        isImagePicked = true;
        _image = pickedFile;
      } else {
        print('No image selected');
      }
    });
  }

  Future getImageFromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        isImagePicked = true;
        _image = pickedFile;
      } else {
        print('No image selected');
      }
    });
  }
}
