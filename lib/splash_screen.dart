import 'dart:async';
import 'package:flutter/material.dart';
import 'package:weather_app/screens/weather_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isAnimate = true;
  bool isClicked = false;

  final width = 50;

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), (() {
      setState(() {
        isAnimate = false;
      });
    }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff3A4F7A).withOpacity(0.8),
        body: Stack(
          children: [
            AnimatedPositioned(
              top: 140,
              left: isAnimate ? -100 : 120,
              right: 70,
              duration: const Duration(seconds: 3),
              child: Center(
                child: Image.asset(
                  "assets/sun.png",
                  height: 100,
                  width: 100,
                ),
              ),
            ),
            AnimatedPositioned(
              top: 100,
              left: 70,
              right: isAnimate ? -100 : 70,
              duration: const Duration(seconds: 3),
              child: AnimatedScale(
                scale: isAnimate ? 0.4 : 1,
                curve: Curves.elasticInOut,
                duration: const Duration(seconds: 1),
                child: Image.asset(
                  "assets/cloud.png",
                  height: 250,
                  width: 250,
                ),
              ),
            ),
            Positioned(
              top: 180,
              left: 70,
              right: 60,
              child: AnimatedOpacity(
                duration: const Duration(seconds: 4),
                opacity: isAnimate ? 0.0 : 1.0,
                curve: Curves.bounceIn,
                child: Transform.rotate(
                  angle: 0.8,
                  child: Image.asset(
                    "assets/light.png",
                    height: 250,
                    width: 250,
                  ),
                ),
              ),
            ),
            const Positioned(
              bottom: 270,
              left: 0,
              right: 0,
              child: Text(
                "WEATHER",
                style: TextStyle(
                    color: Color(0xffffffff),
                    fontSize: 45,
                    letterSpacing: 3,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            const Positioned(
              left: 0,
              right: 0,
              bottom: 220,
              child: Text(
                "Forecasts",
                style: TextStyle(
                    color: Colors.amber,
                    fontSize: 50,
                    letterSpacing: 2,
                    fontWeight: FontWeight.w300),
                textAlign: TextAlign.center,
              ),
            ),
            const Positioned(
              bottom: 160,
              left: 40,
              right: 40,
              child: Text(
                "Lorem Ipsum has the industry's standard \nwhen make a type specimen book.\nalso the leap into electronic typesetting.",
                style: TextStyle(
                    height: 1.3,
                    color: Colors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    letterSpacing: 1.1,
                    wordSpacing: 1.1),
                textAlign: TextAlign.center,
              ),
            ),
            AnimatedPositioned(
              bottom: 80,
              left: isClicked ? 120 : 70,
              right: isClicked ? 120 : 70,
              curve: Curves.bounceIn,
              duration: const Duration(seconds: 1),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isClicked = true;
                  });

                  Future.delayed(const Duration(seconds: 1), (() {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => const HomeScreen())));
                  }));
                },
                child: AnimatedContainer(
                  height: 50,
                  width: 250,
                  curve: Curves.bounceInOut,
                  duration: const Duration(seconds: 3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: isClicked ? Colors.amber.shade700 : Colors.amber,
                  ),
                  child: const Center(
                    child: Text(
                      "Get Started",
                      style: TextStyle(
                          color: Color(0xff3A4F7A),
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
