import 'dart:io';

import 'package:image/image.dart';

import '../../../define.dart';
import '../../../model/icon_template.dart';
import '../../../model/options.dart';
import '../../create_icon_set_use_case.dart';

class GenerateMacosAppIconsUseCase {
  const GenerateMacosAppIconsUseCase(this._editImageUseCase);

  final CreateIconSetUseCase _editImageUseCase;
  static const macosImagesList = [
    IconTemplate.mac(size: 16, scale: 1),
    IconTemplate.mac(size: 16, scale: 2),
    IconTemplate.mac(size: 32, scale: 1),
    IconTemplate.mac(size: 32, scale: 2),
    IconTemplate.mac(size: 128, scale: 1),
    IconTemplate.mac(size: 128, scale: 2),
    IconTemplate.mac(size: 256, scale: 1),
    IconTemplate.mac(size: 256, scale: 2),
    IconTemplate.mac(size: 512, scale: 1),
    IconTemplate.mac(size: 512, scale: 2),
  ];

  void createIcons(Options options) {
    // decodeImageFile shows error message if null
    // so can return here if image is null
    final imagePath =
        options.macosImage.isNotEmpty ? options.macosImage : options.image;
    var image = decodeImage(File(imagePath).readAsBytesSync());
    if (image == null) {
      print('Unable to decode image.');
      return;
    }

    if (options.macosImageTargetSize != null) {
      image = _wrapIcon(image, options.macosImageTargetSize!);
    }

    _editImageUseCase.generate(
      image,
      Directory(macosDefaultIconFolder),
      macosImagesList,
    );
  }

  Image _wrapIcon(Image image, int targetSize) {
    print(
        "Wrap image ${image.width}x${image.height} to ${targetSize}x$targetSize");
    return compositeImage(
      Image(
        width: targetSize,
        height: targetSize,
        numChannels: 4,
      ),
      image,
      dstX: ((targetSize - image.width) / 2).round(),
      dstY: ((targetSize - image.height) / 2).round(),
    );
  }
}
