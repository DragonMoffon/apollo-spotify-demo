import "package:frontend_flutter/models/SPF_ExternalUrl.dart";
import "package:frontend_flutter/models/SPF_image.dart";

class SPF_ArtistModel {
  final List<SPF_ExternalURL>? external_urls;
  final int? followers;
  final List<String>? genres;
  final String href;
  final String id;
  final List<SPF_Image>? images;
  final String name;
  final int? popularity;
  final String? type;
  final String uri;

  SPF_ArtistModel({
    this.external_urls,
    this.followers,
    this.genres,
    required this.href,
    required this.id,
    this.images,
    required this.name,
    this.popularity,
    this.type,
    required this.uri,
  });

  static SPF_ArtistModel fromMap(Map map) {
    List? externalURLs = map['external_urls'];
    List? images = map['images'];

    SPF_ArtistModel result = SPF_ArtistModel(
        external_urls: externalURLs
            ?.map((externalUrl) => SPF_ExternalURL.fromMap(externalUrl))
            .toList(),
        followers: map['followers'],
        genres: map['genres'],
        href: map['href'],
        id: map['id'],
        images: images?.map((image) => SPF_Image.fromMap(image)).toList(),
        name: map['name'],
        popularity: map['popularity'],
        type: map['type'],
        uri: map['uri']);
    return result;
  }
}
