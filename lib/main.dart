import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sensors_plus/sensors_plus.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        backgroundColor: const Color(0xfff1f5ff),
        appBar: AppBar(
          title: const Text('Moving Image App'),
        ),
        body: const Center(
            child: Stack(
          children: [
            // Positioned(
            //   left: -5,
            //   top: -5,
            //   child: Padding(
            //     padding: EdgeInsets.only(
            //         top: MediaQuery.of(context).size.width * 0.075,
            //         left: MediaQuery.of(context).size.width * 0.075),
            //     child: Container(
            //       height: MediaQuery.of(context).size.width * 1.08,
            //       width: MediaQuery.of(context).size.width * 0.68,
            //       decoration: BoxDecoration(
            //         boxShadow: [
            //           BoxShadow(
            //             color: Colors.black.withOpacity(0.2),
            //             spreadRadius: 5,
            //             blurRadius: 10,
            //             offset: const Offset(3, 8),
            //           ),
            //         ],
            //         borderRadius: BorderRadius.circular(10),
            //       ),
            //     ),
            //   ),
            // ),
            MovingShadowWidget(),

            MovingImageWidget(),
          ],
        )),
      ),
    );
  }
}

class MovingImageWidget extends StatefulWidget {
  const MovingImageWidget({super.key});

  @override
  _MovingImageWidgetState createState() => _MovingImageWidgetState();
}

class _MovingImageWidgetState extends State<MovingImageWidget> {
  double x = 0;
  double y = 0;

  Future<bool> isGyroscopeAvailable() async {
    try {
      bool isAvailable = false;
      await gyroscopeEvents.first.then((event) {
        isAvailable = true;
      }).catchError((error) {
        isAvailable = false;
      });
      return isAvailable;
    } catch (e) {
      // Handle any errors that may occur while checking sensor availability.
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    doFunc();
  }

  void doFunc() async {
    // accelerometerEvents.listen((AccelerometerEvent event)
    if (await isGyroscopeAvailable()) {
      gyroscopeEvents.listen((GyroscopeEvent event) {
        setState(() {
          x += event.y * 3;

          y += event.x * 3;

          x = x.clamp(0, MediaQuery.of(context).size.width * 0.095);
          y = y.clamp(0, MediaQuery.of(context).size.height * 0.035);
        });
        log("x $x");
        log("y $y");
      });
    } else {
      accelerometerEvents.listen((AccelerometerEvent event) {
        setState(() {
          x += event.x * (0.5);

          y -= event.y * (0.5);

          x = x.clamp(0, MediaQuery.of(context).size.width * 0.085);
          y = y.clamp(0, MediaQuery.of(context).size.height * 0.025);
        });
        log("x $x");
        log("y $y");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.width * 1.2,
              width: MediaQuery.of(context).size.width * 0.8,
              child: Container(
                color: Colors.transparent,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      left: x,
                      top: y,
                      child: Container(
                        height: MediaQuery.of(context).size.width * 1.1,
                        width: MediaQuery.of(context).size.width * 0.7,
                        decoration: BoxDecoration(
                          color: const Color(0xffeff3fe),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  'assets/02.png',
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Image.asset(
                              'assets/qrcode.jpg',
                              height: 100,
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        const Text("9 مساء:"),
                                        Text(
                                          "الوقت",
                                          style: GoogleFonts.ibmPlexSansArabic(
                                            textStyle: const TextStyle(
                                                letterSpacing: .5,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        const Text("227:"),
                                        Text(
                                          "رقم المقعد",
                                          style: GoogleFonts.ibmPlexSansArabic(
                                            textStyle: const TextStyle(
                                                letterSpacing: .5,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        const Text("227:"),
                                        Text(
                                          "رقم التذكرة",
                                          style: GoogleFonts.ibmPlexSansArabic(
                                            textStyle: const TextStyle(
                                                letterSpacing: .5,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        const Text("05:"),
                                        Text(
                                          "رقم البوابة",
                                          style: GoogleFonts.ibmPlexSansArabic(
                                            textStyle: const TextStyle(
                                                letterSpacing: .5,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 80,
        ),
        // Text("x $x"),
        // Text("y $y"),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xff5735d4),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
          ),
          child: Text(
            "   قم المقعد   ",
            style: GoogleFonts.ibmPlexSansArabic(
              textStyle: const TextStyle(
                letterSpacing: .5,
                color: Colors.white,
              ),
            ),
          ),
        )
      ],
    );
  }
}

class MovingShadowWidget extends StatefulWidget {
  const MovingShadowWidget({super.key});

  @override
  _MovingShadowWidgetState createState() => _MovingShadowWidgetState();
}

class _MovingShadowWidgetState extends State<MovingShadowWidget> {
  double x = 0;
  double y = 0;

  Future<bool> isGyroscopeAvailable() async {
    try {
      bool isAvailable = false;
      await gyroscopeEvents.first.then((event) {
        isAvailable = true;
      }).catchError((error) {
        isAvailable = false;
      });
      return isAvailable;
    } catch (e) {
      // Handle any errors that may occur while checking sensor availability.
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    doFunc();
  }

  void doFunc() async {
    // accelerometerEvents.listen((AccelerometerEvent event)
    if (await isGyroscopeAvailable()) {
      gyroscopeEvents.listen((GyroscopeEvent event) {
        // setState(() {
        x -= event.y * 5;

        y -= event.x * 5;

        x = x.clamp(0, MediaQuery.of(context).size.width * 0.085);
        y = y.clamp(0, MediaQuery.of(context).size.height * 0.025);
        // });
        log("x $x");
        log("y $y");
      });
    } else {
      accelerometerEvents.listen((AccelerometerEvent event) {
        // setState(() {
        x += event.x * (0.5);

        y -= event.y * (0.5);

        x = x.clamp(0, MediaQuery.of(context).size.width * 0.08);
        y = y.clamp(0, MediaQuery.of(context).size.height * 0.02);
      });
      log("x $x");
      log("y $y");
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.08,
            ),
            // Stack(
            //   children: [
            //     Positioned(
            //       left: x,
            //       top: y,
            //       child:
            Container(
              height: MediaQuery.of(context).size.width * 0.950,
              width: MediaQuery.of(context).size.width * 0.55,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color(0xffdc44e8).withOpacity(0.1),
                  Color(0xff3242e9).withOpacity(0.1)
                ]),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xffdc44e8).withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 14,
                    offset: const Offset(3, 8),
                  ),
                  BoxShadow(
                    color: Color(0xff3242e9).withOpacity(0.5),
                    spreadRadius: 15,
                    blurRadius: 14,
                    offset: const Offset(3, 8),
                  ),
                ],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            //     ),
            //   ],
            // )
          ],
        ),
      ],
    );
  }
}
