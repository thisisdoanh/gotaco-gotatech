import 'result_model.dart';

class Humidity {
  Humidity({
    required this.results,
    required this.error,
  });

  final List<Result> results;
  final dynamic error;

  factory Humidity.fromJson(Map<String, dynamic> json) {
    return Humidity(
      results: json["results"] == null
          ? []
          : List<Result>.from(json["results"]!.map((x) => Result.fromJson(x))),
      error: json["error"],
    );
  }

  Map<String, dynamic> toJson() => {
        "results": results.map((x) => x.toJson()).toList(),
        "error": error,
      };
}
