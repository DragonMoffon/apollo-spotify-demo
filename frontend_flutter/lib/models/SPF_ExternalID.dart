class SPF_ExternalID {
  final String id;
  final String name;

  SPF_ExternalID({
    required this.id,
    required this.name,
  });

  static SPF_ExternalID fromMap(Map map) =>
    SPF_ExternalID(
      name: map['name'], 
      id: map['id']
  );
}
