import 'dart:convert';
import 'dart:io';

import 'package:image/image.dart';
import 'package:ios_app_icon/src/model/contents_image_object.dart';
import 'package:ios_app_icon/src/model/contents_info_object.dart';

/// Create the Contents.json file
void modifyContentsFile(String path, List<ContentsImageObject> images) {
  final file = File(path)..createSync(recursive: true);
  final contentJson = <String, dynamic>{
    'images': images.map((e) => e.toJson()).toList(),
    'info': ContentsInfoObject(version: 1, author: 'xcode').toJson()
  };
  final encoder = JsonEncoder.withIndent('  ');
  final contentsFileContent = encoder.convert(contentJson);
  file.writeAsString(contentsFileContent);
}

extension ImageExt on Image {
  void fillRgb(int color) {
    final red = getRed(color);
    final green = getGreen(color);
    final blue = getBlue(color);
    for (var i = 0; i < data.length; i++) {
      data[i] = Color.fromRgba(red, green, blue, getAlpha(data[i]));
    }
  }
}

void check(bool value) {
  if (!value) {
    throw AssertionError('Value not true');
  }
}

// Color in flutter is 0xAARRGGBB but this library is AABBGGRR
int getFlutterRed(int color) => getBlue(color);

int getFlutterGreen(int color) => getGreen(color);

int getFlutterBlue(int color) => getRed(color);
