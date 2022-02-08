import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:music/asset.dart';
import 'package:music/database/model.dart';
import 'package:music/database/box.dart';
import 'package:music/muix.dart';
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

// Widget bottom() => Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Container(
//         height: 42,
//         width: 56,
//         decoration: BoxDecoration(
//           color: Color.fromRGBO(51, 36, 36, 100),
//           borderRadius: BorderRadius.circular(40),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(0),
//           child: ListTile(
//             leading: Image.asset(
//               'assets/images/mus.jpg',
//               height: 25,
//               width: 30,
//             ),
//             title: Text('Winter Bear'),
//             subtitle: Text('V'),
//             trailing: Icon(Icons.play_arrow),
//           ),
//         ),
//       ),
//     );
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
        backgroundColor: const Color.fromRGBO(25, 20, 20, 100),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text(
            "Search",
            style: TextStyle(
                color: Color.fromRGBO(194, 194, 194, 100),
                fontSize: 30,
                fontWeight: FontWeight.w600),
          ),
          elevation: 0,
        ),
        body: Column(children: [
          Column(children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFormField(
                autofocus: false,
                keyboardType: TextInputType.text,
                style:
                    const TextStyle(color: Color.fromRGBO(194, 194, 194, 100)),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search_outlined,
                      color: Color.fromRGBO(194, 194, 194, 100)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  hintText: "Search songs",
                  filled: true,
                  contentPadding: const EdgeInsets.all(16),
                  fillColor: const Color.fromRGBO(51, 36, 36, 100),
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
                                    Asamp()
                                        .oppenAsset(index: index, audios: song);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Play(
                                                index: index,
                                                song: song,
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
                                        style: const TextStyle(
                                            color: Color.fromRGBO(
                                                194, 194, 194, 100),
                                            fontSize: 20)),
                                    subtitle: Text(
                                        searchResult[index].artist ?? "Unknown",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            color: Color.fromRGBO(
                                                194, 194, 194, 100),
                                            fontSize: 15)),
                                    trailing: Padding(
                                      padding: const EdgeInsets.only(right: 0),
                                      child: PopupMenuButton<String>(
                                        color: Colors.white70,
                                        icon: const FaIcon(
                                            FontAwesomeIcons.ellipsisV,
                                            color: Color.fromRGBO(
                                                194, 194, 194, 100)),
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
                                  ));
                            });
                          }),
                    )
                  : const Padding(
                      padding: EdgeInsets.all(10),
                      child: Text("Nothing!",
                          style: TextStyle(
                              color: Color.fromRGBO(194, 194, 194, 100),
                              fontSize: 20)),
                    )
              : const SizedBox()
        ]));
  }
}
