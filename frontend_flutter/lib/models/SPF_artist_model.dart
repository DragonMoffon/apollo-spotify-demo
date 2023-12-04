import "package:frontend_flutter/models/SPF_ExternalUrl.dart";
import "package:frontend_flutter/models/SPF_image.dart";
import "package:frontend_flutter/models/SPF_searchResults.dart";

class SPF_ArtistModel implements SPF_SearchResults {
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

  // getters for showing artist search results
  @override
  String getTitle() => name;

  @override
  String getSubtitle() => '';

  @override
  String getTrailing()=>'${formatFollowersNumber()} followers';

 @override // gets 3rd image url since its the smaller one
  String getImageURL() => images?.isNotEmpty == true ? images![2].url ?? '' : '';

  // Formats the followers number into millions, thousands, hundreds/tens
  String formatFollowersNumber(){
    if (followers! >= 1000000) {
      double result = followers! / 1000000.0;
      return "${result.toStringAsFixed(1)} million";
    } else if (followers! >= 1000) {
      double result = followers! / 1000.0;
      return "${result.toStringAsFixed(1)} thousand";
    } else {
      return followers.toString();
    }
  }

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
