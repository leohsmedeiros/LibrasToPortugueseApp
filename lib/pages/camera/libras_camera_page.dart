import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'libras_camera_controller.dart';

class LibrasCameraPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Camera'),
        automaticallyImplyLeading: true,
      ),
      body: GetBuilder(
        init: LibrasCameraController(),
        builder: (LibrasCameraController controller) {
          return (controller.isInitialized)
              ? Column(
                  children: [
                    Expanded(
                      flex: 8,
                      child: AspectRatio(
                          aspectRatio: controller.aspectRatio,
                          child: controller.preview),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: const EdgeInsets.all(5.0),
                        width: double.infinity,
                        color: Theme.of(context).primaryColor,
                        child: RawMaterialButton(
                          onPressed: () => controller.takePhoto(),
                          fillColor: Theme.of(context).primaryColorDark,
                          child: Icon(Icons.camera_alt,
                              color: Colors.white, size: 30),
                          shape: CircleBorder(),
                        ),
                      ),
                    )
                  ],
                )
              : Container();
        },
      ),
    );
  }
}
