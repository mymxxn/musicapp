import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';

import 'package:music/asset.dart';
import 'package:music/database/box.dart';
import 'package:music/database/model.dart';
import 'package:music/muix.dart';
import 'package:music/settings.dart';
import 'package:on_audio_query/on_audio_query.dart';
// import 'package:music/widget.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Audio> song = [];
  final OnAudioQuery _audioQuery = OnAudioQuery();

  @override
  void initState() {
    super.initState();
    requestPermission();
  }

  // final box = Hive.box("songs");
  
  List<AudioModel> allsong = [];
  List<AudioModel> allsongsfromdb = [];
  requestPermission() async {
    bool permissionStatus = await _audioQuery.permissionsStatus();
    if (!permissionStatus) {
      await _audioQuery.permissionsRequest();
    }
    final AllSongs = await _audioQuery.querySongs();

    
    Box<List<AudioModel>>? box;
    List<AudioModel> ALLSONGS = [];
    
    box ??= Hive.box(boxes);

    // var a = await box!.get("musics");
    // print(a);
    ALLSONGS = AllSongs.map((e) => AudioModel(
        title: e.title,
        artist: e.artist,
        url: e.uri,
        id: e.id,
        duration: e.duration)).toList();
    await box.put("musics", ALLSONGS);
    allsongsfromdb = box.get("musics")!;
allsongsfromdb.forEach((element) {
      song.add(Audio.file(element.url.toString(),
          metas: Metas(
              title: element.title,
              id: element.id.toString(),
              artist: element.artist)));
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // print(audb.first);
    return Scaffold(
        backgroundColor: const Color.fromRGBO(25, 20, 20, 100),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text(
            "Home",
            style: TextStyle(
                color: Color.fromRGBO(194, 194, 194, 100),
                fontSize: 30,
                fontWeight: FontWeight.w600),
          ),
          actions: <Widget>[
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Settings()),
                );
              },
              icon: const Icon(Icons.settings),
              color: const Color.fromRGBO(194, 194, 194, 100),
            )
          ],
          elevation: 0,
        ),
        body: ListView.builder(
          itemCount: allsongsfromdb.length,
          itemBuilder: (context, index) {
            return ListTile(
                title: Text(allsongsfromdb[index].title!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: Color.fromRGBO(194, 194, 194, 100),
                        fontSize: 20)),
                subtitle: Text(allsongsfromdb[index].artist ?? "Unknown",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: Color.fromRGBO(194, 194, 194, 100),
                        fontSize: 15)),
                trailing: Padding(
                  padding: const EdgeInsets.only(right: 0),
                  child: PopupMenuButton<String>(
                    color: Colors.white70,
                    icon: const FaIcon(FontAwesomeIcons.ellipsisV,
                        color: Color.fromRGBO(194, 194, 194, 100)),
                    // onSelected: (String result) {
                    //   switch (result) {
                    //     case 'Liked songs':
                    //       print('added to liked songs');
                    //       break;
                    //     case 'playlist':
                    //       print('Playlist added');
                    //       break;
                    //     default:
                    //   }
                    // },
                    itemBuilder: (BuildContext context) =>
                        <PopupMenuEntry<String>>[
                      const PopupMenuItem<String>(
                        value: 'Liked',
                        child: Text('Add to liked songs'),
                      ),
                      const PopupMenuItem<String>(
                        value: 'Playlist',
                        child: Text('Add to Playlist'),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Asamp().oppenAsset(index: index, audios: song);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Play(
                              index: index,
                              song: song,
                            )),
                  );
                },
                leading: QueryArtworkWidget(
                    id: allsongsfromdb[index].id!,
                    type: ArtworkType.AUDIO,
                    nullArtworkWidget: Image.asset("assets/images/logo.png")));
          },
        ));
  }
}
