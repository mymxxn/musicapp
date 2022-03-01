import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music/Pages/nowplaying.dart';
import 'package:music/asset.dart';
import 'package:music/database/box.dart';
import 'package:music/database/model.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Liked extends StatefulWidget {
  const Liked({Key? key}) : super(key: key);

  @override
  _LikedState createState() => _LikedState();
}

class _LikedState extends State<Liked> {
  final box = Boxy.getInstance();
  List<Audio> likedplay = [];
  AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.withId("0");
  List<AudioModel>? likedsongs = [];
  List<AudioModel>? allsongsfromdb = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
          color: Theme.of(context).primaryIconTheme.color,
        ),
        title: Text(
          "Liked Songs",
          style: GoogleFonts.elMessiri(
              textStyle: TextStyle(
            color: Theme.of(context).iconTheme.color,
            fontSize: 30,
            fontWeight: FontWeight.w700,
          )),
        ),
        elevation: 0,
      ),
      body: ValueListenableBuilder(
          valueListenable: box.listenable(),
          builder: (context, boxes, _) {
            List<dynamic>? likedSongs = box.get("Liked Songs");
            return ListView.builder(
                itemCount: likedSongs!.length,
                itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        for (var element in likedSongs) { 
                          likedplay.add(
                            Audio.file(
                              element.uri!,
                              metas: Metas(
                                title: element.title,
                                id: element.id.toString(),
                                artist: element.artist,
                              ),
                            ),
                          );
                        }
                        Asamp(song: likedplay, index: index).open();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Play(
                                    song: likedplay,
                                    // allsongsfromdb: allsongsfromdb!,
                                  )),
                        );
                      },
                      child: ListTile(
                          leading: QueryArtworkWidget(
                              id: likedSongs[index].id!,
                              type: ArtworkType.AUDIO,
                              nullArtworkWidget:
                                  Image.asset("assets/images/logo.png")),
                          title: Text(likedSongs[index].title!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color:
                                      Theme.of(context).primaryIconTheme.color,
                                  fontSize: 20)),
                          subtitle: Text(likedSongs[index].artist ?? "Unknown",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Theme.of(context).splashColor,
                                  fontSize: 15)),
                          onLongPress: () => showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    actions: [
                                      TextButton(
                                          onPressed: () async {
                                            Navigator.pop(context);

                                            setState(() {
                                              likedSongs.removeAt(index);
                                              box.put(
                                                  "Liked Songs", likedSongs);
                                            });
                                          },
                                          child: Center(
                                            child: FaIcon(
                                              FontAwesomeIcons.heartBroken,
                                              color: Theme.of(context)
                                                  .iconTheme
                                                  .color,
                                            ),
                                          ))
                                    ],
                                  ))
                          // setState(() {
                          //   likedSongs.removeAt(index);
                          //   box.put("Liked Songs", likedSongs);
                          // });

                          ),
                    ));
          }),
    );
  }
}
