class SPF_Image {
  final int? height;
  final int? width;
  final String url;

  SPF_Image({
    required this.url,
    this.height,
    this.width,
  });

  static SPF_Image fromMap(Map map) => SPF_Image(
    url: map['url'], 
    height: map['height'], 
    width: map['width']
  );

}
