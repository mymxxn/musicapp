
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:music/database/box.dart';

class Bottomplaying extends StatefulWidget {
  Bottomplaying({Key? key, required this.song}) : super(key: key);
  final song;

  @override
  State<Bottomplaying> createState() => _BottomplayingState();
}

class _BottomplayingState extends State<Bottomplaying> {
  // final AudioModel music;
  List playlists = [];

  String? playlistname = '';

  List<dynamic>? playlistsongs = [];

  final box = Boxy.getInstance();

  @override
  Widget build(BuildContext context) {
    playlists = box.keys.toList();

    return Container(
      padding: EdgeInsets.only(top: 10),
      child: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          ListTile(
            onTap: () => showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      title: Text(
                        "Create New",
                        style: TextStyle(
                            color: Theme.of(context).primaryIconTheme.color),
                      ),
                      content: TextField(
                          onChanged: (value) {
                            playlistname = value;
                          },
                          autofocus: true,
                          cursorColor: Theme.of(context).iconTheme.color,
                          decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).splashColor),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor)))),
                      actions: [
                        TextButton(
                            onPressed: () async {
                              List? existingname = [];
                              if (playlists.isNotEmpty) {
                                existingname = playlists
                                    .where((element) => element == playlistname)
                                    .toList();
                              }
                              if (playlistname != "" && existingname.isEmpty) {
                                await box.put(playlistname, playlistsongs!);
                                Navigator.of(context).pop();
                                setState(() {});
                              } else {
                                // SnackBar
                              }
                            },
                            child: Text(
                              'Create',
                              style: TextStyle(
                                  color: Theme.of(context).iconTheme.color),
                            ))
                      ],
                    )),
            leading: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: Theme.of(context).iconTheme.color,
                borderRadius: BorderRadius.all(Radius.circular(17)),
              ),
              child: Center(
                  child: Icon(
                Icons.add,
                color: Theme.of(context).primaryColor,
                size: 28,
              )),
            ),
            title: const Text(
              "Create Playlist",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ...playlists
              .map((e) => e != "musics" && e != "Liked Songs"
                  ? ListTile(
                      onTap: () async {
                        playlistsongs = box.get(e);
                        List existingSongs = [];
                        existingSongs = playlistsongs!
                            .where((element) =>
                                element.id.toString() == widget.song.toString())
                            .toList();

                        if (existingSongs.isEmpty) {
                          playlistsongs?.add(widget.song);

                          await box.put(e, playlistsongs!);
                          setState(() {});
                          Navigator.of(context).pop();
                          Fluttertoast.showToast(
                              msg: 'Song added to Playlist',
                              textColor: Theme.of(context).primaryColor,
                              backgroundColor: Theme.of(context).splashColor);
                        } else {
                          Navigator.of(context).pop();
                        }
                      },
                      leading: Container(
                        height: 50,
                        width: 50,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/images/logo.png"),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.all(Radius.circular(17)),
                        ),
                      ),
                      title: Text(
                        e.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  : Container())
              .toList()
        ],
      ),
    );
  }
}
