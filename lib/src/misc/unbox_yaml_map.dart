import 'dart:collection';

import 'package:yaml/yaml.dart';

final class UnboxYamlMap extends MapBase<String, Object?> {
  UnboxYamlMap(this._base);
  final YamlMap _base;

  @override
  Object? operator [](Object? key) {
    final a = _base[key];
    if (a is YamlMap) {
      return UnboxYamlMap(a);
    }
    return a;
  }

  @override
  void operator []=(String key, Object? value) {
    throw UnsupportedError("unmodifiable");
  }

  @override
  void clear() {

    throw UnsupportedError("unmodifiable");
  }

  @override
  Iterable<String> get keys => _base.keys.cast();

  @override
  Object? remove(Object? key) {
    throw UnsupportedError("unmodifiable");
  }
}