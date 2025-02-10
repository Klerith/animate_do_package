import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AnimationController controller;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      theme: ThemeData.light(useMaterial3: true),
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('With controller', style: TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                // Extract the controller
                const Square().bounce(
                  manualTrigger: true,
                  controller: (animationCtrl) => controller = animationCtrl,
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  controller.reset();
                  controller.forward();
                },
                child: const Text('Toggle animation'))
          ],
        ),
      ),
    );
  }
}

class Square extends StatelessWidget {
  const Square({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      color: Colors.blueAccent,
    );
  }
}
