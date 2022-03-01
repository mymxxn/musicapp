import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:music/database/box.dart';
import 'package:music/database/model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music/theme/maintheme.dart';

String boxes = "audios";
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(AudioModelAdapter());



  await Hive.openBox<List<dynamic>>(boxes);



  final box = Boxy.getInstance();


  List<dynamic> liberarykeys = box.keys.toList();
  if (!liberarykeys.contains("Liked Songs")) {
    List<AudioModel> likedSongs = [];
    await box.put("Liked Songs", likedSongs);
  }
  // await OnAudioRoom().initRoom();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
          backgroundColor: Colors.black,
          duration: 3000,
          splash: Image.asset(
            "assets/images/logo.png",
          ),
          splashIconSize: double.infinity,
          splashTransition: SplashTransition.fadeTransition,
          nextScreen: const MyHomePage())));
}
