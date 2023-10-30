import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hamco/components/commonColor.dart';
import 'package:provider/provider.dart';

import '../../controller/controller.dart';

class CustomStepper extends StatelessWidget {
  String reqId;
  CustomStepper({required this.reqId});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Text(
                "Track Order - ",
                style: TextStyle(fontSize: 17),
              ),
              Text(
                reqId,
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              )
            ],
          ),
          backgroundColor: P_Settings.loginPagetheme,
        ),
        body: SingleChildScrollView(
          child: Consumer<Controller>(
            builder: (context, value, child) {
              if (value.isStatusLoad) {
                return Container(
                  height: size.height * 0.8,
                  child: SpinKitCircle(
                    color: P_Settings.loginPagetheme,
                  ),
                );
              } else {
                return Container(
                  // height: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 25.0,
                      top: 18,
                    ),
                    child: Column(
                        children: value.statusList.map((e) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 8, right: 5),
                                height: 18,
                                width: 18,
                                decoration: BoxDecoration(
                                    color: e["privilage"] == "7"
                                        ? Colors.green
                                        : Color.fromARGB(255, 202, 67, 57),
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Colors.black)),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(e["title"],
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17)),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Text(e["content"],
                                          // "sfhdhsfjkhfkjfkjsfkjjmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm",
                                          // overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey[500],
                                              fontSize: 15)),
                                    ),
                                  ],
                                ),
                              )
                              // Expanded(
                              //   child: ListTile(
                              //     title: Text(e["title"],
                              //         style:
                              //             TextStyle(fontWeight: FontWeight.bold)),
                              //     subtitle: Text("12/23/2023"),
                              //   ),
                              // ),
                            ],
                          ),
                          e["privilage"] == "7"
                              ? Container()
                              : Container(
                                  margin: const EdgeInsets.only(left: 17),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 14, vertical: 40),
                                  decoration: const BoxDecoration(
                                      border: Border(
                                          left: BorderSide(
                                    color: Colors.red,
                                  ))),
                                  // child: Text(e["content"]
                                  // ),
                                ),
                        ],
                      );
                    }).toList()),
                  ),
                );
              }
            },
          ),
        ));
  }
}
