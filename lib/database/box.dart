import 'package:hive/hive.dart';
import 'package:music/database/model.dart';

String boxes = "audios";

class Boxy {
  static Box<List<AudioModel>>? _box;
  static Box<List<AudioModel>> getInstance() {
    return _box ??= Hive.box(boxes);
  }
}
