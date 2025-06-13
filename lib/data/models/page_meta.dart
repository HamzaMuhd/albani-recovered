class PageMeta {
  final int page;
  final int surah;
  final int ayah;
  final int juz;

  PageMeta({
    required this.page,
    required this.surah,
    required this.ayah,
    required this.juz,
  });

  factory PageMeta.fromJson(Map<String, dynamic> json) {
    return PageMeta(
      page: json['page'],
      surah: json['surah'],
      ayah: json['ayah'],
      juz: json['juz'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'surah': surah,
      'ayah': ayah,
      'juz': juz,
    };
  }
}
