import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music/theme/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final audioplayer = AssetsAudioPlayer();
  bool notify = true;
  final barnotify = const SnackBar(
      content: Text(
    "Restart the App!",
    style: TextStyle(color: Color.fromRGBO(194, 194, 194, 100)),
  ));
  @override
  void initState() {
    super.initState();
    getswitchval();
  }

  getswitchval() async {
    notify = await getswitch();
    setState(() {});
  }

  Future<bool> saveswitch(bool value) async {
    SharedPreferences prefere = await SharedPreferences.getInstance();
    prefere.setBool("switchState", value);
    return prefere.setBool("switchState", value);
  }

  Future<bool> getswitch() async {
    SharedPreferences prefere = await SharedPreferences.getInstance();
    bool? val = prefere.getBool("switchState");
    return val ?? true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).iconTheme.color,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const FaIcon(FontAwesomeIcons.moon),
            color: Theme.of(context).primaryIconTheme.color,
            iconSize: 18,
          ),
          const ChangeThemeButtonWidget(),
        ],
        backgroundColor: Colors.transparent,
        title: Text(
          "Settings",
          style: GoogleFonts.elMessiri(
              textStyle: TextStyle(
            color: Theme.of(context).iconTheme.color,
            fontSize: 30,
            fontWeight: FontWeight.w700,
          )),
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
                  icon: Icon(Icons.notifications_none_outlined,
                      color: Theme.of(context).iconTheme.color),
                  onPressed: () => Navigator.pop(context),
                ),
                title: Text(
                  "Notification",
                  style: TextStyle(
                      color: Theme.of(context).primaryIconTheme.color,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
                trailing: Switch(
                  value: notify,
                  onChanged: (bool value) {
                    setState(() {
                      notify = value;
                      saveswitch(value);
                      if (notify == true) {
                        ScaffoldMessenger.of(context).showSnackBar(barnotify);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(barnotify);
                      }
                    });
                  },
                  activeTrackColor: const Color.fromRGBO(194, 194, 194, 100),
                  activeColor: Theme.of(context).iconTheme.color,
                ),
              ),
              sett("Share", Icons.share_outlined),
              sett("Privacy and Policy", Icons.lock_outline),
              sett("Terms and Conditions", Icons.list_alt_outlined),
              ListTile(
                leading: IconButton(
                  icon: Icon(Icons.info_outline,
                      color: Theme.of(context).iconTheme.color),
                  onPressed: () => Navigator.pop(context),
                ),
                title: Text(
                  "About",
                  style: TextStyle(
                      color: Theme.of(context).primaryIconTheme.color,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
                onTap: () {
                  showAboutDialog(
                    context: context,
                    applicationName: 'Audio Disc',
                    applicationIcon: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: const Image(
                        height: 50,
                        image: AssetImage("assets/images/logo.png"),
                      ),
                    ),
                    applicationVersion: '1.0.0',
                    children: [
                      const Text('Offline music player'),
                    ],
                  );
                },
              )
            ],
          ),
          const SizedBox(
            height: 250,
          ),
          bottom(),
        ],
      ),
    );
  }

  Widget sett(text, icon) {
    return ListTile(
      leading: IconButton(
        icon: Icon(icon, color: Theme.of(context).iconTheme.color),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        text,
        style: TextStyle(
            color: Theme.of(context).primaryIconTheme.color,
            fontSize: 18,
            fontWeight: FontWeight.w500),
      ),
    );
  }
}

Widget bottom() => Column(
      children: const [
        Text(
          "Version",
          style: TextStyle(
              color: Color.fromRGBO(194, 194, 194, 100), fontSize: 20),
        ),
        Text(
          "1.0.0",
          style: TextStyle(
            color: Color.fromRGBO(194, 194, 194, 100),
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
