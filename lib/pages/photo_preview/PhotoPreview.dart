import 'dart:io';

import 'package:flutter/material.dart';
import 'package:libras_to_portuguese_app/models/classified_signed.dart';
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


        List recognitions2 = snapshot.data;

        for (var recognition in recognitions2) {
          print('recognitions: $recognition');
        }

        List<ClassifiedSigned> recognitions = (snapshot.data as List)
            .map<ClassifiedSigned>(
              (e) => ClassifiedSigned(
                index: e['index'],
                label: e['label'],
                confidence: e['confidence'],
              ),
            )
            .toList();

        for (var recognition in recognitions) {
          print('recognitions: $recognition');
        }

        return Scaffold(
          body: Column(
            children: [
              Center(
                child: Image.file(File(photoData)),
              ),
              Expanded(
                child: Text(
                  recognitions.first?.result() ?? "",
                  style: TextStyle(fontSize: 30.0),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
