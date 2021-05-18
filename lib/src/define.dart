import 'contents_image_object.dart';
import 'ios_icon_template.dart';

const iosRunnerFolder = 'ios/Runner/';
const iosAssetFolder = '${iosRunnerFolder}Assets.xcassets/';
const iosDefaultIconFolder = '${iosAssetFolder}AppIcon.appiconset/';
const iosDefaultLaunchImageFolder = '${iosAssetFolder}LaunchImage.imageset/';
const iosDefaultIconName = 'Icon-App';
const iosIcons = <IosIconTemplate>[
  IosIconTemplate(name: '-20x20@1x', size: 20),
  IosIconTemplate(name: '-20x20@2x', size: 40),
  IosIconTemplate(name: '-20x20@3x', size: 60),
  IosIconTemplate(name: '-29x29@1x', size: 29),
  IosIconTemplate(name: '-29x29@2x', size: 58),
  IosIconTemplate(name: '-29x29@3x', size: 87),
  IosIconTemplate(name: '-40x40@1x', size: 40),
  IosIconTemplate(name: '-40x40@2x', size: 80),
  IosIconTemplate(name: '-40x40@3x', size: 120),
  IosIconTemplate(name: '-60x60@2x', size: 120),
  IosIconTemplate(name: '-60x60@3x', size: 180),
  IosIconTemplate(name: '-76x76@1x', size: 76),
  IosIconTemplate(name: '-76x76@2x', size: 152),
  IosIconTemplate(name: '-83.5x83.5@2x', size: 167),
  IosIconTemplate(name: '-1024x1024@1x', size: 1024),
];

const List<ContentsImageObject> iosImagesList = [
  ContentsImageObject(
    size: '20x20',
    idiom: 'iphone',
    filename: '$iosDefaultIconName-20x20@2x.png',
    scale: 2,
  ),
  ContentsImageObject(
    size: '20x20',
    idiom: 'iphone',
    filename: '$iosDefaultIconName-20x20@3x.png',
    scale: 3,
  ),
  ContentsImageObject(
    size: '29x29',
    idiom: 'iphone',
    filename: '$iosDefaultIconName-29x29@1x.png',
    scale: 1,
  ),
  ContentsImageObject(
    size: '29x29',
    idiom: 'iphone',
    filename: '$iosDefaultIconName-29x29@2x.png',
    scale: 2,
  ),
  ContentsImageObject(
    size: '29x29',
    idiom: 'iphone',
    filename: '$iosDefaultIconName-29x29@3x.png',
    scale: 3,
  ),
  ContentsImageObject(
    size: '40x40',
    idiom: 'iphone',
    filename: '$iosDefaultIconName-40x40@2x.png',
    scale: 2,
  ),
  ContentsImageObject(
    size: '40x40',
    idiom: 'iphone',
    filename: '$iosDefaultIconName-40x40@3x.png',
    scale: 3,
  ),
  ContentsImageObject(
    size: '60x60',
    idiom: 'iphone',
    filename: '$iosDefaultIconName-60x60@2x.png',
    scale: 2,
  ),
  ContentsImageObject(
    size: '60x60',
    idiom: 'iphone',
    filename: '$iosDefaultIconName-60x60@3x.png',
    scale: 3,
  ),
  ContentsImageObject(
    size: '20x20',
    idiom: 'ipad',
    filename: '$iosDefaultIconName-20x20@1x.png',
    scale: 1,
  ),
  ContentsImageObject(
    size: '20x20',
    idiom: 'ipad',
    filename: '$iosDefaultIconName-20x20@2x.png',
    scale: 2,
  ),
  ContentsImageObject(
    size: '29x29',
    idiom: 'ipad',
    filename: '$iosDefaultIconName-29x29@1x.png',
    scale: 1,
  ),
  ContentsImageObject(
    size: '29x29',
    idiom: 'ipad',
    filename: '$iosDefaultIconName-29x29@2x.png',
    scale: 2,
  ),
  ContentsImageObject(
    size: '40x40',
    idiom: 'ipad',
    filename: '$iosDefaultIconName-40x40@1x.png',
    scale: 1,
  ),
  ContentsImageObject(
    size: '40x40',
    idiom: 'ipad',
    filename: '$iosDefaultIconName-40x40@2x.png',
    scale: 2,
  ),
  ContentsImageObject(
    size: '76x76',
    idiom: 'ipad',
    filename: '$iosDefaultIconName-76x76@1x.png',
    scale: 1,
  ),
  ContentsImageObject(
    size: '76x76',
    idiom: 'ipad',
    filename: '$iosDefaultIconName-76x76@2x.png',
    scale: 2,
  ),
  ContentsImageObject(
    size: '83.5x83.5',
    idiom: 'ipad',
    filename: '$iosDefaultIconName-83.5x83.5@2x.png',
    scale: 2,
  ),
  ContentsImageObject(
    size: '1024x1024',
    idiom: 'ios-marketing',
    filename: '$iosDefaultIconName-1024x1024@1x.png',
    scale: 1,
  ),
];
