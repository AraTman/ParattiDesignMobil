import 'package:qparattidesign/home.dart';
import 'package:qparattidesign/login.dart';
import 'package:qparattidesign/musicplayer.dart';

typedef T Constructor<T>();

final Map<String, Constructor<Object>> _constructors =
    <String, Constructor<Object>>{};

void register<T>(Constructor<T> constructor) {
  _constructors[T.toString()] = constructor;
}

class ClassBuilder {
  static void registerClasses() {
    register<Home>(() => Home());
    register<Login>(() => Login());
    register<MusicPlayer>(() => MusicPlayer());
  }

  static dynamic fromString(String type) {
    return _constructors[type]();
  }
}
