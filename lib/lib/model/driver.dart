class Driver {
  Driver({
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

  static Driver fromJson(Map<String, dynamic> json) => Driver(
    id: json[r'driverId'],
    permanentNumber: json[r'permanentNumber'] ?? "",
    code: json[r'code'] ?? "",
    wikiURL: json[r'url'],
    firstName: json[r'givenName'],
    lastName: json[r'familyName'],
    dateOfBirth: json[r'dateOfBirth'],
    nationality: json[r'nationality']
  );

  static List<Driver> listFromJson(List<dynamic> json) =>
      json.map((e) => Driver.fromJson(e)).toList(growable: true);

  String get fullName => "$lastName $firstName";

  String get yearOfBirth => dateOfBirth.substring(0, 4);
}

