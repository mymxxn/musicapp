import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:music/muix.dart';
import 'package:music/settings.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(25, 20, 20, 100),
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(25, 20, 20, 100),
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
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              keyboardType: TextInputType.text,
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
            ),
          ),
          ListTile(
            leading: Image.asset(
              'assets/images/6.jpg',
              width: 62,
              height: 85,
              scale: 0.8,
            ),
            title: const Text(
              "Fly To My Room",
              style: TextStyle(
                  color: Color.fromRGBO(194, 194, 194, 100), fontSize: 20),
            ),
            subtitle: const Text(
              "BTS",
              style: TextStyle(
                  color: Color.fromRGBO(194, 194, 194, 100), fontSize: 15),
            ),
            trailing: const FaIcon(FontAwesomeIcons.ellipsisV,
                color: Color.fromRGBO(194, 194, 194, 100)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Play()),
              );
            },
          ),
          ListTile(
            leading: Image.asset(
              'assets/images/7.jpg',
              width: 62,
              height: 85,
              scale: 0.8,
            ),
            title: const Text(
              "Wasabi",
              style: TextStyle(
                  color: Color.fromRGBO(194, 194, 194, 100), fontSize: 20),
            ),
            subtitle: const Text(
              "Little Mix",
              style: TextStyle(
                  color: Color.fromRGBO(194, 194, 194, 100), fontSize: 15),
            ),
            trailing: const FaIcon(FontAwesomeIcons.ellipsisV,
                color: Color.fromRGBO(194, 194, 194, 100)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Play()),
              );
            },
          ),
          ListTile(
            leading: Image.asset(
              'assets/images/8.jpg',
              width: 62,
              height: 85,
              scale: 0.8,
            ),
            title: const Text(
              "Sweet Night",
              style: TextStyle(
                  color: Color.fromRGBO(194, 194, 194, 100), fontSize: 20),
            ),
            subtitle: const Text(
              "V",
              style: TextStyle(
                  color: Color.fromRGBO(194, 194, 194, 100), fontSize: 15),
            ),
            trailing: const FaIcon(FontAwesomeIcons.ellipsisV,
                color: Color.fromRGBO(194, 194, 194, 100)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Play()),
              );
            },
          ),
        ]));
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
