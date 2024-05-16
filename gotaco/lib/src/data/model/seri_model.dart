class Series {
  Series({
    required this.name,
    required this.tags,
    required this.columns,
    required this.values,
  });

  final String? name;
  final dynamic tags;
  final List<String> columns;
  final List<List<dynamic>> values;

  factory Series.fromJson(Map<String, dynamic> json) {
    return Series(
      name: json["name"],
      tags: json["tags"],
      columns: json["columns"] == null
          ? []
          : List<String>.from(json["columns"]!.map((x) => x)),
      values: json["values"] == null
          ? []
          : List<List<dynamic>>.from(json["values"]!.map(
              (x) => x == null ? [] : List<dynamic>.from(x!.map((x) => x)))),
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "tags": tags,
        "columns": columns.map((x) => x).toList(),
        "values": values.map((x) => x.map((x) => x).toList()).toList(),
      };
}
