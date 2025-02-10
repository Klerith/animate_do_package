import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool animate = true;
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
            const Text(
              'Now with a simple Toggle',
              style: TextStyle(fontSize: 20),
            ),
            Text('Boolean animate value: $animate'),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                const Square().fadeIn(animate: animate),
                const Square().fadeInUp(animate: animate),
                const Square().fadeInDown(animate: animate),
                const Square().fadeInLeft(animate: animate),
                const Square().fadeInRight(animate: animate),
              ],
                
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  // controller.forward();
                  setState(() {
                    animate = !animate;
                  });
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
      color: const Color(0xff67549B),
    );
  }
}
