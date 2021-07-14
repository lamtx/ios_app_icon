import 'dart:io';

import 'package:ios_app_icon/src/generator/generate_strings.dart';
import 'package:ios_app_icon/src/generator/google_service_copier.dart';
import 'package:ios_app_icon/src/generator/launcher_icon_copier.dart';
import 'package:ios_app_icon/src/model/options.dart';
import 'package:yaml/yaml.dart';

import 'src/generator/app_icon_generator.dart';

void main(List<String> arguments) {
  if (arguments.length != 1) {
    print('Flavor must be specified');
    return;
  }
  final flavor = arguments.first;
  final iosAppConfig = _loadConfig();
  if (iosAppConfig == null) {
    print('flavor.yaml does not exists');
    return;
  }
  final iconPath = iosAppConfig[flavor];
  if (iconPath == null) {
    print('image path does not found for flavor "$flavor"');
  }
  final options = Options.fromJson(iconPath);
  createIcons(options);
  copyLauncherIcons(flavor, options);
  copyGoogleServiceInfo(options);
  generateStrings(flavor, options);
}

Map? _loadConfig([String configFile = 'flavor.yaml']) {
  final file = File(configFile);
  if (file.existsSync()) {
    final yamlString = file.readAsStringSync();
    return loadYaml(yamlString);
  } else {
    return null;
  }
}
