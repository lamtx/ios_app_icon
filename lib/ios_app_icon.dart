import 'dart:io';

import 'package:ios_app_icon/src/generator/generate_strings.dart';
import 'package:ios_app_icon/src/generator/google_service_copier.dart';
import 'package:ios_app_icon/src/generator/launcher_icon_generator.dart';
import 'package:ios_app_icon/src/model/options.dart';
import 'package:yaml/yaml.dart';

import 'src/generator/app_icon_generator.dart';

void main(List<String> arguments) {
  if (arguments.length != 1) {
    print('Flavor must be specified');
    return;
  }
  final flavor = arguments.first;
  final config = _loadConfig();
  final iosAppConfig = config['ios_app_icon'];
  if (iosAppConfig is! Map) {
    print('ios_app_icon not found in pubspec.yaml');
    return;
  }
  final iconPath = iosAppConfig[flavor];
  if (iconPath == null) {
    print('image path does not found for flavor "$flavor"');
  }
  final options = Options.fromJson(iconPath);
  createIcons(options);
  createLauncherIcons(options);
  copyGoogleServiceInfo(options);
  generateStrings(flavor, options);
}

Map _loadConfig([String configFile = 'pubspec.yaml']) {
  final file = File(configFile);
  final yamlString = file.readAsStringSync();
  return loadYaml(yamlString);
}
