import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:music/database/box.dart';

class EditPlaylist extends StatefulWidget {
  EditPlaylist({Key? key, required this.playlistName}) : super(key: key);
  final String playlistName;

  @override
  State<EditPlaylist> createState() => _EditPlaylistState();
}

class _EditPlaylistState extends State<EditPlaylist> {
  EdgeInsets _viewInsets = EdgeInsets.zero;
  SingletonFlutterWindow? window;
  @override
  void initState() {
    super.initState();
    window = WidgetsBinding.instance?.window;
    window?.onMetricsChanged = () {
      setState(() {
        final window = this.window;
        if (window != null) {
          _viewInsets = EdgeInsets.fromWindowPadding(
            window.viewInsets,
            window.devicePixelRatio,
          ).add(EdgeInsets.fromWindowPadding(
            window.padding,
            window.devicePixelRatio,
          )) as EdgeInsets;
        }
      });
    };
  }

  final box = Boxy.getInstance();

  String? _title;

  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).primaryColor,
      insetPadding: const EdgeInsets.only(bottom: 300),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      //  Border.all(color: Theme.of(context).primaryColor, width: 1,),
      content: Padding(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom, top: 30),
        child: Column(
          children: [
            Text(
              "Edit your Playlist",
              style: TextStyle(color: Theme.of(context).iconTheme.color),
            ),
            Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Form(
                  key: _formkey,
                  child: TextFormField(
                    initialValue: widget.playlistName,
                    decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Theme.of(context).cardColor)),
                        disabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Theme.of(context).cardColor)),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).cardColor))),
                    onChanged: (value) {
                      _title = value;
                    },
                    validator: (value) {
                      List keys = box.keys.toList();
                      if (value == "") {
                        return "Enter a Name!";
                      }
                      if (keys
                          .where((element) => element == value)
                          .isNotEmpty) {
                        return 'Already Exists!';
                      }
                    },
                  )),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () {
                      if (_formkey.currentState!.validate()) {
                        List? playlists = box.get(widget.playlistName);
                        box.put(_title, playlists!);
                        box.delete(widget.playlistName);
                        Navigator.pop(context);
                      }
                    },
                    child: Text(
                      "Update",
                      style: TextStyle(color: Theme.of(context).cardColor),
                    )),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Cancel",
                      style: TextStyle(color: Theme.of(context).cardColor),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
