import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';

class Bottom extends StatefulWidget {
   Bottom({Key? key}) : super(key: key);
   final _assetsAudioPlayer = AssetsAudioPlayer.withId("0");

  @override
  _BottomState createState() => _BottomState();
}

class _BottomState extends State<Bottom> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        decoration: const BoxDecoration(
            color: Color.fromRGBO(51, 36, 36, 100),
            borderRadius: BorderRadius.all(Radius.circular(5))),
        margin: const EdgeInsets.only(left: 5, right: 5),
        // child: _assetsAudioPlayer
      ),
    );
  }
}
