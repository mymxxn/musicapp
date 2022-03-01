import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:music/Pages/bottomsong.dart';
import 'package:music/Pages/nowplaying.dart';
import 'package:music/Pages/settings.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:music/asset.dart';
import 'package:music/database/box.dart';
import 'package:music/database/model.dart';
// import 'package:music/widget.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();

    fetch();
  }

  List<Audio> song = [];
  final OnAudioQuery _audioQuery = OnAudioQuery();

  // final box = Hive.box("songs");
  AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.withId("0");
  List<AudioModel> allsong = [];
  List<AudioModel> allsongsfromdb = [];
  List? likedsongs = [];
  final box = Boxy.getInstance();

  fetch() async {
    bool permissionStatus = await _audioQuery.permissionsStatus();
    if (!permissionStatus) {
      await _audioQuery.permissionsRequest();
    }
    final AllSongs = await _audioQuery.querySongs();

    final box = Boxy.getInstance();
    List<AudioModel> ALLSONGS = [];

    ALLSONGS = AllSongs.map((e) => AudioModel(
        title: e.title,
        artist: e.artist,
        url: e.uri,
        id: e.id,
        duration: e.duration)).toList();
    await box.put("musics", ALLSONGS);
    allsongsfromdb = box.get("musics") as List<AudioModel>;
    allsongsfromdb.forEach((element) {
      song.add(Audio.file(element.url.toString(),
          metas: Metas(
              title: element.title,
              id: element.id.toString(),
              artist: element.artist)));
    });
    setState(() {});
  }

  Audio find(List<Audio> source, String fromPath) {
    return source.firstWhere((element) => element.path == fromPath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          iconTheme: Theme.of(context).iconTheme,
          backgroundColor: Colors.transparent,
          title: Text("Home",
              style: GoogleFonts.elMessiri(
                  textStyle: TextStyle(
                color: Theme.of(context).iconTheme.color,
                fontSize: 30,
                fontWeight: FontWeight.w700,
              ))),
          actions: <Widget>[
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Settings()),
                );
              },
              icon: const Icon(Icons.settings),
              color: Theme.of(context).iconTheme.color,
            )
          ],
          elevation: 0,
        ),
        body: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  ListView.builder(
                    itemCount: allsongsfromdb.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                          title: Text(allsongsfromdb[index].title!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.abhayaLibre(
                                  textStyle: TextStyle(
                                      color: Theme.of(context)
                                          .primaryIconTheme
                                          .color,
                                      fontSize: 20))),
                          subtitle: Text(
                              allsongsfromdb[index].artist ?? "Unknown",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Theme.of(context).splashColor,
                                  fontSize: 15)),
                          onLongPress: () => showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                likedsongs = box.get("Liked Songs");
                                return Dialog(
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ListTile(
                                        title: Text(
                                          "Add to playlist",
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .iconTheme
                                                  .color),
                                        ),
                                        onTap: () {
                                          Navigator.of(context).pop();
                                          showModalBottomSheet(
                                              context: context,
                                              builder: (context) =>
                                                  Bottomplaying(
                                                    song: allsongsfromdb[index],
                                                   
                                                  ));
                                        },
                                      ),
                                      likedsongs!
                                              .where((element) =>
                                                  element.id.toString() ==
                                                  allsongsfromdb[index]
                                                      .id
                                                      .toString())
                                              .isEmpty
                                          ? ListTile(
                                              title: Text(
                                                "Add to Liked songs",
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .iconTheme
                                                        .color),
                                              ),
                                              onTap: () async {
                                                // final audios = box.get("musics"); final temp = audios.firstWhere((element) => element.id.toString()== widget.allson
                                                likedsongs?.add(
                                                    allsongsfromdb[index]);
                                                Navigator.pop(context);
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(content: Text("Added to Liked Songs!",style: TextStyle(),)));
                                              },
                                            )
                                          : ListTile(
                                              title: Text(
                                                "Remove from Liked Songs",
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .iconTheme
                                                        .color),
                                              ),
                                              onTap: () async {
                                                likedsongs?.removeWhere(
                                                    (element) =>
                                                        element.id.toString() ==
                                                        allsongsfromdb[index]
                                                            .id
                                                            .toString());
                                                setState(() {});
                                                Navigator.of(context).pop();
                                              },
                                            )
                                    ],
                                  ),
                                );
                              }),
                          onTap: () {
                            Asamp(song: song, index: index).open();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Play(
                                        song: song,
                                        //  allsongsfromdb: allsongsfromdb,
                                      )),
                            );
                          },
                          leading: QueryArtworkWidget(
                              id: allsongsfromdb[index].id!,
                              type: ArtworkType.AUDIO,
                              nullArtworkWidget:
                                  Image.asset("assets/images/logo.png")));
                    },
                  ),
                  audioPlayer.builderCurrent(
                      builder: (BuildContext context, Playing? playing) {
                    final myAudio = find(song, playing!.audio.assetAudioPath);
                    return Column(
                      children: [
                        Expanded(
                          child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                  height: 55,
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).iconTheme.color,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(30))),
                                  margin: const EdgeInsets.only(
                                      left: 10, right: 10, bottom: 8),
                                  child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Play(
                                                    song: song,
                                                    // allsongsfromdb:
                                                    // allsongsfromdb,
                                                  )),
                                        );
                                      },
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20),
                                        child: Row(
                                          children: [
                                            QueryArtworkWidget(
                                              id: int.parse(myAudio.metas.id!),
                                              type: ArtworkType.AUDIO,
                                              nullArtworkWidget: Image.asset(
                                                'assets/images/logo.png',
                                                height: 40,
                                                fit: BoxFit.cover,
                                              ),
                                              artworkFit: BoxFit.cover,
                                            ),
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            Expanded(
                                                child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      myAudio.metas.title!
                                                          .toString(),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          color:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                          fontSize: 16)),
                                                  Text(
                                                      myAudio.metas.artist ??
                                                          "Unknown",
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          color: Theme.of(
                                                                  context)
                                                              .primaryIconTheme
                                                              .color,
                                                          fontSize: 12)),
                                                ],
                                              ),
                                            )),
                                            const Spacer(),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 15),
                                              child: PlayerBuilder.isPlaying(
                                                  player: audioPlayer,
                                                  builder:
                                                      (context, isPlaying) {
                                                    return GestureDetector(
                                                        onTap: () async {
                                                          await audioPlayer
                                                              .playOrPause();
                                                        },
                                                        child: Icon(
                                                          isPlaying
                                                              ? Icons.pause
                                                              : Icons
                                                                  .play_arrow,
                                                          size: 28,
                                                          color:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                        ));
                                                  }),
                                            )
                                          ],
                                        ),
                                      )))),
                        ),
                      ],
                    );
                  })
                ],
              ),
            ),
          ],
        ));
  }
}
