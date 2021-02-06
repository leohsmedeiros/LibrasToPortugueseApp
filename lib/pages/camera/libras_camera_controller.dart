import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:libras_to_portuguese_app/pages/photo_preview/PhotoPreview.dart';
import '../../main.dart';
import 'package:camera_platform_interface/camera_platform_interface.dart';
import 'package:image/image.dart' as imgLib;

class LibrasCameraController extends GetxController {
  CameraController controller;

  bool get isInitialized => controller.value.isInitialized;

  double get aspectRatio => controller.value.aspectRatio;

  Size get previewSize => controller.value.previewSize;

  CameraPreview get preview => CameraPreview(controller);

  LibrasCameraController() {
    controller = CameraController(cameras[1], ResolutionPreset.medium);
    controller.initialize().then((_) => update());
  }

  imgLib.Image _cropImage(imgLib.Image image) {
    int width = 128;
    int height = 128;

    int offsetX = ((image.width / 2) - (width / 2)).ceil();
    int offsetY = ((image.height / 2) - (height / 2)).ceil();

    return imgLib.copyCrop(image, offsetX, offsetY, width, height);
  }

  _onError(error, stack) {
    print('ERROR: ${error.toString()}');
    debugPrintStack(stackTrace: stack);
  }

  takePhoto() async {
    await CameraPlatform.instance
        .takePicture(controller.cameraId)
        .then((xFile) => xFile.readAsBytes())
        .then((bytes) => _cropImage(imgLib.decodeImage(bytes)))
        .then((imgLib.Image imageCropped) => Get.to(
            PhotoPreview(photoData: imgLib.flipHorizontal(imageCropped))))
        .catchError(_onError);
  }
}
