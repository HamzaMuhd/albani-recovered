class Audio {
  final int id;
  final String title;
  final String url;
  final String description;
  final String duration;

  Audio({
    required this.id,
    required this.title,
    required this.url,
    required this.description,
    required this.duration,
  });

  factory Audio.fromJson(Map<String, dynamic> json) => Audio(
        id: json['id'],
        title: json['title'],
        url: json['url'],
        description: json['description'],
        duration: json['duration'],
      );
}

class Subcategory {
  final int id;
  final String name;
  final String author;
  final String imageUrl;
  final List<Audio> audios;

  Subcategory({
    required this.id,
    required this.name,
    required this.author,
    required this.imageUrl,
    required this.audios,
  });

  factory Subcategory.fromJson(Map<String, dynamic> json) => Subcategory(
        id: json['id'],
        name: json['name'],
        author: json['author'],
        imageUrl: json['image_url'],
        audios: (json['audios'] as List).map((a) => Audio.fromJson(a)).toList(),
      );
}
