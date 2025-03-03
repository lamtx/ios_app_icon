// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'options.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Options _$OptionsFromJson(Map<dynamic, dynamic> json) => Options(
      image: json['image'] as String,
      macosImage: json['macos_image'] as String? ?? '',
      macosImageTargetSize: (json['macos_image_target_size'] as num?)?.toInt(),
      backgroundColor: _readColor((json['background_color'] as num?)?.toInt()),
      contentColor: _readColor((json['content_color'] as num?)?.toInt()),
      launchImage: json['launch_image'] as String? ?? '',
      googleServiceInfo: json['google_service_info'] as String? ?? '',
      strings: json['strings'] as Map<String, dynamic>? ?? {},
    );
