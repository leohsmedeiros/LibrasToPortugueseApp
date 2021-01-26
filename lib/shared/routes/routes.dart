import 'package:flutter/material.dart';
import 'package:libras_to_portuguese_app/pages/camera/camera_page.dart';
import 'package:libras_to_portuguese_app/pages/home_page/home_page.dart';

class Routes {
  static getRoutes(BuildContext context) {
    return {
      '/': (context) => HomePage(),
      getRouteName(CameraPage): (context) => CameraPage(),
    };
  }

  static String getRouteName(className) {
    return '/${(className).toString()}';
  }
}
