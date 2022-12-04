class DriverModel {
  /// Returns a new [DriverModel] instance.
  DriverModel({
    required this.id,
    this.permanentNumber = "",
    this.code = "",
    required this.wikiURL,
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
    required this.nationality,
  });

  String id;
  String permanentNumber;
  String code;
  String wikiURL;
  String firstName;
  String lastName;
  String dateOfBirth;
  String nationality;

  /// Returns a new [DriverModel] instance and imports its values from
  static DriverModel fromJson(Map<String, dynamic> json) => DriverModel(
    id: json[r'driverId'],
    permanentNumber: json[r'permanentNumber'] ?? "",
    code: json[r'code'] ?? "",
    wikiURL: json[r'url'],
    firstName: json[r'givenName'],
    lastName: json[r'familyName'],
    dateOfBirth: json[r'dateOfBirth'],
    nationality: json[r'nationality']
  );

  static List<DriverModel> listFromJson(List<dynamic> json) =>
      json.map((e) => DriverModel.fromJson(e)).toList(growable: true);

  String get getFullName => "$lastName $firstName";

  String get getYearOfBirth => dateOfBirth.substring(0, 4);

  String get getSearchableParams => "$getFullName $getYearOfBirth $nationality ";
}

