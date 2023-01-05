const iosRunnerFolder = 'ios/Runner/';
const iosAssetFolder = '${iosRunnerFolder}Assets.xcassets/';
const iosDefaultIconFolder = '${iosAssetFolder}AppIcon.appiconset/';
const iosDefaultLaunchImageFolder = '${iosAssetFolder}LaunchImage.imageset/';
const iosFlutterFolder = 'ios/Flutter/';

String androidResFolderOf(String flavor) => 'android/app/src/$flavor/res/';

String androidDrawableFolderOf(String flavor, int scale) {
  const scaleMap = {1: 'mdpi', 2: 'xhdpi', 3: 'xxhdpi', 4: 'xxxhdpi'};
  final name = scaleMap[scale] ??
      (throw Exception('scale $scale is not available in Android'));
  return '${androidResFolderOf(flavor)}/drawable-$name';
}

const macosRunnerFolder = 'macos/Runner/';
const macosAssetFolder = '${macosRunnerFolder}Assets.xcassets/';
const macosDefaultIconFolder = '${macosAssetFolder}AppIcon.appiconset/';
const macosDefaultLaunchImageFolder =
    '${macosAssetFolder}LaunchImage.imageset/';
const macosFlutterFolder = 'ios/Flutter/';
