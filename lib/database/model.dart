import 'package:hive/hive.dart';
part 'model.g.dart';
@HiveType(typeId: 4)
class AudioModel extends HiveObject {
  @HiveField(0)
  String? title;
  @HiveField(1)
  String? artist;
  @HiveField(2)
  String? url;
  @HiveField(3)
  int? id;
  @HiveField(4)
  int? duration;
  AudioModel(
      {required this.title,
      required this.artist,
      required this.url,
      required this.id,
      required this.duration});
}
