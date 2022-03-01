import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music/Pages/nowplaying.dart';
import 'package:music/asset.dart';
import 'package:music/database/box.dart';
import 'package:music/database/model.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Playli extends StatefulWidget {
  String playlistName;
  Playli({Key? key, required this.playlistName}) : super(key: key);

  @override
  _PlayliState createState() => _PlayliState();
}

class _PlayliState extends State<Playli> {
  List<Audio> play = [];
  // List<AudioModel>? playsong = [];
  // List<AudioModel> allsongsfromdb = [];
  final box = Boxy.getInstance();
  List<Audio> likedplay = [];
  AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.withId("0");
  List playlistsongs = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).iconTheme.color,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          widget.playlistName,
          style: GoogleFonts.elMessiri(
              textStyle: TextStyle(
            color: Theme.of(context).iconTheme.color,
            fontSize: 30,
            fontWeight: FontWeight.w700,
          )),
        ),
      ),
      body: ValueListenableBuilder(
          valueListenable: box.listenable(),
          builder: (context, boxes, _) {
            // List<dynamic> playlistsongs = box.get("audios") as List<AudioModel>;
            final playlists = box.get(widget.playlistName);
            return ListView.builder(
                itemCount: playlists!.length,
                itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        for (var element in playlists[index]) {
                          play.add(
                            Audio.file(
                              element.url!,
                              metas: Metas(
                                title: element.title,
                                id: element.id.toString(),
                                artist: element.artist,
                              ),
                            ),
                          );
                        }
                        Asamp(song: play, index: index).open();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Play(
                                    song: play,
                                  )),
                        );
                      },
                      child: ListTile(
                          leading: QueryArtworkWidget(
                              id: playlists[index].id!,
                              type: ArtworkType.AUDIO,
                              nullArtworkWidget:
                                  Image.asset("assets/images/logo.png")),
                          title: Text(playlists[index].title!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color:
                                      Theme.of(context).primaryIconTheme.color,
                                  fontSize: 20)),
                          subtitle: Text(playlists[index].artist ?? "Unknown",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  color: Color.fromRGBO(194, 194, 194, 100),
                                  fontSize: 15)),
                          onLongPress: () => showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    actions: [
                                      TextButton(
                                          onPressed: () async {
                                            Navigator.pop(context);

                                            setState(() {
                                              playlists.removeAt(index);
                                              box.put("Liked Songs", playlists);
                                            });
                                          },
                                          child: Center(
                                            child: Icon(
                                              Icons.delete,
                                              color: Theme.of(context)
                                                  .iconTheme
                                                  .color,
                                            ),
                                          ))
                                    ],
                                  ))),
                    ));
          }),
    );
  }
}
