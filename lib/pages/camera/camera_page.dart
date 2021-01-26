import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

class CameraPage extends StatefulWidget {
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  CameraController controller;
  TextStyle buttonTextStyle;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    buttonTextStyle = Theme.of(context).textTheme.button;
  }

  @override
  void initState() {
    super.initState();
    controller = CameraController(cameras[0], ResolutionPreset.medium);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }

    return Scaffold(
      backgroundColor: Color(0xAA001D34),
      appBar: AppBar(
        backgroundColor: Color(0xAA001D34),
        title: Text('Camera'),
        toolbarHeight: 50,
        automaticallyImplyLeading: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: MediaQuery.of(context).size.height - 150,
            child: AspectRatio(
                aspectRatio: controller.value.aspectRatio,
                child: CameraPreview(controller)),
          ),
          Container(
            width: double.infinity,
            height: 50,
            margin: EdgeInsets.all(10.0),
            child: RawMaterialButton(
              onPressed: () => _takePhoto(context),
              fillColor: Color(0xFF001D34),
              child:
              Icon(Icons.camera_alt, color: Colors.white30, size: 35),
              shape: CircleBorder(),
            ),
          )
        ],
      ),
    );
  }

  _takePhoto(BuildContext context) {
    // if (controller.value.isTakingPicture) {
    //   // A capture is already pending, do nothing.
    //   return null;
    // }
    // controller.takePicture().then((file) => Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //         builder: (_) => DocumentPreviewPage(
    //             documentCategory: widget.documentCategory,
    //             documentPhoto: file))));
  }

}
