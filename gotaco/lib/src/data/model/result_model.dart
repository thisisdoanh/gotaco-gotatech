import 'seri_model.dart';

class Result {
  Result({
    required this.series,
    required this.error,
  });

  final List<Series> series;
  final dynamic error;

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      series: json["series"] == null
          ? []
          : List<Series>.from(json["series"]!.map((x) => Series.fromJson(x))),
      error: json["error"],
    );
  }

  Map<String, dynamic> toJson() => {
        "series": series.map((x) => x.toJson()).toList(),
        "error": error,
      };
}
