import 'dart:io';

import 'package:flutter/material.dart';

class PhotoPreview extends StatelessWidget {
  final File photoData;

  PhotoPreview({@required this.photoData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.file(photoData),
      )
    );
  }
}
