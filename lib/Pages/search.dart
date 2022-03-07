import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music/Pages/nowplaying.dart';
import 'package:music/asset.dart';
import 'package:music/database/model.dart';
import 'package:music/database/box.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<Audio> song = [];
  // List<AudioModel> allsong = [];
  List<AudioModel> allsongsfromdb = [];
  List<AudioModel> allSongs = [];

  String searchText = "";
  //Box<AudioModel> box = Hive.box<AudioModel>('musics');
  final box = Boxy.getInstance();

  @override
  void initState() {
    super.initState();
    getSongs();
  }

  Future<String> debounce() async {
    await Future.delayed(const Duration(seconds: 1));
    return "Waited 1";
  }

  getSongs() {
    allsongsfromdb = box.get("musics") as List<AudioModel>;
  }

  @override
  Widget build(BuildContext context) {
    List<AudioModel> searchResult = allsongsfromdb
        .where((e) => e.title!.toLowerCase().contains(
              searchText.toLowerCase(),
            ))
        .toList();
    for (var element in searchResult) {
      song = [];
      song.add(Audio.file(
        element.url!,
        metas: Metas(
            title: element.title,
            id: element.id.toString(),
            artist: element.artist),
      ));
    }
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "Search",
          style: GoogleFonts.elMessiri(
              textStyle: TextStyle(
            color: Theme.of(context).iconTheme.color,
            fontSize: 30,
            fontWeight: FontWeight.w700,
          )),
        ),
        elevation: 0,
      ),
      body: Column(children: [
        Column(children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextFormField(
              cursorColor: Theme.of(context).iconTheme.color,
              autofocus: false,
              keyboardType: TextInputType.text,
              style: TextStyle(color: Theme.of(context).primaryIconTheme.color),
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search_outlined,
                    color: Theme.of(context).iconTheme.color),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      width: 2.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      width: 2.0),
                ),
                hintText: "Search songs",
                hintStyle: TextStyle(color: Theme.of(context).splashColor),
                filled: true,
                contentPadding: const EdgeInsets.all(16),
                fillColor: Theme.of(context).primaryColor,
              ),
              onChanged: (value) {
                setState(() {
                  searchText = value;
                });
              },
            ),
          ),
        ]),
        searchText.isNotEmpty
            ? searchResult.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: searchResult.length,
                        itemBuilder: (context, index) {
                          return FutureBuilder(builder: (context, snapshot) {
                            return GestureDetector(
                                onTap: () {
                                  Asamp(song: song, index: index).open();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Play(
                                              song: song,
                                              // allsongsfromdb: allsongsfromdb,
                                            )),
                                  );
                                },
                                child: ListTile(
                                  leading: QueryArtworkWidget(
                                      id: searchResult[index].id!,
                                      type: ArtworkType.AUDIO,
                                      nullArtworkWidget: Image.asset(
                                          "assets/images/logo.png")),
                                  title: Text(searchResult[index].title!,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.abhayaLibre(
                                          textStyle: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryIconTheme
                                                  .color,
                                              fontSize: 20))),
                                  subtitle: Text(
                                      searchResult[index].artist ?? "Unknown",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Theme.of(context).splashColor,
                                          fontSize: 15)),
                                ));
                          });
                        }),
                  )
                : Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text("Nothing!",
                        style: TextStyle(
                            color: Theme.of(context).primaryIconTheme.color,
                            fontSize: 20)),
                  )
            : const SizedBox()
      ]),
    );
  }
}
