import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Asamp {
  List<Audio> song;
  int index;
  bool? notify;
  // Asamp({required this.song, required this.index});
  Future<bool?> setNotifyValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    notify = await prefs.getBool("switchState");
    print(notify);
    return notify;
  }

  Asamp({required this.song, required this.index});
  final AssetsAudioPlayer _assetsAudioPlayer = AssetsAudioPlayer.withId("0");
  open() async {
  bool? notify=await setNotifyValue();
    _assetsAudioPlayer.open(Playlist(audios: song, startIndex: index),
        autoStart: true,
        showNotification: notify == null || notify == true ? true : false,
        loopMode: LoopMode.single,
        notificationSettings: const NotificationSettings(stopEnabled: false));
  }

  // List<Audio> convertToAudio(List songs) {
  //   List<Audio> audios = [];
  //   for (var element in songs) {
  //     audios.add(
  //       Audio.file(
  //         element.uri.toString(),
  //         metas: Metas(
  //           title: element.title,
  //           artist: element.artist,
  //           id: element.id.toString(),
  //         ),
  //       ),
  //     );
  //   }
  //   return audios;
  // }
  // final audios = <Audio>[
  //   Audio(
  //     'assets/images/song 1.mp3',
  //     metas: Metas(
  //         // id: 'Winter Bear',
  //         title: 'Winter Bear',
  //         artist: 'V',
  //         album: 'Melody',
  //         image: const MetasImage.asset("assets/images/song 1.jpg")),
  //   ),
  //   Audio(
  //     'assets/images/song 2.mp3',
  //     metas: Metas(
  //         // id: 'Levitating',
  //         title: 'Sweet Night',
  //         artist: 'V',
  //         album: 'Melody',
  //         image: const MetasImage.asset("assets/images/song 2.jpg")),
  //   ),
  //   Audio(
  //     'assets/images/song 3.mp3',
  //     metas: Metas(
  //         // id: 'Levitating',
  //         title: 'Waiting on You',
  //         artist: 'RYYZ',
  //         album: 'Melody',
  //         image: const MetasImage.asset("assets/images/song 3.jpg")),
  //   ),
  //   Audio(
  //     'assets/images/song 4.mp3',
  //     metas: Metas(
  //         // id: 'Levitating',
  //         title: 'Sweet Night',
  //         artist: 'Dua Lip',
  //         album: 'Melody',
  //         image: const MetasImage.asset("assets/images/song 4.png")),
  //   ),
  // ];
}
