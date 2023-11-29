class SongModel {
  final String title;
  final List<String> artist;
  final int length;

  SongModel({
    required this.title,
    required this.artist,
    required this.length,
  });

  static SongModel fromMap(Map map) =>
    SongModel(
      title: map['title'],
      artist: (map['artists'] as List<dynamic>).cast<String>(),
      length: map['length'],
    );
}
