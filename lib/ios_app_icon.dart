import 'dart:convert';
import 'dart:io';

import 'package:image/image.dart';
import 'package:ios_app_icon/src/contents_image_object.dart';
import 'package:ios_app_icon/src/options.dart';
import 'package:path/path.dart' as p;
import 'package:yaml/yaml.dart';

import 'src/contents_info_object.dart';
import 'src/define.dart';
import 'src/ios_icon_template.dart';

void main(List<String> arguments) {
  if (arguments.length != 1) {
    print('Flavor must be specified');
    return;
  }
  final flavor = arguments.first;
  final config = loadConfig();
  final iosAppConfig = config['ios_app_icon'];
  if (iosAppConfig is! Map) {
    print('ios_app_icon not found in pubspec.yaml');
    return;
  }
  final iconPath = iosAppConfig[flavor];
  if (iconPath == null) {
    print('image path does not found for flavor "$flavor"');
  }
  createIcons(Options.fromJson(iconPath));
}

Map loadConfig([String configFile = 'pubspec.yaml']) {
  final file = File(configFile);
  final yamlString = file.readAsStringSync();
  return loadYaml(yamlString);
}

Image applyBackground(Image image, int color) {
  print('Set the background color to 0x${color.toRadixString(16)}');
  return drawImage(
    fill(Image(image.width, image.height, channels: Channels.rgb), color),
    image,
  )..channels = Channels.rgb;
}

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
  if (options.backgroundColor != null) {
    image = applyBackground(image, options.backgroundColor!);
  }
  print('Size of the image is ${image.width}x${image.height}.');
  print('Overwriting default iOS launcher icon with the new icon.');
  for (final template in iosIcons) {
    saveNewIcons(template, image);
  }
  modifyContentsFile('${iosDefaultIconFolder}Contents.json', iosImagesList);
  print('Create app icon successfully.');
  if (options.launchImage != null) {
    createLauncherIcons(options.launchImage!);
    print('Create launch image successfully.');
  }
  if (options.googleServiceInfo != null) {
    final basename = p.basename(options.googleServiceInfo!);
    if (basename != 'GoogleService-Info.plist') {
      print('google_service_info is not GoogleService-Info.plist');
      return;
    }
    final file = File(options.googleServiceInfo!);
    if (!file.existsSync()) {
      print(
          'GoogleService-Info.plist not found in path "${options.googleServiceInfo}"');
      return;
    }
    file.copySync('$iosRunnerFolder$basename');
    print('Copy GoogleService-Info.plist successfully');
  }
}

void createLauncherIcons(String imagePath) {
  final filename = p.basenameWithoutExtension(imagePath);
  final ext = p.extension(imagePath);
  final basename = p.basename(imagePath);
  final dirname = p.dirname(imagePath);
  final file1x = File(imagePath);
  final file2x = File('$dirname/2.0x/$basename');
  final file3x = File('$dirname/3.0x/$basename');
  final images = <ContentsImageObject>[];

  if (file1x.existsSync()) {
    final name = '$filename@1x$ext';
    file1x.copySync('$iosDefaultLaunchImageFolder$name');
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

void saveNewIcons(IosIconTemplate template, Image image) {
  final resizedImage = resize(image, template.size);
  File(iosDefaultIconFolder + iosDefaultIconName + template.name + '.png')
      .writeAsBytesSync(encodePng(resizedImage));
}

Image resize(Image image, int size) {
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
