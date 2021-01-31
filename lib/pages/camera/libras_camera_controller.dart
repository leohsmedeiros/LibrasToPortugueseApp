import 'dart:io';

import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:libras_to_portuguese_app/pages/photo_preview/PhotoPreview.dart';
import '../../main.dart';
import 'package:camera_platform_interface/camera_platform_interface.dart';

class LibrasCameraController extends GetxController {
  CameraController controller;

  bool get isInitialized => controller.value.isInitialized;

  double get aspectRatio => controller.value.aspectRatio;

  CameraPreview get preview => CameraPreview(controller);

  LibrasCameraController() {
    controller = CameraController(cameras[1], ResolutionPreset.medium);
    controller.initialize().then((_) => update());
  }

  takePhoto() async {
    await CameraPlatform.instance
        .takePicture(controller.cameraId)
        .then((xFile) => Get.to(PhotoPreview(photoData: File(xFile.path))));
  }
}
