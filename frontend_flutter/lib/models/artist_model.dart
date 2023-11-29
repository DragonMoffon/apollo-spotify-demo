import "package:frontend_flutter/models/album_model.dart";

class ArtistModel {
  final String name;
  final AlbumModel? discography;
  final int? no_followers;

  ArtistModel({
    required this.name,
    this.discography,
    this.no_followers,
  });

}
