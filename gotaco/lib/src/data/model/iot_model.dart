import 'humidity_model.dart';

class IotModel {
  IotModel({
    required this.humidity,
    required this.temperature,
    required this.rsR0,
  });

  final Humidity? humidity;
  final Humidity? temperature;
  final Humidity? rsR0;

  factory IotModel.fromJson(Map<String, dynamic> json) {
    return IotModel(
      humidity:
          json["HUMIDITY"] == null ? null : Humidity.fromJson(json["HUMIDITY"]),
      temperature: json["TEMPERATURE"] == null
          ? null
          : Humidity.fromJson(json["TEMPERATURE"]),
      rsR0: json["RS_R0"] == null ? null : Humidity.fromJson(json["RS_R0"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "HUMIDITY": humidity?.toJson(),
        "TEMPERATURE": temperature?.toJson(),
        "RS_R0": rsR0?.toJson(),
      };
}
