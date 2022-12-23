import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'package:weather_app/controller.dart/api_controller.dart';
import 'package:intl/intl.dart';
import '../models/weather_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double lat = 0;
  double lon = 0;

  void getCurrentPosition() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      LocationPermission asked = await Geolocator.requestPermission();
    } else {
      Position currenPostion = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      setState(() {
        lat = currenPostion.latitude;
        lon = currenPostion.longitude;
      });
    }
  }

  @override
  void initState() {
    getCurrentPosition();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final String day = DateFormat('EEEE').format(DateTime.now());
    String formatDate(DateTime date) => DateFormat("MMMM d").format(date);
    final String date = formatDate(DateTime.now());

    return Scaffold(
      backgroundColor: const Color(0xff3A4F7A).withOpacity(0.8),
      body: FutureBuilder(
        future: ApiController.getData(lat, lon),
        builder:
            (BuildContext context, AsyncSnapshot<List<WeatherModel>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          } else if (snapshot.hasData) {
            final snap = snapshot.data![0];
            final double temp = snap.main.temp - 273.14;
            return DataScreen(snap: snap, temp: temp, day: day, date: date);
          }

          return Container();
        },
      ),
    );
  }
}

class DataScreen extends StatefulWidget {
  DataScreen({
    Key? key,
    required this.snap,
    required this.temp,
    required this.day,
    required this.date,
  }) : super(key: key);

  final WeatherModel snap;
  final double temp;
  final String day;
  final String date;
  bool isHover = false;

  @override
  State<DataScreen> createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
  @override
  Widget build(BuildContext context) {
    final maxtemp = (widget.snap.main.tempMax - 273).floorToDouble();

    return Padding(
      padding: const EdgeInsets.only(left: 18, right: 18, top: 38),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              const Icon(
                CupertinoIcons.slider_horizontal_3,
                color: Colors.white,
                size: 26,
              ),
              const Spacer(),
              const Icon(
                CupertinoIcons.location_solid,
                color: Colors.white,
                size: 24,
              ),
              const SizedBox(
                width: 12,
              ),
              Text(
                "${widget.snap.name}, ${widget.snap.sys.country}",
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 50),
            height: 130,
            width: 180,
            child: Stack(
              children: [
                Center(
                  child: Text(
                    widget.temp.toString().substring(0, 2),
                    style: const TextStyle(
                        color: Colors.amber,
                        fontSize: 100,
                        letterSpacing: 2,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                const Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    "°",
                    style: TextStyle(
                        color: Colors.amber,
                        fontSize: 70,
                        letterSpacing: 2,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
          ),
          Text(
            "${widget.day}, ${widget.date}",
            style: const TextStyle(
                height: 1.3,
                color: Colors.grey,
                fontSize: 16,
                fontWeight: FontWeight.normal,
                letterSpacing: 1.1,
                wordSpacing: 1.1),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Maximum Temperature : $maxtemp",
            style: const TextStyle(
                height: 1.3,
                color: Colors.grey,
                fontSize: 16,
                fontWeight: FontWeight.normal,
                letterSpacing: 1.1,
                wordSpacing: 1.1),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 40,
          ),
          AnimatedRotation(
            turns: widget.isHover ? 1 : 0.5,
            curve: Curves.easeInOutCirc,
            duration: const Duration(seconds: 2),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    AnimatedRotation(
                      turns: widget.isHover ? 1 : 0.5,
                      curve: Curves.elasticIn,
                      duration: const Duration(seconds: 2),
                      child: InkWell(
                        onTap: (() {
                          setState(() {
                            widget.isHover = !widget.isHover;
                          });
                        }),
                        child: Container(
                          height: 180,
                          width: 150,
                          padding: const EdgeInsets.only(bottom: 18),
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.asset(
                                  "assets/cloud.png",
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.contain,
                                ),
                                Text(
                                  widget.snap.weather[0]["main"],
                                  style: const TextStyle(
                                      height: 1.3,
                                      color: Colors.grey,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.1,
                                      wordSpacing: 1.1),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  widget.snap.weather[0]["description"],
                                  style: const TextStyle(
                                      height: 1.3,
                                      color: Colors.amber,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.1,
                                      wordSpacing: 1.1),
                                  textAlign: TextAlign.center,
                                ),
                              ]),
                        ),
                      ),
                    ),
                    AnimatedRotation(
                      turns: widget.isHover ? 1 : 0.5,
                      curve: Curves.elasticIn,
                      duration: const Duration(seconds: 2),
                      child: Container(
                        height: 180,
                        width: 150,
                        padding: const EdgeInsets.only(bottom: 18),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Transform.rotate(
                                angle: 0.8,
                                child: Image.asset(
                                  "assets/light.png",
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              const Text(
                                "Pressure",
                                style: TextStyle(
                                    height: 1.3,
                                    color: Colors.grey,
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                    letterSpacing: 1.1,
                                    wordSpacing: 1.1),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                widget.snap.main.pressure.toString(),
                                style: const TextStyle(
                                    height: 1.3,
                                    color: Colors.amber,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.1,
                                    wordSpacing: 1.1),
                                textAlign: TextAlign.center,
                              ),
                            ]),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    AnimatedRotation(
                      turns: widget.isHover ? 1 : 0.5,
                      curve: Curves.elasticIn,
                      duration: const Duration(seconds: 2),
                      child: Container(
                        height: 180,
                        width: 150,
                        padding: const EdgeInsets.only(bottom: 18),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset(
                                "assets/sun.png",
                                height: 100,
                                width: 60,
                                fit: BoxFit.contain,
                              ),
                              const Text(
                                "Humidity",
                                style: TextStyle(
                                    height: 1.3,
                                    color: Colors.grey,
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                    letterSpacing: 1.1,
                                    wordSpacing: 1.1),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                widget.snap.main.humidity.toString(),
                                style: const TextStyle(
                                    height: 1.3,
                                    color: Colors.amber,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.1,
                                    wordSpacing: 1.1),
                                textAlign: TextAlign.center,
                              ),
                            ]),
                      ),
                    ),
                    AnimatedRotation(
                      turns: widget.isHover ? 1 : 0.5,
                      curve: Curves.elasticIn,
                      duration: const Duration(seconds: 2),
                      child: Container(
                        height: 180,
                        width: 150,
                        padding: const EdgeInsets.only(bottom: 18),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset(
                                "assets/wind.png",
                                height: 100,
                                width: 100,
                                fit: BoxFit.contain,
                              ),
                              const Text(
                                "Wind Speed (m/s)",
                                style: TextStyle(
                                  height: 1.3,
                                  color: Colors.grey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                widget.snap.wind.speed.toString(),
                                style: const TextStyle(
                                    height: 1.3,
                                    color: Colors.amber,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.1,
                                    wordSpacing: 1.1),
                                textAlign: TextAlign.center,
                              ),
                            ]),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
