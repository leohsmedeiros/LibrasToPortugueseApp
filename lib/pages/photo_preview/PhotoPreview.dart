import 'package:flutter/material.dart';
import 'package:image/image.dart' as imgLib;

class PhotoPreview extends StatelessWidget {
  final imgLib.Image photoData;

  PhotoPreview({@required this.photoData});

  @override
  Widget build(BuildContext context) {
    Image image = Image.memory(imgLib.encodePng(photoData));

    return Scaffold(
      body: Center(
        child: image,
        // child: photoData,
      )
    );
  }
}
