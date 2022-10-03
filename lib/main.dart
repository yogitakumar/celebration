import 'dart:math';
import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 10));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _confettiController.dispose();
  }

  /// A custom Path to paint stars.
  Path drawStar(Size size) {
    // Method to convert degree to radians
    double degToRad(double deg) => deg * (pi / 180.0);
    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);
    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ConfettiWidget(
                confettiController: _confettiController,
                shouldLoop: false,
                blastDirection: -3.14 / 2,
                colors: [Colors.orange, Colors.blue, Colors.green,Colors.yellow,Colors.red],
                gravity: 0.3,
                numberOfParticles: 10,
                createParticlePath: drawStar,
              ),
              //RotatedBox(
                 // quarterTurns: 2,
                   Image.network(
                      "https://t3.ftcdn.net/jpg/03/06/75/94/360_F_306759459_K1KWp8Re6RgHfSjJxYqFfe8amzTGHRfR.jpg",width: 100,height: 100,),
              //),
              ElevatedButton(
                  onPressed: () {
                    _confettiController.play();
                  },
                  child: Text("Play")),
            ],
          ),
        ));
  }
}