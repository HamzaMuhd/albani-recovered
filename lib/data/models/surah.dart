class Surah {
  final int number;
  final String arabic;
  final String english;
  final String type;
  final int? startPage;

  Surah({
    required this.number,
    required this.arabic,
    required this.english,
    required this.type,
    required this.startPage,
  });

  factory Surah.fromJson(Map<String, dynamic> json) {
    return Surah(
      number: json['number'],
      arabic: json['arabic'],
      english: json['english'],
      type: json['type'],
      startPage: json['start_page'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'arabic': arabic,
      'english': english,
      'type': type,
      'start_page': startPage,
    };
  }
}
