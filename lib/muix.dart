
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Play extends StatefulWidget {
  int index;
  List<Audio> song = [];

  // List<Audio> a = [];
  Play({
    Key? key,
    required this.index,
    required this.song,
  }) : super(key: key);

  @override
  _PlayState createState() => _PlayState();
}

class _PlayState extends State<Play> with SingleTickerProviderStateMixin {
  late AnimationController iconController;
  bool isAnimated = false;
  bool showPlay = true;
  bool shopPause = false;
  // Duration position = const Duration();
  // Duration musicLength = const Duration();
  AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.withId("0");
  Color _iconColor = const Color.fromRGBO(175, 175, 175, 120);
  // final a = Asamp(song: song, index: index);

  @override
  void initState() {
    super.initState();
    iconController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
  }

  Audio find(List<Audio> source, String fromPath) {
    return source.firstWhere((element) => element.path == fromPath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: audioPlayer.builderCurrent(
        builder: (BuildContext context, Playing playing) {
      final myAudio = find(widget.song, playing.audio.assetAudioPath);

      return Stack(children: <Widget>[
        Container(
          color: Colors.black87,
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              child: Row(
                children: const [
                  BackButton(
                    color: Color.fromRGBO(175, 175, 175, 50),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Container(
                width: 278,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(0),
                  child: QueryArtworkWidget(
                    id: int.parse(myAudio.metas.id!),
                    type: ArtworkType.AUDIO,
                    nullArtworkWidget: Image.asset('assets/images/logo.png'),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 27, top: 100),
              child: Container(
                // height: 200,
                // color: Colors.black12,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: Text(myAudio.metas.title!.toString(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: Color.fromRGBO(220, 228, 232, 100),
                              fontSize: 22)),
                      subtitle: Text(myAudio.metas.artist ?? "Unknown",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: Color.fromRGBO(175, 175, 175, 120),
                              fontSize: 20)),
                      trailing: const FaIcon(
                        FontAwesomeIcons.heart,
                        color: Color.fromRGBO(175, 175, 175, 120),
                        size: 18,
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: audioPlayer.builderRealtimePlayingInfos(
                            builder: (context, RealtimePlayingInfos? infos) {
                          if (infos == null) {
                            return const SizedBox();
                          }
                          return ProgressBar(
                            timeLabelPadding: 0.2,
                            barHeight: 2,
                            progressBarColor: Colors.grey[800],
                            thumbColor: Colors.black87,
                            baseBarColor: Colors.grey[500],
                            progress: infos.currentPosition,
                            total: infos.duration,
                            timeLabelTextStyle: const TextStyle(
                                color: Color.fromRGBO(25, 20, 20, 100)),
                          );
                        })),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: const FaIcon(
                              FontAwesomeIcons.random,
                              color: Color.fromRGBO(175, 175, 175, 120),
                              size: 18,
                            )),
                        InkWell(
                          child: const Icon(
                            CupertinoIcons.backward_fill,
                            color: Color.fromRGBO(175, 175, 175, 120),
                          ),
                          onTap: () {
                            audioPlayer.previous();
                          },
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                          onTap: () {
                            animateIcon();
                          },
                          child: AnimatedIcon(
                            icon: AnimatedIcons.pause_play,
                            progress: iconController,
                            size: 55,
                            color: const Color.fromRGBO(195, 195, 195, 10),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        InkWell(
                          child: const Icon(
                            CupertinoIcons.forward_fill,
                            color: Color.fromRGBO(175, 175, 175, 120),
                          ),
                          onTap: () {
                            audioPlayer.next();
                          },
                        ),
                        IconButton(
                          onPressed: () {
                            audioPlayer.loopMode;
                            setState(() {
                              _iconColor = Colors.black87;
                            });
                          },
                          disabledColor: const Color(0xFFFFFFFF),
                          icon: const Icon(Icons.repeat),
                          color: _iconColor,
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          Icon(
                            Icons.playlist_add,
                            color: Color.fromRGBO(175, 175, 175, 120),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ]),
        )
      ]);
    }));
  }

  void animateIcon() {
    setState(() {
      isAnimated = !isAnimated;
      if (isAnimated) {
        iconController.forward();
        audioPlayer.pause();
      } else {
        iconController.reverse();
        audioPlayer.play();
      }
    });
  }

  @override
  void dispose() {
    iconController.dispose();
    audioPlayer.dispose();
    super.dispose();
  }
}
