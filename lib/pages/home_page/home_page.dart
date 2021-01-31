import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:libras_to_portuguese_app/pages/camera/libras_camera_page.dart';

class HomePage extends StatelessWidget {
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
