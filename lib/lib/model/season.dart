class Season {
  Season({
    required this.year,
    required this.wikiURL,
    required this.driverIds,
  });

  String year;
  String wikiURL;
  List<String> driverIds;

  static Season fromJson(Map<String, dynamic> json) => Season(
    year: json[r'season'],
    wikiURL: json[r'url'],
    driverIds: json[r'driverIds'] ?? []
  );

  static List<Season> listFromJson(List<dynamic> json) =>
      json.map((e) => Season.fromJson(e)).toList(growable: true);

  String get shortYear => "'${year.toString().substring(2, 4)}";
}
