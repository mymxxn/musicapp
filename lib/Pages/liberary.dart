import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music/Pages/create.dart';
import 'package:music/Pages/editplaylist.dart';
import 'package:music/Pages/liked.dart';
import 'package:music/Pages/playlist.dart';
import 'package:music/database/box.dart';
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
      resizeToAvoidBottomInset: false,
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
                                trailing: PopupMenuButton(
                                  color: Theme.of(context).primaryColor,
                                  offset: Offset.zero,
                                  itemBuilder: (BuildContext bc) => [
                                    PopupMenuItem(
                                      value: "0",
                                      child: Text(
                                        "Edit playlist",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Theme.of(context)
                                                .iconTheme
                                                .color),
                                      ),
                                    ),
                                    PopupMenuItem(
                                      value: "1",
                                      child: Text(
                                        "Delete playlist",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Theme.of(context)
                                                .iconTheme
                                                .color),
                                      ),
                                    ),
                                  ],
                                  onSelected: (value) {
                                    if (value == "1") {
                                      box.delete(playlists[index]);
                                    }
                                    if (value == "0") {
                                      showDialog(
                                        context: context,
                                        builder: (context) => EditPlaylist(
                                          playlistName: playlists[index],
                                        ),
                                      );
                                    }
                                  },
                                  icon: Icon(
                                    Icons.more_vert_outlined,
                                    color: Theme.of(context).iconTheme.color,
                                  ),
                                ),
                              )
                            : Container()));
              })
        ],
      ),
    );
  }
}
