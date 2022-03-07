import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:music/database/box.dart';
import 'package:music/database/model.dart';

class CreatePlaylist extends StatefulWidget {
  const CreatePlaylist({Key? key}) : super(key: key);

  @override
  _CreatePlaylistState createState() => _CreatePlaylistState();
}

class _CreatePlaylistState extends State<CreatePlaylist> {
  late TextEditingController controller;
  final excistingPlaylist = SnackBar(
    content: const Text(
      'Already exists!',
      style: TextStyle(color: Colors.white),
    ),
    backgroundColor: Colors.grey[900],
  );

  final box = Boxy.getInstance();
  String? playlist = '';
  List playlists = [];
  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).primaryColor,
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  "Give your playlist a name.",
                  style: TextStyle(
                      color: Theme.of(context).iconTheme.color, fontSize: 28),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 93, left: 93),
                child: TextField(
                  controller: controller,
                  autofocus: true,
                  decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Theme.of(context).splashColor),
                      ),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).splashColor))),
                  style: TextStyle(
                      color: Theme.of(context).primaryIconTheme.color,
                      fontSize: 20),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                  child: Text("Create",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor, fontSize: 20)),
                  style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(
                          Theme.of(context).splashColor),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Theme.of(context).splashColor),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(
                                  color: Theme.of(context).splashColor)))),
                  onPressed: () {
                    if (controller.text.isNotEmpty) {
                      submit(controller.text);
                    }
                  }),
              TextButton(
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                        color: Theme.of(context).primaryIconTheme.color,
                        fontSize: 12),
                  ),
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          const EdgeInsets.all(15)),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.red),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(
                                  color: Theme.of(context).splashColor,
                                  width: 2)))),
                  onPressed: () {
                    Navigator.pop(context);
                    Fluttertoast.showToast(
                        msg: 'Playlist created!',
                        textColor: Theme.of(context).primaryColor,
                        backgroundColor: Theme.of(context).splashColor);
                  }),
            ],
          ),
        ));
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  void submit(String text) {
    List<String> name = box.keys.toList().cast();
    print(name);
    List<AudioModel> library = [];
    if (name.isNotEmpty) {
      final existingName = name
          .where((element) =>
              element.toLowerCase().toString() == text.toLowerCase().toString())
          .toList()
          .isNotEmpty;
      print(existingName);
      if (!existingName) {
        box.put(text, library);
        Navigator.of(context).pop();
        setState(() {});
      } else {
        ScaffoldMessenger.of(context).showSnackBar(excistingPlaylist);
      }
    }

    controller.clear();
  }
}
