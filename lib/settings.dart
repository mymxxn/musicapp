import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool value = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(25, 20, 20, 100),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(25, 20, 20, 100),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
          color: const Color.fromRGBO(194, 194, 194, 100),
        ),
        title: const Text(
          "Settings",
          style: TextStyle(
              color: Color.fromRGBO(194, 194, 194, 100),
              fontSize: 30,
              fontWeight: FontWeight.w600),
        ),
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              ListTile(
                leading: IconButton(
                  icon: const Icon(Icons.notifications_none_outlined,
                      color: Color.fromRGBO(194, 194, 194, 100)),
                  onPressed: () => Navigator.pop(context),
                ),
                title: const Text(
                  "Notification",
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
                trailing: Switch(
                  value: value,
                  onChanged: (val) {},
                  activeTrackColor: const Color.fromRGBO(194, 194, 194, 100),
                  activeColor: const Color.fromRGBO(194, 194, 194, 100),
                ),
              ),
              sett("Share", Icons.share_outlined),
              sett("Privacy and Policy", Icons.lock_outline),
              sett("Terms and Conditions", Icons.list_alt_outlined),
              sett("About", Icons.info_outline)
            ],
          ),
          bottom(),
        ],
      ),
    );
  }

  Widget sett(text, icon) {
    return ListTile(
      leading: IconButton(
        icon: Icon(icon, color: Color.fromRGBO(194, 194, 194, 100)),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        text,
        style: TextStyle(
            color: Colors.grey, fontSize: 18, fontWeight: FontWeight.w500),
      ),
    );
  }
}

Widget bottom() => Column(
      children: [
        const Text(
          "Version",
          style: TextStyle(
              color: Color.fromRGBO(194, 194, 194, 100), fontSize: 20),
        ),
        const Text(
          "1.0.0",
          style: TextStyle(
            color: Color.fromRGBO(194, 194, 194, 100),
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 20,
        )
      ],
    );
