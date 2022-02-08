import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PlayOne extends StatefulWidget {
  const PlayOne({Key? key}) : super(key: key);

  @override
  _PlayOneState createState() => _PlayOneState();
}

class _PlayOneState extends State<PlayOne> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(25, 20, 20, 100),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
          color: const Color.fromRGBO(194, 194, 194, 100),
        ),
        title: const Text(
          "BTS",
          style: TextStyle(
              color: Color.fromRGBO(194, 194, 194, 100),
              fontSize: 30,
              fontWeight: FontWeight.w600),
        ),
        elevation: 0,
      ),
      body: ListView(
        children: [
          songs('assets/images/3.jpg', "SOMEONES SOMEONE", "Monsta X"),
          songs('assets/images/4.jpg', "FEVER", "ENHYPEN"),
          songs('assets/images/5.jpg', "X", "Jonas Brothers, KAROL G"),
          songs('assets/images/6.jpg', "Fly To My Room", "BTS")
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Container(
          //     height: 42,
          //     width: 56,
          //     decoration: BoxDecoration(
          //       color: Color.fromRGBO(51, 36, 36, 100),
          //       borderRadius: BorderRadius.circular(40),
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }

  Widget songs(img, String song, String arist) {
    return ListTile(
      leading: Image.asset(
        img,
        width: 62,
        height: 85,
        scale: 0.8,
      ),
      title: Text(
        song,
        style:
            const TextStyle(color: Color.fromRGBO(194, 194, 194, 100), fontSize: 20),
      ),
      subtitle: Text(
        arist,
        style:
            const TextStyle(color: Color.fromRGBO(194, 194, 194, 100), fontSize: 15),
      ),
      trailing: const FaIcon(FontAwesomeIcons.ellipsisV,
          color: Color.fromRGBO(194, 194, 194, 100)),
      onTap: () {
        
      },
    );
  }
}
