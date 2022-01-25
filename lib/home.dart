import 'dart:async';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:music/asset.dart';
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
  final OnAudioQuery _audioQuery = OnAudioQuery();
  final a = Asamp();

  final AssetsAudioPlayer _assetsAudioPlayer = AssetsAudioPlayer.withId("0");

  @override
  void initState() {
    super.initState();
    requestPermission();
  }

  requestPermission() async {
    if (!kIsWeb) {
      bool permissionStatus = await _audioQuery.permissionsStatus();
      if (!permissionStatus) {
        await _audioQuery.permissionsRequest();
        //      }
        // allsong = await _audioQuery.querySongs();

        // allsong.forEach((element) {
        //   audiosongs.add(Audio.file(element.uri.toString(),
        //       metas: Metas(
        //           title: element.title,
        //           id: element.id.toString(),
        //           artist: element.artist)));
        // });
        setState(() {});
      }
    }
  }

  void openPlayer() async {
    print("g");
    await _assetsAudioPlayer.open(
      Playlist(audios: a.audios, startIndex: 0),
      showNotification: true,
      autoStart: true,
      
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(25, 20, 20, 100),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(25, 20, 20, 100),
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
      body: FutureBuilder<List<SongModel>>(
        future: _audioQuery.querySongs(
          sortType: null,
          orderType: OrderType.ASC_OR_SMALLER,
          uriType: UriType.EXTERNAL,
          ignoreCase: true,
        ),
        builder: (context, item) {
          if (item.data == null) return CircularProgressIndicator();
          if (item.data!.isEmpty) return Text("Nothing found!");
          return ListView.builder(
            itemCount: item.data!.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(item.data![index].title,
                    style: TextStyle(
                        color: Color.fromRGBO(194, 194, 194, 100),
                        fontSize: 20)),
                subtitle: Text(item.data![index].artist ?? "No artist",
                    style: TextStyle(
                        color: Color.fromRGBO(194, 194, 194, 100),
                        fontSize: 15)),
                trailing: Padding(
                  padding: const EdgeInsets.only(right: 0),
                  child: PopupMenuButton<String>(
                    color: Colors.white70,
                    icon: FaIcon(FontAwesomeIcons.ellipsisV,
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
                  // a.oppenAsset(item.data, index)(item.data, index);
                  openPlayer();

                  {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Play()),
                    );
                  }
                  ;
                },
                leading: QueryArtworkWidget(
                  id: item.data![index].id,
                  type: ArtworkType.AUDIO,
                  nullArtworkWidget:
                      Image(image: AssetImage("assets/images/logo.png")),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
