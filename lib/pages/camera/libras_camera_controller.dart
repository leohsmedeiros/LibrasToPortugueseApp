import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:libras_to_portuguese_app/pages/photo_preview/PhotoPreview.dart';
import '../../main.dart';
import 'package:camera_platform_interface/camera_platform_interface.dart';
import 'package:opencv/opencv.dart';
import 'package:image/image.dart' as imglib;

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

  takePhoto() async {



    await CameraPlatform.instance
        .takePicture(controller.cameraId)

        .then((xFile) async {
      // var bytes = await xFile.readAsBytes();
      // Image.memory(bytes).centerSlice;
      var bytes = await xFile.readAsBytes();
      imglib.Image image = imglib.decodeImage(bytes);
      int width = 200;
      int height = 200;

      int offsetX = ((image.width/2) - (width/2)).ceil();
      int offsetY = ((image.height/2) - (height/2)).ceil();

      Get.to(PhotoPreview(photoData: imglib.copyCrop(image, offsetX, offsetY, width, height)));

      // Image image = Image.memory(bytes, centerSlice: Rect.fromCenter(center: Offset(Get.width/2, Get.height/2), height: 100, width: 100));
      // Get.to(PhotoPreview(photoData: image));


      //   return ImageCrop.cropImage(
    //
    //       file: File(xFile.path),
    //       scale: 1,
    //       area: Rect.fromCenter(center: Offset(Get.width/2, Get.height/2), height: 100, width: 100));
    })
    //     .then((croppedImage) => croppedImage.readAsBytes())
    //     .then((bytes) {
    //       String byteString = '';
    //       for (var bit in bytes) {
    //         byteString += '$bit ';
    //       }
    //
    //       print('bytes Length: ${bytes.length}');
    //       print('byteString: $byteString');
    //       print('bytes.toString(): ${bytes.toString()}');
    //       // return ImgProc.canny(bytes, 50, 200);
    //
    //       return Future.value(bytes);
    //     })
    //     .then((imgData) => Get.to(PhotoPreview(photoData: imgData)))
        .catchError((error, stack) {
          print('ERROR: ${error.toString()}');
          debugPrintStack(stackTrace: stack);
        });

    // .then((cannyImg) =>
    //     ImgProc.houghLines(cannyImg, threshold: 300, lineColor: "#ff0000"))
    // .then((imgData) => Get.to(PhotoPreview(photoData: imgData)));
  }
}
