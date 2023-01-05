import 'package:net/net.dart';

class ContentsInfo implements JsonObject {
  const ContentsInfo({
    required this.version,
    required this.author,
  });

  final int version;
  final String author;

  @override
  Map<String, Object?> describeContent() => {
        'version': version,
        'author': author,
      };
}
