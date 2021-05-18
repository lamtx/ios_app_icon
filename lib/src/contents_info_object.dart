class ContentsInfoObject {
  const ContentsInfoObject({
    required this.version,
    required this.author,
  });

  final int version;
  final String author;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'version': version,
      'author': author,
    };
  }
}
