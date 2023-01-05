import 'dart:io';

import '../define.dart';
import '../model/options.dart';

void generateStrings(String flavor, Options options) {
  if (options.strings.isNotEmpty) {
    _generateStringIOS(options.strings);
  }
}

void _generateStringIOS(Map<String, Object?> res) {
  print('Generate IOS Flavor.xconfig');
  final file = File('${iosFlutterFolder}Flavor.xcconfig');
  final source = StringBuffer();
  for (final value in res.entries) {
    if (value.value != null) {
      source.write('${value.key.toUpperCase()}=${value.value}\n');
    }
  }
  file.writeAsString(source.toString(), flush: true);
}
