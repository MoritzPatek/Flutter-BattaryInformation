import 'dart:math';

import 'package:battery_info/battery_info_plugin.dart';
import 'package:battery_info/model/iso_battery_info.dart';
import 'package:chargez/pagetwo.dart';
import 'package:chargez/settings.dart';
import 'package:flutter/material.dart';
import 'package:battery_info/battery_info_plugin.dart';
import 'package:battery_info/enums/charging_status.dart';
import 'package:battery_info/model/android_battery_info.dart';
import 'package:battery_info/model/iso_battery_info.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

void main() {
  runApp(const MyApp());
  MobileAds.instance.initialize();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ChargeZ',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  BannerAd? banner;
  bool isLoaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    banner = BannerAd(
        size: AdSize.banner,
        adUnitId: "ca-app-pub-1724779520900121/5509340762",
        listener: BannerAdListener(onAdLoaded: (ad) {
          setState(() {
            isLoaded = true;
          });
        }, onAdFailedToLoad: (ad, error) {
          ad.dispose();
        }),
        request: AdRequest());
    banner!.load();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Color.fromRGBO(99, 215, 135, 1),
        body: Column(children: [
          Container(
            height: height * 0.1,
            child: Row(children: [
              /*IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Settings()),
                    );
                  },
                  icon: Icon(Icons.settings, color: Colors.white)),*/
              Padding(
                padding: EdgeInsets.only(left: 120),
                child: Text(
                  "ChargeZ",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ]),
          ),
          Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(25),
                    topLeft: Radius.circular(25)),
              ),
              height: height * 0.90,
              width: width,
              child: Column(children: [
                SizedBox(
                  height: 30,
                ),
                FutureBuilder(
                    future: BatteryInfoPlugin().androidBatteryInfo,
                    builder:
                        (context, AsyncSnapshot<AndroidBatteryInfo?> snapshot) {
                      if (snapshot.hasData) {
                        return Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 8,
                                  offset: Offset(
                                      0, 1), // changes position of shadow
                                ),
                              ],
                            ),
                            width: width * 0.8,
                            height: 90,
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                    padding: EdgeInsets.only(left: 30, top: 14),
                                    child: Row(children: [
                                      Column(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Battery health",
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 14),
                                              ),
                                              Text(
                                                (snapshot.data!.health
                                                            .toString() ==
                                                        "heath_good")
                                                    ? "Good"
                                                    : snapshot.data!.health
                                                        .toString(),
                                                style: TextStyle(
                                                    fontSize: 30,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                      Spacer(
                                        flex: 1,
                                      ),
                                      Align(
                                          alignment: Alignment.topRight,
                                          child: Padding(
                                              padding:
                                                  EdgeInsets.only(right: 20),
                                              child: Icon(
                                                Icons.favorite_border_rounded,
                                                color: Colors.red,
                                              )))
                                    ]))));
                      }
                      return Container();
                    }),
                SizedBox(
                  height: 20,
                ),
                StreamBuilder<AndroidBatteryInfo?>(
                    stream: BatteryInfoPlugin().androidBatteryInfoStream,
                    builder:
                        (context, AsyncSnapshot<AndroidBatteryInfo?> snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Row(
                              children: [
                                Spacer(flex: 1),
                                Column(
                                  children: [
                                    Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.2),
                                              spreadRadius: 2,
                                              blurRadius: 4,
                                              offset: Offset(0,
                                                  5), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        width: 150,
                                        height: 105,
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              left: 20, top: 15),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Status",
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 11),
                                              ),
                                              Text(
                                                snapshot.data!.chargingStatus
                                                    .toString()
                                                    .substring(snapshot.data!
                                                            .chargingStatus
                                                            .toString()
                                                            .indexOf('.') +
                                                        1),
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              Spacer(
                                                flex: 1,
                                              ),
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: 20),
                                                  child: Icon(
                                                    Icons.bolt_rounded,
                                                    color: Colors.blue,
                                                  ))
                                            ],
                                          ),
                                        )),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.2),
                                              spreadRadius: 2,
                                              blurRadius: 4,
                                              offset: Offset(0,
                                                  5), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        width: 150,
                                        height: 105,
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              left: 20, top: 15),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Charging Type",
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 11),
                                              ),
                                              Text(
                                                (snapshot.data!.pluggedStatus
                                                            .toString() ==
                                                        "unknown")
                                                    ? "Not Charging"
                                                    : snapshot
                                                        .data!.pluggedStatus
                                                        .toString(),
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              Spacer(
                                                flex: 1,
                                              ),
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: 20),
                                                  child: Image.asset(
                                                    "assets/chargingIcon.png",
                                                    scale: 14,
                                                  ))
                                            ],
                                          ),
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  width: 30,
                                ),
                                Container(
                                    width: 150,
                                    height: 235,
                                    child: Stack(children: [
                                      Card(
                                        elevation: 5,
                                        clipBehavior: Clip.hardEdge,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(16.0))),
                                        child: WaveWidget(
                                          config: CustomConfig(
                                            gradients: [
                                              [
                                                Color.fromRGBO(
                                                    119, 255, 171, 1),
                                                Color.fromRGBO(93, 239, 150, 1)
                                              ],
                                            ],
                                            durations: [7800],
                                            heightPercentages: [0.30],
                                            blur: MaskFilter.blur(
                                                BlurStyle.solid, 10),
                                            gradientBegin: Alignment.bottomLeft,
                                            gradientEnd: Alignment.topRight,
                                          ),
                                          waveAmplitude: 0,
                                          size: Size(
                                            double.infinity,
                                            double.infinity,
                                          ),
                                        ),
                                      ),
                                      Align(
                                          alignment: Alignment.topCenter,
                                          child: Padding(
                                              padding: EdgeInsets.only(top: 20),
                                              child: Column(children: [
                                                Text(
                                                  "Battery Level",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.grey[700]),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                    snapshot.data!.batteryLevel
                                                            .toString() +
                                                        "%",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 30)),
                                                Spacer(
                                                  flex: 1,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: 30),
                                                  child: Text(
                                                    "${(snapshot.data!.batteryCapacity! / 1000).toString().substring(0, (snapshot.data!.batteryCapacity! / 1000).toString().indexOf('.'))} mAh",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                )
                                              ]))),
                                    ])),
                                Spacer(
                                  flex: 1,
                                )
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Spacer(
                                  flex: 1,
                                ),
                                Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(25),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          spreadRadius: 2,
                                          blurRadius: 4,
                                          offset: Offset(0,
                                              5), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    width: 150,
                                    height: 105,
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(left: 20, top: 15),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Battery Type",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 11),
                                          ),
                                          Text(
                                            snapshot.data!.technology
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Spacer(
                                            flex: 1,
                                          ),
                                          Padding(
                                              padding:
                                                  EdgeInsets.only(bottom: 20),
                                              child: Icon(
                                                Icons.settings_sharp,
                                                color: Colors.grey,
                                              ))
                                        ],
                                      ),
                                    )),
                                SizedBox(
                                  width: 30,
                                ),
                                Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(25),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          spreadRadius: 2,
                                          blurRadius: 4,
                                          offset: Offset(0,
                                              5), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    width: 150,
                                    height: 105,
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(left: 20, top: 15),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Temperature",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 11),
                                          ),
                                          Text(
                                            snapshot.data!.temperature
                                                    .toString() +
                                                "°C",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Spacer(
                                            flex: 1,
                                          ),
                                          Padding(
                                              padding:
                                                  EdgeInsets.only(bottom: 20),
                                              child: Icon(
                                                Icons.thermostat,
                                                color: Colors.red,
                                              ))
                                        ],
                                      ),
                                    )),
                                Spacer(
                                  flex: 1,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(25),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 3,
                                      blurRadius: 4,
                                      offset: Offset(
                                          0, 4), // changes position of shadow
                                    ),
                                  ],
                                ),
                                width: width * 0.5,
                                height: 70,
                                child: Row(
                                  children: [
                                    Spacer(
                                      flex: 3,
                                    ),
                                    Transform.rotate(
                                      angle: 90 * pi / 180,
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.battery_full_rounded,
                                          color:
                                              Color.fromRGBO(119, 255, 171, 1),
                                          size: 30,
                                        ),
                                        onPressed: () {},
                                      ),
                                    ),
                                    Spacer(
                                      flex: 2,
                                    ),
                                    Transform.rotate(
                                      angle: 90 * pi / 180,
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.apps_rounded,
                                          color: Colors.black,
                                          size: 30,
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const PageTwo()),
                                          );
                                        },
                                      ),
                                    ),
                                    Spacer(
                                      flex: 3,
                                    ),
                                  ],
                                )),
                            isLoaded
                                ? Container(
                                    height: 25,
                                    child: AdWidget(ad: banner!),
                                  )
                                : SizedBox()
                          ],
                        );
                      }
                      return Container();
                    }),
              ]))
        ]));
  }
}
