import 'dart:ui';
import 'package:flutter/material.dart';

class Play extends StatefulWidget {
  const Play({Key? key}) : super(key: key);

  @override
  _PlayState createState() => _PlayState();
}

class _PlayState extends State<Play> {
  int _value = 6;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          splashColor: const Color.fromRGBO(25, 20, 20, 50),
          child: Ink(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: ExactAssetImage('assets/images/play.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
              child: Container(
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.1)),
              ),
            ),
          ),
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 36),
              child: Container(
                height: 358,
                width: 278,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(0),
                  child: Image.asset('assets/images/play.jpg'),
                ),
              ),
            ),
            // Text(
            //   "Winter Bear ",
            //   style: TextStyle(
            //       color: Color.fromRGBO(194, 194, 194, 100), fontSize: 28),
            // ),
            // Text(
            //   "V",
            //   style: TextStyle(
            //       color: Color.fromRGBO(194, 194, 194, 100), fontSize: 20),
            // ),
            // Slider(
            //   value: _value.toDouble(),
            //   min: 1.0,
            //   max: 20.0,
            //   divisions: 10,
            //   activeColor: Color.fromRGBO(25, 20, 20, 100),
            //   inactiveColor: Color.fromRGBO(25, 20, 20, 20),
            //   onChanged: (double newValue) {
            //     setState(() {
            //       _value = newValue.round();
            //     });
            //   },
            // ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 100),
            //   child: Row(
            //     children: [
            //       Icon(
            //         Icons.skip_previous_sharp,
            //         size: 40,
            //       ),
            //       SizedBox(
            //         width: 15,
            //       ),
            //       Icon(
            //         Icons.play_arrow,
            //         size: 40,
            //       ),
            //       SizedBox(
            //         width: 15,
            //       ),
            //       Icon(
            //         Icons.skip_next_sharp,
            //         size: 40,
            //       )
            //     ],
            //   ),
            // )
            Container(
              height: 164,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Winter Bear ",
                      style: TextStyle(
                          color: Color.fromRGBO(194, 194, 194, 100),
                          fontSize: 28),
                    ),
                    Text(
                      "V",
                      style: TextStyle(
                          color: Color.fromRGBO(194, 194, 194, 100),
                          fontSize: 20),
                    ),
                    Slider(
                      value: _value.toDouble(),
                      min: 0.0,
                      max: 20.0,
                      activeColor: Color.fromRGBO(25, 20, 20, 100),
                      inactiveColor: Color.fromRGBO(25, 20, 20, 20),
                      onChanged: (double newValue) {
                        setState(() {
                          _value = newValue.round();
                        });
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 90),
                      child: Row(
                        children: [
                          Icon(
                            Icons.skip_previous_sharp,
                            size: 40,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Icon(
                            Icons.play_arrow,
                            size: 40,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Icon(
                            Icons.skip_next_sharp,
                            size: 40,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        )
      ]),
    );
  }
}
