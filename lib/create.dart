import 'package:flutter/material.dart';

class CreatePlaylist extends StatefulWidget {
  const CreatePlaylist({Key? key}) : super(key: key);

  @override
  _CreatePlaylistState createState() => _CreatePlaylistState();
}

class _CreatePlaylistState extends State<CreatePlaylist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(25, 20, 20, 100),
        body: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 250),
              child: Center(
                child: Text(
                  "Give your playlist a name.",
                  style: TextStyle(
                      color: Color.fromRGBO(194, 194, 194, 100), fontSize: 28),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.only(right: 93, left: 93),
              child: TextField(
                decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromRGBO(194, 194, 194, 100)),
                    ),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromRGBO(194, 194, 194, 100)))),
                style: TextStyle(
                    color: Color.fromRGBO(194, 194, 194, 100), fontSize: 20),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
                child: const Text("Create",
                    style: TextStyle(
                        color: Color.fromRGBO(194, 194, 194, 0.5),
                        fontSize: 20)),
                style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color.fromRGBO(51, 36, 36, 100)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                            side: const BorderSide(
                                color: Color.fromRGBO(51, 36, 36, 100))))),
                onPressed: () {
                  Navigator.pop(context);
                }),
            TextButton(
                child: const Text(
                  "Cancel",
                  style: TextStyle(
                      color: Color.fromRGBO(194, 194, 194, 0.2), fontSize: 12),
                ),
                style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        const EdgeInsets.all(15)),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.red),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: const BorderSide(
                                color: Color.fromRGBO(51, 36, 36, 100),
                                width: 2)))),
                onPressed: () {
                  Navigator.pop(context);
                }),
          ],
        ));
  }
}
