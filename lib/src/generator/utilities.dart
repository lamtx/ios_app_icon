import 'dart:convert';
import 'dart:io';

import 'package:ios_app_icon/src/model/contents_image_object.dart';
import 'package:ios_app_icon/src/model/contents_info_object.dart';

/// Create the Contents.json file
void modifyContentsFile(String path, List<ContentsImageObject> images) {
  final file = File(path)..createSync(recursive: true);
  final contentJson = <String, dynamic>{
    'images': images.map((e) => e.toJson()).toList(),
    'info': ContentsInfoObject(version: 1, author: 'xcode').toJson()
  };
  final encoder =  JsonEncoder.withIndent('  ');
  final contentsFileContent = encoder.convert(contentJson);
  file.writeAsString(contentsFileContent);
}
