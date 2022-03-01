import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music/Pages/create.dart';
import 'package:music/Pages/liked.dart';
import 'package:music/Pages/playlist.dart';
// import 'package:hive/hive.dart';
import 'package:music/database/box.dart';
// import 'package:music/playtwo.dart';
// import 'package:assets_audio_player/assets_audio_player.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:hive/hive.dart';
// import 'package:music/asset.dart';
// import 'package:music/database/box.dart';
// import 'package:music/database/model.dart';
// import 'package:music/main.dart';
// import 'package:music/muix.dart';
// import 'package:on_audio_query/on_audio_query.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Playlist extends StatefulWidget {
  const Playlist({Key? key}) : super(key: key);

  @override
  _PlaylistState createState() => _PlaylistState();
}

class _PlaylistState extends State<Playlist> {
  final box = Boxy.getInstance();
  dynamic playlist = '';
  List allkeys = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "Library",
          style: GoogleFonts.elMessiri(
              textStyle: TextStyle(
            color: Theme.of(context).iconTheme.color,
            fontSize: 30,
            fontWeight: FontWeight.w700,
          )),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CreatePlaylist()),
              );
            },
            icon: const FaIcon(FontAwesomeIcons.plus),
            color: Theme.of(context).iconTheme.color,
          )
        ],
        elevation: 0,
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: ListView(
        children: [
          const SizedBox(
            height: 20,
            width: 10,
          ),
          ListTile(
            leading: Image.asset(
              'assets/images/like.png',
              width: 62,
              height: 85,
              scale: 0.8,
            ),
            title: Text(
              "Liked Songs",
              style: TextStyle(
                  color: Theme.of(context).primaryIconTheme.color,
                  fontSize: 20),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Liked()),
              );
            },
          ),
          const SizedBox(
            height: 10,
          ),
          ValueListenableBuilder(
              valueListenable: box.listenable(),
              builder: (context, boxes, _) {
                List<dynamic> playlists = box.keys.toList().cast();
                playlists.remove('musics');
                playlists.remove('Liked Songs');

                return ListView.builder(
                    itemExtent: 70,
                    itemCount: playlists.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) => GestureDetector(
                        onTap: () {},
                        child: playlists[index] != "audios" &&
                                playlists[index] != "Liked Songs"
                            ? ListTile(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Playli(
                                                playlistName: playlists[index],
                                              )));
                                },
                                leading: Icon(
                                  Icons.playlist_play_rounded,
                                  size: 70,
                                  color: Theme.of(context).iconTheme.color,
                                ),
                                title: Text(
                                  playlists[index].toString(),
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .primaryIconTheme
                                          .color,
                                      fontSize: 20),
                                ),
                                onLongPress: () => showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          actions: [
                                            TextButton(
                                                onPressed: () async {
                                                  Navigator.pop(context);
                                                  await box
                                                      .delete(playlists[index]);
                                                  setState(() {
                                                    playlists =
                                                        box.keys.toList();
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
                                        )))
                            : Container()));
              })
        ],
      ),
    );
  }
}
