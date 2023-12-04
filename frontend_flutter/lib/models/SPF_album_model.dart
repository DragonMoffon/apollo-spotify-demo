import "package:frontend_flutter/models/SPF_ExternalID.dart";
import "package:frontend_flutter/models/SPF_artist_model.dart";
import "package:frontend_flutter/models/SPF_image.dart";
import "package:frontend_flutter/models/SPF_searchResults.dart";

class SPF_AlbumModel implements SPF_SearchResults {
  final String? album_type;
  final int? total_tracks;
  final String href;
  final String id;
  final List<SPF_Image>? images;
  final String name;
  final String? release;
  final String? type;
  final List<SPF_ArtistModel>? artists;
  final List<SPF_ExternalID>? external_ids;

  SPF_AlbumModel({
    required this.album_type,
    required this.total_tracks,
    required this.href,
    required this.id,
    this.images,
    required this.name,
    required this.release,
    this.type,
    this.artists,
    this.external_ids,
  });

  // getters for showing album search results
  @override
  String getTitle() => name;

  @override
  String getSubtitle() => artists?.map((artist) => artist.name).join(", ") ?? '';

  @override
  String getTrailing() => '$total_tracks tracks';

  @override // gets 3rd image url since its the smaller one
  String getImageURL() =>
      images?.isNotEmpty == true ? images![2].url ?? '' : '';

  static SPF_AlbumModel fromMap(Map map) {
    List? artists = map['artists'];
    List? externalIds = map['external_ids'];
    List? images = map['images'];

    SPF_AlbumModel album = SPF_AlbumModel(
      album_type: map['album_type'],
      total_tracks: map['total_tracks'],
      href: map['href'],
      id: map['id'],
      images: images?.map((image) => SPF_Image.fromMap(image)).toList(),
      name: map['name'],
      release: map['release'],
      type: map['type'],
      artists:
          artists?.map((artist) => SPF_ArtistModel.fromMap(artist)).toList(),
      external_ids: externalIds
          ?.map((externalId) => SPF_ExternalID.fromMap(externalId))
          .toList(),
    );

    return album;
  }
}
