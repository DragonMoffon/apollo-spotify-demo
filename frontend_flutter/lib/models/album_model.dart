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
}
