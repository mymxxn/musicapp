import 'package:flutter/material.dart';
import 'package:music/Pages/home.dart';
import 'package:music/Pages/liberary.dart';
import 'package:music/Pages/playlist.dart';
import 'package:music/Pages/search.dart';

class MusicApp extends StatefulWidget {
  const MusicApp({Key? key}) : super(key: key);

  @override
  State<MusicApp> createState() => _MusicAppState();
}

class _MusicAppState extends State<MusicApp> {
  int currentIndex = 0;

  final screens = [const Home(), const Search(), const Playlist()];
  // MenuItem currentItem = MenuItems.home;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Theme.of(context).primaryColor,
        body: screens[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Theme.of(context).primaryColor,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Theme.of(context).iconTheme.color,
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
