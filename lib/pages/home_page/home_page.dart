import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:libras_to_portuguese_app/pages/camera/libras_camera_page.dart';
import 'package:tflite/tflite.dart';

class HomePage extends StatelessWidget {
  HomePage() {
    Tflite.loadModel(
            model: "assets/model_a_b/model_unquant.tflite",
            labels: "assets/model_a_b/labels.txt",
            numThreads: 1,
            // defaults to 1
            isAsset: true,
            // defaults to true, set to false to load resources outside assets
            useGpuDelegate:
                false // defaults to false, set to true to use GPU delegate
            )
        .then((res) => print('res: $res'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          child: Text('start'),
          onPressed: () => Get.to(LibrasCameraPage()),
        ),
      ),
    );
  }
}
