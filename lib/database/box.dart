import 'package:hive/hive.dart';
// import 'package:music/database/model.dart';

String boxes = "audios";

class Boxy {
  static Box<List<dynamic>> getInstance() => 
    Hive.box<List<dynamic>>(boxes);
}
