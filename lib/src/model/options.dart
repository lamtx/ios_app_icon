import 'package:image/image.dart';
import 'package:net/net.dart';

class Options {
  const Options({
    required this.image,
    required this.macosImage,
    required this.macosImageTargetSize,
    required this.backgroundColor,
    required this.contentColor,
    required this.launchImage,
    required this.googleServiceInfo,
    required this.strings,
  });

  /// AppIcon for iOS and Android, required.
  final String image;

  /// AppIcon for macOS. Optional, if it is not defined, [image] will be used.
  final String macosImage;

  /// Add padding for [macosImage] to [macosImageTargetSize].
  /// The new size has to be greater than the original size.
  final int? macosImageTargetSize;

  /// If [image] contains alpha channel, it will be removed by
  /// [backgroundColor], iOS only.
  final Color? backgroundColor;

  /// Apply tint for [image] by [contentColor]
  final Color? contentColor;

  /// Launch Icon (Splash screen)
  final String launchImage;

  /// Copy GoogleService-Info.plist to the corresponding folder, iOS only.
  final String googleServiceInfo;

  /// Generate strings resources
  final Map<String, Object?> strings;

  static final DataParser<Options> parser = (reader) => Options(
        image: reader.readString("image"),
        macosImage: reader.readString("macos_image"),
        macosImageTargetSize: reader.readNullableInt("macos_image_target_size"),
        backgroundColor: reader.readColor("background_color"),
        contentColor: reader.readColor("content_color"),
        launchImage: reader.readString("launch_image"),
        googleServiceInfo: reader.readString("google_service_info"),
        strings: reader.readMap("strings"),
      );
}

extension on JsonReader {
  Color? readColor(String name) {
    final value = readNullableInt(name);
    if (value == null) {
      return null;
    }
    final a = (0xff000000 & value) >> 24;
    final r = (0x00ff0000 & value) >> 16;
    final g = (0x0000ff00 & value) >> 8;
    final b = (0x000000ff & value) >> 0;
    if (a == 0xff) {
      return ColorUint8.rgb(r, g, b);
    } else {
      return ColorUint8.rgba(r, g, b, a);
    }
  }
}
