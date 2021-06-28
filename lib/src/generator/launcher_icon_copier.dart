import 'dart:io';

import 'package:ios_app_icon/src/model/options.dart';
import 'package:path/path.dart' as p;

import '../define.dart';
import '../model/contents_image_object.dart';
import 'utilities.dart';

void copyLauncherIcons(String flavor, Options options) {
  final imagePath = options.launchImage;
  if (imagePath == null || imagePath.isEmpty) {
    return;
  }
  print('Create launch image successfully.');
  final filename = p.basenameWithoutExtension(imagePath);
  final ext = p.extension(imagePath);
  final basename = p.basename(imagePath);
  final dirname = p.dirname(imagePath);
  final destinationDir = Directory(iosDefaultLaunchImageFolder);
  final file1x = File(imagePath);
  final file2x = File('$dirname/2.0x/$basename');
  final file3x = File('$dirname/3.0x/$basename');
  final images = <ContentsImageObject>[];

  if (destinationDir.existsSync()) {
    destinationDir.deleteSync(recursive: true);
  }
  destinationDir.createSync();
  if (file1x.existsSync()) {
    final name = '$filename@1x$ext';
    file1x.copySync('$iosDefaultLaunchImageFolder$name');
    file1x.copy('${_prepareFolder(androidDrawableFolderOf(flavor, 1))}/$basename');
    images.add(ContentsImageObject(
      idiom: 'universal',
      filename: name,
      scale: 1,
    ));
  } else {
    print('The launch image file not found');
    return;
  }

  if (file2x.existsSync()) {
    final name = '$filename@2x$ext';
    file2x.copySync('$iosDefaultLaunchImageFolder$name');
    file2x.copy('${_prepareFolder(androidDrawableFolderOf(flavor, 2))}/$basename');
    images.add(ContentsImageObject(
      idiom: 'universal',
      filename: name,
      scale: 2,
    ));
  } else {
    print('Warn: there are no 2.0x format for $imagePath');
  }

  if (file3x.existsSync()) {
    final name = '$filename@3x$ext';
    file3x.copySync('$iosDefaultLaunchImageFolder$name');
    file3x.copy('${_prepareFolder(androidDrawableFolderOf(flavor, 3))}/$basename');
    images.add(ContentsImageObject(
      idiom: 'universal',
      filename: name,
      scale: 3,
    ));
  } else {
    print('Warn: there are no 3.0x format for $imagePath');
  }

  modifyContentsFile('${iosDefaultLaunchImageFolder}Contents.json', images);
}

String _prepareFolder(String path) {
  final dir = Directory(path);
  if (!dir.existsSync()) {
    dir.createSync(recursive: true);
  }
  return path;
}