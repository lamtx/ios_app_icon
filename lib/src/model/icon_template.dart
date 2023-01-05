class IconTemplate {
  const IconTemplate({
    required this.size,
    required this.scale,
    required this.idiom,
  });

  const IconTemplate.iphone({
    required this.size,
    required this.scale,
  }) : idiom = "iphone";

  const IconTemplate.mac({
    required this.size,
    required this.scale,
  }) : idiom = "mac";

  const IconTemplate.ipad({
    required this.size,
    required this.scale,
  }) : idiom = "ipad";

  final double size;
  final double scale;
  final String idiom;

  String get fileName =>
      targetSize == 0 ? "app_icon@${scale}x.png" : "app_icon_$targetSize.png";

  int get targetSize => (size * scale).round();

  Map<String, String> toJson() => {
        if (size != 0) "size": "${_f(size)}x${_f(size)}",
        "idiom": idiom,
        "scale": "${_f(scale)}x",
        "filename": fileName,
      };
}

// remove trailing zero
String _f(double value) => (value.truncateToDouble() == value)
    ? value.truncate().toString()
    : value.toString();
