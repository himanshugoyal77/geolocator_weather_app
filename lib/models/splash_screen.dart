import 'package:csi_flutter_workshop/home_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isAnimate = true;
  bool isClicked = false;

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isAnimate = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff3A4F7A).withOpacity(0.8),
      body: Stack(
        children: [
          // sun ka image
          AnimatedPositioned(
            top: 140,
            left: isAnimate ? -100 : 120,
            right: 90,
            duration: const Duration(seconds: 2),
            child: Center(
              child: Image.asset(
                "assets/sun.png",
                height: 100,
                width: 100,
              ),
            ),
          ),

          //cloud ka image
          AnimatedPositioned(
            top: 100,
            left: 70,
            right: isAnimate ? -100 : 70,
            duration: const Duration(seconds: 2),
            child: AnimatedScale(
              scale: isAnimate ? 0.4 : 1,
              duration: const Duration(seconds: 1),
              curve: Curves.elasticInOut,
              child: Center(
                child: Image.asset(
                  "assets/cloud.png",
                  height: 250,
                  width: 250,
                ),
              ),
            ),
          ),

          //lightening ka image
          Positioned(
            top: 180,
            left: 70,
            right: 60,
            child: AnimatedOpacity(
              duration: const Duration(seconds: 4),
              opacity: isAnimate ? 0.0 : 1.0,
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

          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Column(
              children: [
                const Text(
                  "Weather",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 45,
                      letterSpacing: 2),
                ),
                const Text(
                  "Forecasts",
                  style: TextStyle(
                      color: Colors.amber,
                      fontSize: 50,
                      letterSpacing: 2,
                      fontWeight: FontWeight.w300),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "Lorem Ipsum has the industry's standard \nwhen make a type specimen book.\nalso the leap into electronic typesetting.",
                  style: TextStyle(
                      // height: 1.3,
                      color: Colors.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      letterSpacing: 1.1,
                      wordSpacing: 1.1),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isClicked = true;
                    });

                    Future.delayed(const Duration(seconds: 3), () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                      );
                    });
                  },
                  child: AnimatedContainer(
                    height: 50,
                    width: isClicked ? 150 : 250,
                    curve: Curves.bounceInOut,
                    duration: const Duration(seconds: 3),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: Colors.amber,
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
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
