class Options {
  Options({
    required this.image,
    this.backgroundColor,
    this.launchImage,
    this.googleServiceInfo,
  });

  factory Options.fromJson(Object json) {
    if (json is Map) {
      return Options(
        image: json['image'],
        backgroundColor: json['background_color'],
        launchImage: json['launch_image'],
        googleServiceInfo: json['google_service_info'],
      );
    } else if (json is String) {
      return Options(image: json);
    } else {
      throw FormatException('Unknown $json');
    }
  }

  final String image;
  final int? backgroundColor;
  final String? launchImage;
  final String? googleServiceInfo;
}
