import 'dart:io';

import 'package:path/path.dart' as p;

import '../define.dart';
import '../model/options.dart';

void copyGoogleServiceInfo(Options options) {
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
