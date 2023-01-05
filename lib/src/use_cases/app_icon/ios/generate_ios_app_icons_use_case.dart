import 'dart:io';

import 'package:image/image.dart';

import '../../../define.dart';
import '../../../generator/utilities.dart';
import '../../../model/icon_template.dart';
import '../../../model/options.dart';
import '../../create_icon_set_use_case.dart';

class GenerateIosAppIconsUseCase {
  const GenerateIosAppIconsUseCase(this._editImageUseCase);

  final CreateIconSetUseCase _editImageUseCase;
  static const _iosImagesList = [
    IconTemplate.iphone(size: 20, scale: 2),
    IconTemplate.iphone(size: 20, scale: 3),
    IconTemplate.iphone(size: 29, scale: 1),
    IconTemplate.iphone(size: 29, scale: 2),
    IconTemplate.iphone(size: 29, scale: 3),
    IconTemplate.iphone(size: 40, scale: 2),
    IconTemplate.iphone(size: 40, scale: 3),
    IconTemplate.iphone(size: 60, scale: 2),
    IconTemplate.iphone(size: 60, scale: 3),
    IconTemplate.ipad(size: 20, scale: 1),
    IconTemplate.ipad(size: 20, scale: 2),
    IconTemplate.ipad(size: 29, scale: 1),
    IconTemplate.ipad(size: 29, scale: 2),
    IconTemplate.ipad(size: 40, scale: 1),
    IconTemplate.ipad(size: 40, scale: 2),
    IconTemplate.ipad(size: 76, scale: 1),
    IconTemplate.ipad(size: 76, scale: 2),
    IconTemplate.ipad(size: 83.5, scale: 2),
    IconTemplate(size: 1024, scale: 1, idiom: "ios-marketing"),
  ];

  void createIcons(Options options) {
    // decodeImageFile shows error message if null
    // so can return here if image is null
    var image = decodeImage(File(options.image).readAsBytesSync());
    if (image == null) {
      print('Unable to decode image.');
      return;
    }
    if (image.numChannels > 3 && options.backgroundColor == null) {
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
    _editImageUseCase.generate(
      image,
      Directory(iosDefaultIconFolder),
      _iosImagesList,
    );
  }

  Image _applyBackground(Image image, Color color) {
    print('Set the background color to ${color.hex()}');
    return compositeImage(
      fill(
        Image(width: image.width, height: image.height),
        color: color,
      ),
      image,
    );
  }

  Image _applyContentColor(Image image, Color color) {
    print('Set the content color to $color [unimplemented]');
    fill(image, color: color);
    return image;
  }
}
