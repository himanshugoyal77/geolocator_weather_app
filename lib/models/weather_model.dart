import 'dart:convert';

WeatherModel weatherModelFromJson(String str) =>
    WeatherModel.fromJson(json.decode(str));

class WeatherModel {
  WeatherModel({
    required this.coord,
    required this.weather,
    required this.base,
    required this.main,
    required this.visibility,
    required this.wind,
    required this.clouds,
    required this.dt,
    required this.sys,
    required this.timezone,
    required this.id,
    required this.name,
    required this.cod,
  });

  Coord coord;
  List<dynamic> weather;
  String base;
  Main main;
  int visibility;
  Wind wind;
  Clouds clouds;
  int dt;
  Sys sys;
  int timezone;
  int id;
  String name;
  int cod;

  factory WeatherModel.fromJson(Map<String, dynamic> json) => WeatherModel(
        coord: Coord.fromJson(json["coord"]),
        weather: List<dynamic>.from(json["weather"].map((x) => x)),
        base: json["base"],
        main: Main.fromJson(json["main"]),
        visibility: json["visibility"],
        wind: Wind.fromJson(json["wind"]),
        clouds: Clouds.fromJson(json["clouds"]),
        dt: json["dt"],
        sys: Sys.fromJson(json["sys"]),
        timezone: json["timezone"],
        id: json["id"],
        name: json["name"],
        cod: json["cod"],
      );
}

class Clouds {
  Clouds({
    required this.all,
  });

  int all;

  factory Clouds.fromJson(Map<String, dynamic> json) => Clouds(
        all: json["all"],
      );
}

class Coord {
  Coord();

  factory Coord.fromJson(Map<String, dynamic> json) => Coord();
}

class Main {
  Main({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
  });

  double temp;
  double feelsLike;
  double tempMin;
  double tempMax;
  int pressure;
  int humidity;

  factory Main.fromJson(Map<String, dynamic> json) => Main(
        temp: json["temp"].toDouble(),
        feelsLike: json["feels_like"].toDouble(),
        tempMin: json["temp_min"].toDouble(),
        tempMax: json["temp_max"],
        pressure: json["pressure"],
        humidity: json["humidity"],
      );
}

class Sys {
  Sys({
    required this.type,
    required this.id,
    required this.country,
    required this.sunrise,
    required this.sunset,
  });

  num type;
  num id;
  String country;
  num sunrise;
  num sunset;

  factory Sys.fromJson(Map<String, dynamic> json) => Sys(
        type: json["type"],
        id: json["id"],
        country: json["country"],
        sunrise: json["sunrise"],
        sunset: json["sunset"],
      );
}

class Wind {
  Wind({
    required this.speed,
    required this.deg,
  });

  num speed;
  num deg;

  factory Wind.fromJson(Map<String, dynamic> json) => Wind(
        speed: json["speed"].toDouble(),
        deg: json["deg"],
      );
}
