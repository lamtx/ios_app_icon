import 'dart:convert';
import 'dart:io';

import 'package:image/image.dart';
import 'package:path/path.dart';

import '../model/contents_info.dart';
import '../model/icon_template.dart';
import 'app_icon/default_content_info.dart';

class CreateIconSetUseCase {
  const CreateIconSetUseCase();

  void generate(Image image, Directory target, List<IconTemplate> icons) {
    print('Size of the image is ${image.width}x${image.height}.');
    print('Overwriting default iOS launcher icon with the new icon.');

    if (target.existsSync()) {
      target.deleteSync(recursive: true);
    }
    target.createSync();
    final uniqueSize = <int>{};
    for (final icon in icons) {
      final size = icon.targetSize;
      if (uniqueSize.contains(size)) {
        continue;
      }
      uniqueSize.add(size);
      _createIcon(image, target, icon);
    }
    _createContentsFile(target, icons);
    print('Create app icon successfully.');
  }

  void copy(List<File> sources, Directory target, List<IconTemplate> icons) {
    print("Copy images to ${target.path}");
    if (target.existsSync()) {
      target.deleteSync(recursive: true);
    }
    target.createSync();
    for (var i = 0; i < sources.length; i++) {
      sources[i].copySync(join(target.path, icons[i].fileName));
    }
    _createContentsFile(target, icons);
  }

  void _createIcon(Image image, Directory target, IconTemplate icon) {
    final resizedImage = _resize(image, icon.targetSize);
    File(join(target.path, icon.fileName))
        .writeAsBytesSync(encodePng(resizedImage));
  }

  void _createContentsFile(
    Directory target,
    List<IconTemplate> icons, [
    String contentFileName = "Contents.json",
    ContentsInfo info = defaultContentInfo,
  ]) {
    final file = File(join(target.path, contentFileName))
      ..createSync(recursive: true);
    final contentJson = <String, dynamic>{
      'images': icons.map((e) => e.toJson()).toList(),
      'info': info.toJson(),
    };
    const encoder = JsonEncoder.withIndent('  ');
    final contentsFileContent = encoder.convert(contentJson);
    file.writeAsString(contentsFileContent);
  }

  Image _resize(Image image, int size) => image.width >= size
      ? copyResize(
          image,
          width: size,
          height: size,
          interpolation: Interpolation.average,
        )
      : copyResize(
          image,
          width: size,
          height: size,
          interpolation: Interpolation.linear,
        );
}
