import 'package:assets_audio_player/assets_audio_player.dart';

class Asamp {
  final AssetsAudioPlayer _assetsAudioPlayer = AssetsAudioPlayer.withId("0");
  oppenAsset( List<Audio>? audios, int index) async {
    _assetsAudioPlayer.open(Playlist(audios: audios, startIndex: index),
        autoStart: true, showNotification: true);
  }

  List<Audio> convertToAudios(List songs) {
    List<Audio> audios = [];
    for (var element in songs) {
      audios.add(
        Audio.file(
          element.uri.toString(),
          metas: Metas(
            title: element.title,
            artist: element.artist,
            id: element.id.toString(),
          ),
        ),
      );
    }
    return audios;
  }
}
