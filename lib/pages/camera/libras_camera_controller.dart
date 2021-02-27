import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tflite/tflite.dart';
import '../../main.dart';
import 'package:camera_platform_interface/camera_platform_interface.dart';

class LibrasCameraController extends GetxController {
  static LibrasCameraController get instance => LibrasCameraController._();

  CameraController _controller;

  String _classifiedSign = "";

  CameraValue get camera => _controller.value;

  CameraPreview get preview => CameraPreview(_controller);

  String get classifiedSign => _classifiedSign;

  bool _isProcessingImage = false;

  Timer _timer;

  LibrasCameraController._() {
    _controller = CameraController(cameras[1], ResolutionPreset.medium);
    _controller.initialize().then((_) {
      update();
      _timer = Timer.periodic(
        new Duration(seconds: 5),
        (timer) async {
          if (!_controller.value.isTakingPicture && !_isProcessingImage) {
            await takePhoto();
          }
        },
      );
    });
  }

/*
  imgLib.Image _cropImage(imgLib.Image image) {
    int width = 128;
    int height = 128;

    int offsetX = ((image.width / 2) - (width / 2)).ceil();
    int offsetY = ((image.height / 2) - (height / 2)).ceil();

    return imgLib.copyCrop(image, offsetX, offsetY, width, height);
  }
*/

  @override
  dispose() async {
    _timer.cancel();
    await _controller.dispose();
    super.dispose();
  }

  _onError(error, stack) {
    print('ERROR: ${error.toString()}');
    debugPrintStack(stackTrace: stack);
  }

  Future takePhoto() => CameraPlatform.instance
      .takePicture(_controller.cameraId)
      .then((xFile) {
        _isProcessingImage = true;
        return Tflite.runModelOnImage(
          path: xFile.path,
          numResults: 6,
          threshold: 0.05,
          imageMean: 127.5,
          imageStd: 127.5,
        );
      })
      .then((result) => (result != null && result.isNotEmpty)
          ? Future.value(_classifiedSign =
              result.first['label'].toString().split(" ").last)
          : Future.value(_classifiedSign = ""))
      .then((value) => update())
      .whenComplete(() => _isProcessingImage = false)
      .catchError(_onError);
}
