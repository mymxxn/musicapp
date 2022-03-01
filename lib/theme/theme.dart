import 'package:flutter/material.dart';
import 'package:music/theme/themes.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangeThemeButtonWidget extends StatefulWidget {
  const ChangeThemeButtonWidget({Key? key}) : super(key: key);

  @override
  State<ChangeThemeButtonWidget> createState() =>
      _ChangeThemeButtonWidgetState();
}

class _ChangeThemeButtonWidgetState extends State<ChangeThemeButtonWidget> {
  bool them = true;
  @override
  void initState() {
    super.initState();
    getswitchva();
  }

  getswitchva() async {
    them = await getswitch();
    setState(() {});
  }

  Future<bool> saveswitc(bool value) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool("switch", value);
    return pref.setBool("switch", value);
  }

  Future<bool> getswitch() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool? val = pref.getBool("switch");
    return val ?? true;
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Switch.adaptive(
      activeTrackColor: const Color.fromRGBO(194, 194, 194, 100),
      activeColor: Theme.of(context).iconTheme.color,
      value: themeProvider.isDarkMode,
      onChanged: (bool value) {
        setState(() {
          them = value;
          saveswitc(value);
          final provider = Provider.of<ThemeProvider>(context, listen: false);
          provider.toggleTheme(value);
        });
      },
    );
  }
}
