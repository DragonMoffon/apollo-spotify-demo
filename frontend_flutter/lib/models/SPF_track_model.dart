import "package:frontend_flutter/models/SPF_ExternalID.dart";
import "package:frontend_flutter/models/SPF_ExternalUrl.dart";
import "package:frontend_flutter/models/SPF_artist_model.dart";
import "package:frontend_flutter/models/SPF_searchResults.dart";

class SPF_TrackModel implements SPF_SearchResults {
  final List<SPF_ArtistModel>? artists;
  final int disc; // disc number
  final int rawDuration; // in ms
  final String? formattedDuration;
  final bool? explicit;
  final List<SPF_ExternalID>? external_ids;
  final List<SPF_ExternalURL>? external_urls;
  final String href;
  final String id;
  final bool? is_playable;
  final String name;
  final int? popularity;
  final String? preview;
  final int number; // position in album
  final String type; // enum for json type
  final String uri;
  final bool is_local;

  SPF_TrackModel({
    this.artists,
    required this.disc,
    required this.rawDuration,
    this.formattedDuration,
    this.explicit,
    this.external_ids,
    this.external_urls,
    required this.href,
    required this.id,
    this.is_playable,
    required this.name,
    this.popularity,
    this.preview,
    required this.number,
    required this.type,
    required this.uri,
    required this.is_local,
  });

// getters for showing track search results
  @override
  String getTitle() => name;

  @override
  String getSubtitle() => artists?.map((artist) => artist.name).join(",") ?? '';

  @override
  String getTrailing() => formattedDuration ?? '';

  @override
  String getImageURL() => '';


// Formats the song duration from milliseconds to mins:seconds
  static String formatSongDuration(int milliseconds) {
    Duration duration = Duration(milliseconds: milliseconds);
    int minutes = duration.inMinutes;
    int seconds = (duration.inSeconds % 60);

    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = seconds.toString().padLeft(2, '0');
    return '$minutesStr:$secondsStr';
  }

  static SPF_TrackModel fromMap(Map map) {
    List? artists = map['artists'];
    List? externalIDs = map['external_ids'];
    List? externalUrls = map['external_urls'];

    SPF_TrackModel result = SPF_TrackModel(
      artists:
          artists?.map((artist) => SPF_ArtistModel.fromMap(artist)).toList(),
      disc: map['disc'],
      rawDuration: map['duration'],
      formattedDuration: SPF_TrackModel.formatSongDuration(map['duration']),
      explicit: map['explicit'],
      external_ids: externalIDs
          ?.map((externalID) => SPF_ExternalID.fromMap(externalID))
          .toList(),
      external_urls: externalUrls
          ?.map((externalUrl) => SPF_ExternalURL.fromMap(externalUrl))
          .toList(),
      href: map['href'],
      id: map['id'],
      is_playable: map['is_playable'],
      name: map['name'],
      popularity: map['popularity'],
      preview: map['preview'],
      number: map['number'],
      type: map['type'],
      uri: map['uri'],
      is_local: map['is_local'],
    );
    return result;
  }
}
