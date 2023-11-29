import "package:frontend_flutter/models/song_model.dart";

class AlbumModel {
  final String title;
  final List<String> artists;
  final List<SongModel> songs;

  AlbumModel({
    required this.title,
    required this.artists,
    required this.songs,
  });

  static AlbumModel fromMap(Map map) =>
      AlbumModel(
        title: map['title'], 
        artists: (map['artists'] as List<dynamic>).cast<String>(), 
        songs: (map['songs'] as List<dynamic>).map((song) => SongModel.fromMap(song)).toList(),
      );
}
