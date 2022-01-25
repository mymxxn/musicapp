import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Asamp {
  // final AssetsAudioPlayer _assetsAudioPlayer = AssetsAudioPlayer.withId("0");
  // oppenAsset(List<Audio>? audios, int index) async {
  //   _assetsAudioPlayer.open(Playlist(audios: audios, startIndex: index),
  //       autoStart: true, showNotification: true);
  // }

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
  final audios = <Audio>[
    Audio(
      'assets/images/Winter Bear by V.mp3',
      metas: Metas(
          id: 'Winter Bear',
          title: 'Winter Bear',
          artist: 'V',
          album: 'Melody',
          image: MetasImage.asset("assets/images/play.jpg")),
    ),
    Audio(
      'assets/images/song.mp3',
      metas: Metas(
          id: 'Winter Bear',
          title: 'Winter Bear',
          artist: 'V',
          album: 'Melody',
          image: MetasImage.asset("assets/images/play.jpg")),
    )
  ];
}
