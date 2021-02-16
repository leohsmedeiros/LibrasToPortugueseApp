import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        accentColor: Color(0xAA001D34),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePageTraining(),
    );
  }
}

class HomePageTraining extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [

            RaisedButton(
              child: Text('train dataset'),
              // onPressed: () => n.train(input: trainInput, expected: expected, learningRate: 0.1, epoch: 5000, visualize: true),
            ),
            RaisedButton(
              child: Text('predict'),
              // onPressed: () => print("result: ${n.predict(num5)}"),
            ),
          ],
        ),
      ),
    );
  }





}
