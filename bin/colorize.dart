import 'dart:io';

import 'package:image/image.dart';
import 'package:ios_app_icon/src/generator/utilities.dart';

void main(List<String> arguments) {
  final file = File(arguments[0]);
  var image = decodeImage(file.readAsBytesSync())!;
  image.fillRgb(0xff6c399e);
  file.writeAsBytesSync(encodePng(image));
}
