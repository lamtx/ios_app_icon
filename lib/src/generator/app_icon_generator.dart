import 'dart:io';

import 'package:image/image.dart';

import '../define.dart';
import '../model/ios_icon_template.dart';
import '../model/options.dart';
import 'utilities.dart';

void createIcons(Options options) {
  // decodeImageFile shows error message if null
  // so can return here if image is null
  var image = decodeImage(File(options.image).readAsBytesSync());
  if (image == null) {
    print('Unable to decode image.');
    return;
  }
  if (image.channels == Channels.rgba && options.backgroundColor == null) {
    print('Icons with alpha channel are not allowed in the Apple App Store.');
    print('Set "background_color: 0xffffff" to set the background.');
    return;
  }
  if (options.contentColor != null) {
    image = _applyContentColor(image, options.contentColor!);
  }
  if (options.backgroundColor != null) {
    image = _applyBackground(image, options.backgroundColor!);
  }
  print('Size of the image is ${image.width}x${image.height}.');
  print('Overwriting default iOS launcher icon with the new icon.');
  final destinationDir = Directory(iosDefaultIconFolder);
  if (destinationDir.existsSync()) {
    destinationDir.deleteSync(recursive: true);
  }
  destinationDir.createSync();
  for (final template in iosIcons) {
    _saveNewIcons(template, image);
  }
  modifyContentsFile('${iosDefaultIconFolder}Contents.json', iosImagesList);
  print('Create app icon successfully.');
}

void _saveNewIcons(IosIconTemplate template, Image image) {
  final resizedImage = _resize(image, template.size);
  File(iosDefaultIconFolder + iosDefaultIconName + template.name + '.png')
      .writeAsBytesSync(encodePng(resizedImage));
}

Image _resize(Image image, int size) {
  return image.width >= size
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

Image _applyBackground(Image image, int color) {
  print('Set the background color to 0x${color.toRadixString(16)}');
  return drawImage(
    fill(Image(image.width, image.height, channels: Channels.rgb), color),
    image,
  )..channels = Channels.rgb;
}

Image _applyContentColor(Image image, int color) {
  print('Set the content color to 0x${color.toRadixString(16)}');
  image.fillRgb(color);
  return image;
}
