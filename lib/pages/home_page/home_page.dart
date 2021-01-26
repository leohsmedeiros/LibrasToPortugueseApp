import 'package:flutter/material.dart';
import 'package:libras_to_portuguese_app/pages/camera/camera_page.dart';
import 'package:libras_to_portuguese_app/shared/routes/routes.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          child: Text('start'),
          onPressed: () => Navigator.pushNamed(context, Routes.getRouteName(CameraPage)),
        ),
      ),
    );
  }
}
