import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hamco/components/commonColor.dart';
import 'package:hamco/screen/bottomSheet/dispatchedBottom.dart';
import 'package:hamco/screen/received/deliveryListInfo.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../controller/controller.dart';

class ReceivedList extends StatefulWidget {
  String title;

  ReceivedList({required this.title});

  @override
  State<ReceivedList> createState() => _ReceivedListState();
}

class _ReceivedListState extends State<ReceivedList> {
  DispatchedInfoSheet info = DispatchedInfoSheet();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.title.toString(),
            style: TextStyle(fontSize: 17),
          ),
          backgroundColor: P_Settings.loginPagetheme,
        ),
        body: Consumer<Controller>(
          builder: (context, value, child) {
            if (value.isLoading) {
              return SpinKitCircle(
                color: P_Settings.loginPagetheme,
              );
            } else {
              if (value.dispatchedList.length == 0) {
                return Center(
                  child: Container(
                      height: size.height * 0.3,
                      child: Lottie.asset(
                        'asset/empty_box.json',
                        // height: size.height*0.3,
                        // width: size.height*0.3,
                      )),
                );
              } else {
                print("fjkhfkj");
                return ListView.builder(
                  itemCount: value.dispatchedList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: ListTile(
                          onTap: () {
                            Provider.of<Controller>(context, listen: false)
                                .getdispatchedListInfo(
                                    context,
                                    value.dispatchedList[index].osId
                                        .toString());

                            // info.showinfoSheet(
                            //   context,
                            //   size,
                            // );

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DeliveryListInfo(
                                        os_id: value.dispatchedList[index].osId
                                            .toString(),
                                      )),
                            );
                          },
                          trailing: Icon(Icons.arrow_forward),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Series : ",
                                    style: GoogleFonts.aBeeZee(
                                      textStyle:
                                          Theme.of(context).textTheme.bodyText2,
                                      fontSize: 16,
                                      // fontWeight: FontWeight.bold,
                                      color: P_Settings.loginPagetheme,
                                    ),
                                  ),
                                  Text(
                                    value.dispatchedList[index].series
                                        .toString(),
                                    style: GoogleFonts.aBeeZee(
                                      textStyle:
                                          Theme.of(context).textTheme.bodyText2,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: P_Settings.loginPagetheme,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Date : ${value.dispatchedList[index].entryDate.toString()}",
                                    style: GoogleFonts.aBeeZee(
                                      textStyle:
                                          Theme.of(context).textTheme.bodyText2,
                                      fontSize: 16,
                                      // fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          subtitle: Row(
                            children: [
                              Text(
                                "Branch : ",
                                style: GoogleFonts.aBeeZee(
                                  textStyle:
                                      Theme.of(context).textTheme.bodyText2,
                                  fontSize: 15,
                                  // fontWeight: FontWeight.bold,
                                  color: Colors.grey[700],
                                ),
                              ),
                              Flexible(
                                child: Text(
                                  value.dispatchedList[index].branchName
                                      .toString(),
                                  style: GoogleFonts.aBeeZee(
                                    textStyle:
                                        Theme.of(context).textTheme.bodyText2,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: P_Settings.loginPagetheme,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            }
          },
        ));
  }
}
