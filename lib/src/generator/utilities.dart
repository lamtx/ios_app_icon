import 'package:image/image.dart';

void check(bool value) {
  if (!value) {
    throw AssertionError('Value not true');
  }
}

extension ColorExt on Color {
  String hex() {
    return "0x${_hex(a)}${_hex(r)}${_hex(g)}${_hex(b)}";
  }

  String _hex(num value) => value.toInt().toRadixString(16).padLeft(2, "0");
}
