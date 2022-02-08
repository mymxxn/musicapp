import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:music/create.dart';
import 'package:music/liked.dart';
import 'package:music/playone.dart';
import 'package:music/playtwo.dart';

class Playlist extends StatefulWidget {
  const Playlist({Key? key}) : super(key: key);

  @override
  _PlaylistState createState() => _PlaylistState();
}

class _PlaylistState extends State<Playlist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text(
            "Playlist",
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
                  MaterialPageRoute(
                      builder: (context) => const CreatePlaylist()),
                );
              },
              icon: const FaIcon(FontAwesomeIcons.plus),
              color: const Color.fromRGBO(194, 194, 194, 100),
            )
          ],
          elevation: 0,
        ),
        backgroundColor: const Color.fromRGBO(25, 20, 20, 100),
        body: Column(
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
              title: const Text(
                "Liked Songs",
                style: TextStyle(
                    color: Color.fromRGBO(194, 194, 194, 100), fontSize: 20),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Liked()),
                );
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.playlist_play_rounded,
                size: 65,
                color: Color.fromRGBO(194, 194, 194, 100),
              ),
              title: const Text(
                "BTS",
                style: TextStyle(
                    color: Color.fromRGBO(194, 194, 194, 100), fontSize: 20),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PlayOne()),
                );
              },
              onLongPress: (){},
            ),
            ListTile(
              leading: const Icon(
                Icons.playlist_play_rounded,
                size: 65,
                color: Color.fromRGBO(194, 194, 194, 100),
              ),
              title: const Text(
                "Monsta",
                style: TextStyle(
                    color: Color.fromRGBO(194, 194, 194, 100), fontSize: 20),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PlayTwo()),
                );
              },
              onLongPress: () {},
            ),
          ],
        ));
  }
}

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
