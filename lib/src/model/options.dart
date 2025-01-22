import 'package:image/image.dart';
import 'package:json_annotation/json_annotation.dart';

part 'options.g.dart';

@JsonSerializable(
  createToJson: false,
  fieldRename: FieldRename.snake,
)
final class Options {
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

  factory Options.fromJson(Map<String, Object?> json) =>
      _$OptionsFromJson(json);

  /// AppIcon for iOS and Android, required.
  final String image;

  /// AppIcon for macOS. Optional, if it is not defined, [image] will be used.
  final String macosImage;

  /// Add padding for [macosImage] to [macosImageTargetSize].
  /// The new size has to be greater than the original size.
  final int? macosImageTargetSize;

  /// If [image] contains alpha channel, it will be removed by
  /// [backgroundColor], iOS only.
  @JsonKey(fromJson: _readColor)
  final Color? backgroundColor;

  /// Apply tint for [image] by [contentColor]
  @JsonKey(fromJson: _readColor)
  final Color? contentColor;

  /// Launch Icon (Splash screen)
  final String launchImage;

  /// Copy GoogleService-Info.plist to the corresponding folder, iOS only.
  final String googleServiceInfo;

  /// Generate strings resources
  final Map<String, Object?> strings;
}

Color? _readColor(int? value) {
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
