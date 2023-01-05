import 'dart:io';

import 'package:path/path.dart' as p;

import '../define.dart';
import '../model/icon_template.dart';
import '../model/options.dart';
import 'create_icon_set_use_case.dart';

class GenerateLauncherIconsUseCase {
  const GenerateLauncherIconsUseCase(this._editImageUseCase);

  final CreateIconSetUseCase _editImageUseCase;

  static const _iosLauncherIconsList = [
    IconTemplate(size: 0, scale: 1, idiom: "universal"),
    IconTemplate(size: 0, scale: 2, idiom: "universal"),
    IconTemplate(size: 0, scale: 3, idiom: "universal"),
  ];

  void copyLauncherIcons(String flavor, Options options) {
    final imagePath = options.launchImage;
    if (imagePath.isEmpty) {
      return;
    }
    final basename = p.basename(imagePath);
    final dirname = p.dirname(imagePath);
    final files = [
      File(imagePath),
      File('$dirname/2.0x/$basename'),
      File('$dirname/3.0x/$basename'),
    ];
    for (final file in files) {
      if (!file.existsSync()) {
        print('File `${file.path}` does not exists.');
        return;
      }
    }

    print('Create launch icon for iOS');
    _editImageUseCase.copy(
      files,
      Directory(iosDefaultLaunchImageFolder),
      _iosLauncherIconsList,
    );
    print('Create launch icon for Android');
    for (var i = 1; i < files.length; i++) {
      files[i].copySync(
        '${_prepareFolder(androidDrawableFolderOf(flavor, i + 1))}/$basename',
      );
    }
  }

  String _prepareFolder(String path) {
    final dir = Directory(path);
    if (!dir.existsSync()) {
      dir.createSync(recursive: true);
    }
    return path;
  }
}
