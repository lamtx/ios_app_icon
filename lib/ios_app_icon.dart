import 'dart:io';

import 'package:yaml/yaml.dart';

import 'src/generator/generate_strings.dart';
import 'src/generator/google_service_copier.dart';
import 'src/model/options.dart';
import 'src/use_cases/app_icon/ios/generate_ios_app_icons_use_case.dart';
import 'src/use_cases/app_icon/macos/generate_macos_app_icons_use_case.dart';
import 'src/use_cases/create_icon_set_use_case.dart';
import 'src/use_cases/generate_launcher_icons_use_case.dart';

void main(List<String> arguments) {
  if (arguments.length != 1) {
    print('Flavor must be specified');
    return;
  }
  final flavor = arguments.first;
  final flavors = _loadConfig();
  if (flavors == null) {
    print('flavor.yaml does not exists');
    return;
  }
  final options = flavors[flavor];
  if (options == null) {
    print('flavor.yaml does not contain `$flavor`');
    return;
  }
  const createIconSetUseCase = CreateIconSetUseCase();
  const GenerateIosAppIconsUseCase(createIconSetUseCase).createIcons(options);
  const GenerateMacosAppIconsUseCase(createIconSetUseCase).createIcons(options);
  const GenerateLauncherIconsUseCase(createIconSetUseCase)
      .copyLauncherIcons(flavor, options);

  copyGoogleServiceInfo(options);
  generateStrings(flavor, options);
}

Map<String, Options>? _loadConfig([String configFile = 'flavor.yaml']) {
  final file = File(configFile);
  if (file.existsSync()) {
    final yamlString = file.readAsStringSync();
    final obj = loadYaml(yamlString) as YamlMap;
    return obj.map(
      (dynamic key, dynamic value) => MapEntry(
        key as String,
        Options.fromJson(value as Map<String, Object?>),
      ),
    );
  } else {
    return null;
  }
}
