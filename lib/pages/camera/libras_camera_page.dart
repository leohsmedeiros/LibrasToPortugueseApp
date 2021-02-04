import 'package:camera/camera.dart';
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
          if (!controller.isInitialized) {
            return Container();
          }

          return Stack(
            children: [
              // AspectRatio(
              //     aspectRatio: controller.aspectRatio,
              //     child: controller.preview),
              controller.preview,
              Container(
                width: double.infinity,
                height: double.infinity,
                child: CustomPaint(
                  painter: OpenPainter(previewSize: controller.previewSize),
                ),
              ),
              Container(
                // alignment: Alignment.bottomCenter,
                padding: const EdgeInsets.all(5.0),
                width: double.infinity,
                color: Theme.of(context).primaryColor,
                child: RawMaterialButton(
                  onPressed: () => controller.takePhoto(),
                  fillColor: Theme.of(context).primaryColorDark,
                  child: Icon(Icons.camera_alt, color: Colors.white, size: 30),
                  shape: CircleBorder(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class OpenPainter extends CustomPainter {
  final Size previewSize;

  OpenPainter({this.previewSize});

  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = Color(0xff638965)
      ..style = PaintingStyle.fill;
    //a rectangle
    // canvas.drawRect(Offset(100, 100) & Size(200, 100), paint1);
    int width = 200;
    int height = 200;

    // int offsetX = ((Get.width/2) - (width/2)).ceil();
    // int offsetY = ((Get.height/2) - (height/2)).ceil();

    double centerImageX = Get.width / 2;
    double centerImageY = previewSize.height / 2;

    Offset p1 = Offset(centerImageX - (width / 2), centerImageY - (height / 2));
    Offset p2 = Offset(centerImageX + (width / 2), centerImageY - (height / 2));

    canvas.drawLine(p1, p2, paint1);

    Offset p3 = Offset(centerImageX + (width / 2), centerImageY - (height / 2));
    Offset p4 = Offset(centerImageX + (width / 2), centerImageY + (height / 2));
    canvas.drawLine(p3, p4, paint1);

    Offset p5 = Offset(centerImageX + (width / 2), centerImageY + (height / 2));
    Offset p6 = Offset(centerImageX - (width / 2), centerImageY + (height / 2));
    canvas.drawLine(p5, p6, paint1);

    Offset p7 = Offset(centerImageX - (width / 2), centerImageY + (height / 2));
    Offset p8 = Offset(centerImageX - (width / 2), centerImageY - (height / 2));
    canvas.drawLine(p7, p8, paint1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
