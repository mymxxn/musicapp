import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:music/Pages/bottomsong.dart';
import 'package:music/database/box.dart';
import 'package:music/database/model.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Play extends StatefulWidget {
  List<Audio> song = [];

  // List<Audio> a = [];
  Play({Key? key, required this.song}) : super(key: key);

  @override
  _PlayState createState() => _PlayState();
}

class _PlayState extends State<Play> with SingleTickerProviderStateMixin {
  late AnimationController iconController;
  bool isAnimated = false;
  bool showPlay = true;
  bool shopPause = false;
  AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.withId("0");
  List likedsongs = [];
  final box = Boxy.getInstance();
  List<AudioModel> allsong = [];

  @override
  void initState() {
    super.initState();
    iconController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 100));
    allsong = box.get("musics") as List<AudioModel>;
  }

  Audio find(List<Audio> source, String fromPath) {
    return source.firstWhere((element) => element.path == fromPath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: audioPlayer.builderCurrent(
        builder: (BuildContext context, Playing? playing) {
      final myAudio = find(widget.song, playing!.audio.assetAudioPath);

      final currentsong = allsong.firstWhere(
          (element) => element.id.toString() == myAudio.metas.id.toString());
      var likedsongs = box.get("Liked Songs");
      return Stack(children: <Widget>[
        Container(
          color: Theme.of(context).primaryColor,
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: Theme.of(context).primaryIconTheme.color,
                      ))
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
                            style: TextStyle(
                                color: Theme.of(context).primaryIconTheme.color,
                                fontSize: 22)),
                        subtitle: Text(myAudio.metas.artist ?? "Unknown",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Theme.of(context).splashColor,
                                fontSize: 20)),
                        trailing: likedsongs!
                                .where((element) =>
                                    element.id.toString() ==
                                    myAudio.metas.id.toString())
                                .isEmpty
                            ? IconButton(
                                onPressed: () async {
                                  likedsongs.add(currentsong);
                                  await box.put("Liked Songs", likedsongs);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                            "Song added to Liked Songs",
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor),
                                          ),
                                          backgroundColor:
                                              Theme.of(context).splashColor));
                                  setState(() {});
                                },
                                icon: FaIcon(
                                  FontAwesomeIcons.heart,
                                  color: Theme.of(context).splashColor,
                                  size: 18,
                                ),
                              )
                            : IconButton(
                                onPressed: () async {
                                  likedsongs.removeWhere((element) =>
                                      element.id.toString() ==
                                      currentsong.id.toString());
                                  await box.put("Liked Songs", likedsongs);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                            "Song removed from Liked Songs",
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor),
                                          ),
                                          backgroundColor:
                                              Theme.of(context).splashColor));
                                  setState(() {});
                                },
                                icon: FaIcon(
                                  FontAwesomeIcons.solidHeart,
                                  color: Theme.of(context).splashColor,
                                  size: 18,
                                ),
                              )),
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
                            timeLabelTextStyle: TextStyle(
                                color: Theme.of(context).primaryColor),
                            onSeek: (duration) {
                              audioPlayer.seek(duration);
                            },
                          );
                        })),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Expanded(
                        //   child:
                        //    IconButton(
                        //       onPressed: () {},
                        //       icon: FaIcon(
                        //         FontAwesomeIcons.random,
                        //         color: Theme.of(context).splashColor,
                        //         size: 18,
                        //       )),
                        // ),
                        InkWell(
                          child: Icon(
                            CupertinoIcons.backward_fill,
                            color: Theme.of(context).splashColor,
                          ),
                          onTap: () {
                            audioPlayer.previous();
                          },
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        PlayerBuilder.isPlaying(
                            player: audioPlayer,
                            builder: (context, isPlaying) {
                              return GestureDetector(
                                  onTap: () async {
                                    await audioPlayer.playOrPause();
                                  },
                                  child: Icon(
                                    isPlaying
                                        ? Icons.pause_circle_outline
                                        : Icons.play_circle_outline_outlined,
                                    size: 55,
                                    color: Theme.of(context)
                                        .primaryIconTheme
                                        .color,
                                  ));
                            }),
                        const SizedBox(
                          width: 5,
                        ),
                        InkWell(
                          child: Icon(
                            CupertinoIcons.forward_fill,
                            color: Theme.of(context).splashColor,
                          ),
                          onTap: () {
                            audioPlayer.next();
                          },
                        ),
                        // IconButton(
                        //   onPressed: () {
                        //     audioPlayer.loopMode;
                        //   },
                        //   disabledColor: Theme.of(context).splashColor,
                        //   icon: const Icon(Icons.repeat),
                        //   color: Theme.of(context).splashColor,
                        // )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.playlist_add,
                              color: Theme.of(context).splashColor,
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) => Bottomplaying(
                                        song: currentsong,
                                      ));
                            },
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

  // void animateIcon() {
  //   setState(() {
  //     isAnimated = !isAnimated;
  //     if (isAnimated) {
  //       iconController.forward();
  //       audioPlayer.pause();
  //     } else {
  //       iconController.reverse();
  //       audioPlayer.play();
  //     }
  //   });
  // }

  @override
  void dispose() {
    iconController.dispose();
    super.dispose();
  }
}
