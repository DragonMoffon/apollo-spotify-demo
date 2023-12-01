class SPF_ExternalURL {
  final String name;
  final String url;

  SPF_ExternalURL({
    required this.name,
    required this.url,
  });

  static SPF_ExternalURL fromMap(Map map) =>
    SPF_ExternalURL(
      name: map['name'], 
      url: map['url']
  );
}
