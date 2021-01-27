import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:camera_platform_interface/camera_platform_interface.dart';
import 'package:opencv/opencv.dart';

class CustomCameraPreview extends CameraPreview {
  CustomCameraPreview(this.controller) : super(controller);

  /*
    res = await ImgProc.canny(await file.readAsBytes(), 50, 200);
    res = await ImgProc.houghLines(await res,
    threshold: 300, lineColor: "#ff0000");
  */

  /// The controller for the camera that the preview is shown for.
  final CameraController controller;

  Future _imageFiltered() {
    return CameraPlatform.instance
        .takePicture(controller.cameraId)
        .then((xFile) => File(xFile.path).readAsBytes())
        .then((bytes) => ImgProc.canny(bytes, 50, 200))
        .then((cannyImg) =>
            ImgProc.houghLines(cannyImg, threshold: 300, lineColor: "#ff0000"));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _imageFiltered(),
      builder: (context, data) {
        if (data.hasError || !data.hasData) {
          return controller.value.isInitialized
              ? CameraPlatform.instance.buildPreview(controller.cameraId)
              : Container();
        } else {
          return controller.value.isInitialized
              ? Image.memory(data.data)
              : Container();
        }
      },
    );
  }
}
