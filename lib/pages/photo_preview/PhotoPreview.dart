import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image/image.dart' as imgLib;
import 'package:tflite/tflite.dart';

class PhotoPreview extends StatelessWidget {
  final String photoData;

  PhotoPreview({@required this.photoData});

  @override
  Widget build(BuildContext context) {
    // Image image = Image.memory(imgLib.encodePng(photoData));

    return FutureBuilder(
      future: Tflite.runModelOnImage(
        path: photoData,
        numResults: 6,
        threshold: 0.05,
        imageMean: 127.5,
        imageStd: 127.5,
      ),
      builder: (context, snapshot) {
        if (snapshot.hasError || !snapshot.hasData) {
          return Center(
            child: Container(
              child: Text(snapshot.error?.toString() ?? 'Aguarde'),
            ),
          );
        }

        List recognitions = snapshot.data;

        recognitions.forEach((element) {
          print ('recognitions: $element');
        });

        return Scaffold(
          body: Center(
            child: Image.file(File(photoData)),
            // child: photoData,
          ),
        );
      },
    );
  }
}
