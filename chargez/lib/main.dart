import 'package:battery_info/battery_info_plugin.dart';
import 'package:battery_info/model/iso_battery_info.dart';
import 'package:flutter/material.dart';
import 'package:battery_info/battery_info_plugin.dart';
import 'package:battery_info/enums/charging_status.dart';
import 'package:battery_info/model/android_battery_info.dart';
import 'package:battery_info/model/iso_battery_info.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Color.fromRGBO(99, 215, 135, 1),
        body: Column(children: [
          SizedBox(
            height: height * 0.1,
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
                            height: 120,
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
                                                    fontSize: 13),
                                              ),
                                              Text(
                                                snapshot.data!.health
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Real capacity",
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 13),
                                              ),
                                              Text(
                                                snapshot.data!.batteryCapacity
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              )
                                            ],
                                          )
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
                  height: 30,
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
                                        width: 140,
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
                                                  child: Image.asset(
                                                    "assets/chargingIcon.png",
                                                    scale: 14,
                                                  ))
                                            ],
                                          ),
                                        )),
                                    SizedBox(
                                      height: 30,
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
                                        width: 140,
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
                                  width: 50,
                                ),
                                Container(
                                    width: 140,
                                    height: 245,
                                    child: Card(
                                      elevation: 5,
                                      clipBehavior: Clip.hardEdge,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(16.0))),
                                      child: WaveWidget(
                                        config: CustomConfig(
                                          gradients: [
                                            [Colors.red, Color(0xEEF44336)],
                                            [Colors.orange, Color(0x66FF9800)],
                                            [Colors.yellow, Color(0x55FFEB3B)]
                                          ],
                                          durations: [35000, 10800, 6000],
                                          heightPercentages: [0.20, 0.25, 0.30],
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
                                    )),
                                Spacer(
                                  flex: 1,
                                )
                              ],
                            )
                          ],
                        );
                      }
                      return Container();
                    }),
              ]))
        ]));
  }
}
