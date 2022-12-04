class SeasonModel {
  SeasonModel({
    required this.year,
    required this.wikiURL,
    required this.driverIds,
  });

  String year;
  String wikiURL;
  List<String> driverIds;

  static SeasonModel fromJson(Map<String, dynamic> json) => SeasonModel(
    year: json[r'season'],
    wikiURL: json[r'url'],
    driverIds: json[r'driverIds'] ?? []
  );

  static List<SeasonModel> listFromJson(List<dynamic> json) =>
      json.map((e) => SeasonModel.fromJson(e)).toList(growable: true);

  String get getShortYear => "'${year.toString().substring(2, 4)}";

}

