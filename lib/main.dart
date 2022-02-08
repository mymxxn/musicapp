import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:music/database/model.dart';
import 'package:music/home.dart';
import 'package:music/playlist.dart';
import 'package:music/search.dart';
import 'package:hive_flutter/hive_flutter.dart';

String boxes = "audios";
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(AudioModelAdapter());
  await Hive.openBox<List<AudioModel>>(boxes);
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
          backgroundColor: Colors.black,
          
          duration: 3000,
          splash: Image.asset(
            "assets/images/logo.png",
          ),splashIconSize: double.infinity,
          splashTransition: SplashTransition.fadeTransition,
          nextScreen: const MusicApp())));
}

class MusicApp extends StatefulWidget {
  const MusicApp({Key? key}) : super(key: key);

  @override
  State<MusicApp> createState() => _MusicAppState();
}

class _MusicAppState extends State<MusicApp> {
  int currentIndex = 0;

  final screens = [const Home(), const Search(), const Playlist()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(25, 20, 20, 100),
        body: screens[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: const Color.fromRGBO(65, 58, 54, 100),
          type: BottomNavigationBarType.fixed,
          selectedItemColor: const Color.fromRGBO(194, 194, 194, 100),
          iconSize: 28,
          currentIndex: currentIndex,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: (index) => setState(() => currentIndex = index),
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined), label: "data"),
            BottomNavigationBarItem(
                icon: Icon(Icons.search_outlined), label: "data"),
            BottomNavigationBarItem(
                icon: Icon(Icons.library_music_outlined), label: "data")
          ],
        ));
  }
}
