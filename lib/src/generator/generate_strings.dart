import 'dart:io';

import '../define.dart';
import '../model/options.dart';

void generateStrings(String flavor, Options options) {
  final res = options.strings;
  if (res is Map) {
    _generateStringIOS(res);
  }
}

void _generateStringIOS(Map res) {
  print('Generate IOS Flavor.xconfig');
  final file = File('${iosFlutterFolder}Flavor.xcconfig');
  final source = StringBuffer();
  for (var value in res.entries) {
    if (value.value != null) {
      source.write('${value.key.toString().toUpperCase()}=${value.value}\n');
    }
  }
  file.writeAsString(source.toString(), flush: true);
}
