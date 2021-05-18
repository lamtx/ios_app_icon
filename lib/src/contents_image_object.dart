class ContentsImageObject {
  const ContentsImageObject({
    this.size,
    required this.idiom,
    required this.filename,
    required this.scale,
  });

  final String? size;
  final String idiom;
  final String filename;
  final int scale;

  Map<String, String> toJson() {
    return <String, String>{
      if (size != null) 'size': size!,
      'idiom': idiom,
      'filename': filename,
      'scale': '${scale}x'
    };
  }
}
