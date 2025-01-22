import 'package:ext/ext.dart';

class ContentsInfo implements ToJson {
  const ContentsInfo({
    required this.version,
    required this.author,
  });

  final int version;
  final String author;

  @override
  Map<String, Object?> toJson() => {
        'version': version,
        'author': author,
      };
}
