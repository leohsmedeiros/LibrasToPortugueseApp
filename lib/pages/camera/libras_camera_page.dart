import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'libras_camera_controller.dart';

class LibrasCameraPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
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

          return Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      child: AspectRatio(
                          aspectRatio: controller.aspectRatio,
                          child: controller.preview),
                    ),
                    // controller.preview,
                    Container(
                      width: double.infinity,
                      height: double.infinity,
                      child: CustomPaint(
                        painter:
                            OpenPainter(previewSize: controller.previewSize),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(20.0),
                      width: double.infinity,
                      color: Colors.black54,
                      child: Text('Posicione sua mão ao centro, faça o sinal\ne clique em \'Analisar\'',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white70)),
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(5.0),
                width: double.infinity,
                color: Theme.of(context).primaryColor,
                child: RaisedButton(
                  onPressed: () => controller.takePhoto(),
                  child: Text('Analisar'),
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
      ..strokeWidth = 5.0
      ..style = PaintingStyle.stroke;

    int width = 108;
    int height = 108;

    double centerImageX = Get.width / 2;
    double centerImageY = previewSize.height / 2;

    Rect rect = Rect.fromCenter(
        center: Offset(centerImageX, centerImageY),
        width: width.toDouble(),
        height: height.toDouble());

    canvas.drawRect(rect, paint1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
