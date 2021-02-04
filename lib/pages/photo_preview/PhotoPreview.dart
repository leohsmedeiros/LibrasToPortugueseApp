import 'package:flutter/material.dart';
import 'package:image/image.dart' as imglib;

class PhotoPreview extends StatelessWidget {
  final dynamic photoData;

  PhotoPreview({@required this.photoData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.memory(imglib.encodeJpg(photoData)),
        // child: photoData,
      )
    );
  }
}
