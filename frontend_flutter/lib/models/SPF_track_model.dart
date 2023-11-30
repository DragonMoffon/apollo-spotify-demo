class SPF_TrackModel {
  final int disc; // disc number
  final int duration;
  final bool? explicit;
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
    required this.disc,
    required this.duration,
    this.explicit,
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

  static SPF_TrackModel fromMap(Map map) => SPF_TrackModel(
        disc: map['disc'],
        duration: map['duration'],
        explicit: map['explicit'],
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
}
