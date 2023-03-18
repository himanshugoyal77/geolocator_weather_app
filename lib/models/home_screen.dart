import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map data = {};
  double lat = 0;
  double lon = 0;

  void getData(double lat, double lon) async {
    final response = await http.get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=57fa9e4b78664067f293d97602aa3d74"));

    if (response.statusCode == 200) {
      setState(() {
        data = jsonDecode(response.body);
      });
      print(data);
    }
  }

  void getCurrentPosition() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      LocationPermission asked = await Geolocator.requestPermission();
    } else {
      Position currenPostion = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      print("${currenPostion.latitude} ${currenPostion.longitude}");
      setState(() {
        lat = currenPostion.latitude;
        lon = currenPostion.longitude;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentPosition();

    Future.delayed(const Duration(seconds: 2), () {
      getData(lat, lon);
    });
  }

  @override
  Widget build(BuildContext context) {
    final temp = data.isNotEmpty ? data["main"]["temp"] - 273 : 0;
    final String day = DateFormat('EEEE').format(DateTime.now());
    String formatDate(DateTime date) => DateFormat("MMMM d").format(date);
    final String date = formatDate(DateTime.now());
    return Scaffold(
      backgroundColor: const Color(0xff3A4F7A).withOpacity(0.8),
      body: Padding(
        padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
        child: data["name"] != null && temp != null
            ? Column(
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
                        "${data["name"]}, ${data["sys"]["country"]}",
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          temp.toStringAsFixed(0),
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
                          "°C",
                          style: TextStyle(
                              color: Colors.amber,
                              fontSize: 70,
                              letterSpacing: 2,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "${day}, ${date}",
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
                    "Maximum Temperature : ${data["main"]["temp_max"]}",
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
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
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
                                  data["weather"][0]["main"],
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  data["weather"][0]["description"],
                                  style: const TextStyle(
                                    color: Colors.amber,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ]),
                        ),
                        Container(
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
                                Text(
                                  "pressure",
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  data["main"]["pressure"].toString(),
                                  style: const TextStyle(
                                    color: Colors.amber,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ]),
                        ),
                      ]),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
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
                                Text(
                                  "Humidity",
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  data["main"]["humidity"].toString(),
                                  style: const TextStyle(
                                    color: Colors.amber,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ]),
                        ),
                        Container(
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
                                Text(
                                  "Wind Speed",
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  data["wind"]["speed"].toString(),
                                  style: const TextStyle(
                                    color: Colors.amber,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ]),
                        ),
                      ]),
                ],
              )
            : Center(
                child: CircularProgressIndicator(
                  color: Colors.amber,
                ),
              ),
      ),
    );
  }
}
