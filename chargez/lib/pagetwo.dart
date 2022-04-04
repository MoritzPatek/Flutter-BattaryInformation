import 'dart:math';

import 'package:battery_info/battery_info_plugin.dart';
import 'package:battery_info/model/android_battery_info.dart';
import 'package:chargez/settings.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class PageTwo extends StatefulWidget {
  const PageTwo({Key? key}) : super(key: key);

  @override
  State<PageTwo> createState() => _PageTwoState();
}

class _PageTwoState extends State<PageTwo> {
  BannerAd? banner;
  bool isLoaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    banner = BannerAd(
        size: AdSize.banner,
        adUnitId: "ca-app-pub-3940256099942544/6300978111",
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
              IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Settings()),
                    );
                  },
                  icon: Icon(Icons.settings, color: Colors.white)),
              Padding(
                padding: EdgeInsets.only(left: 100),
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
                                            "Has Battery",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 11),
                                          ),
                                          Text(
                                            snapshot.data!.present.toString(),
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
                                                Icons.question_mark_sharp,
                                                color: Colors.red[600],
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
                                            "Voltage",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 11),
                                          ),
                                          Text(
                                            snapshot.data!.voltage.toString() +
                                                " mV",
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
                                                Icons.bolt_rounded,
                                                color: Colors.yellow,
                                              ))
                                        ],
                                      ),
                                    )),
                                Spacer(
                                  flex: 1,
                                )
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                                width: width * 0.8,
                                height: 105,
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
                                            Color.fromRGBO(119, 239, 255, 1),
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
                                            Spacer(
                                              flex: 1,
                                            ),
                                            Text(
                                              "current mAh level in battery",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey[700]),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Padding(
                                                padding:
                                                    EdgeInsets.only(bottom: 20),
                                                child: Row(children: [
                                                  Spacer(
                                                    flex: 1,
                                                  ),
                                                  Text(
                                                    "cur. mAh Level: ",
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color:
                                                            Colors.grey[800]),
                                                  ),
                                                  Text(
                                                    "${(snapshot.data!.batteryCapacity! / 1000).toString().substring(0, (snapshot.data!.batteryCapacity! / 1000).toString().indexOf('.'))} mAh",
                                                    style: TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                  Spacer(
                                                    flex: 1,
                                                  )
                                                ]))
                                          ]))),
                                ])),
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
                                            "Remaining Energy:",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 11),
                                          ),
                                          Text(
                                            "${(-(snapshot.data!.remainingEnergy! * 1.0E-9)).toString().substring(0, 4)} Watt-hours",
                                            style: TextStyle(
                                                fontSize: 14,
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
                                            "Current now",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 11),
                                          ),
                                          Text(
                                            (snapshot.data!.currentNow! /
                                                        1000000)
                                                    .toString() +
                                                "A",
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
                              height: 145,
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
                                          color: Colors.black,
                                          size: 30,
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
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
                                          color:
                                              Color.fromRGBO(119, 255, 171, 1),
                                          size: 30,
                                        ),
                                        onPressed: null,
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
