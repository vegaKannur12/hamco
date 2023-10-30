import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hamco/components/commonColor.dart';
import 'package:hamco/controller/controller.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class DeliveryListInfo extends StatefulWidget {
  String os_id;

  DeliveryListInfo({
    required this.os_id,
  });

  @override
  State<DeliveryListInfo> createState() => _DeliveryListInfoState();
}

class _DeliveryListInfoState extends State<DeliveryListInfo> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        key: _scaffoldKey,
        bottomNavigationBar: BottomAppBar(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Container(
              height: size.height * 0.05,
              width: size.width * 0.5,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: P_Settings.loginPagetheme,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2), // <-- Radius
                  ),
                ),
                onPressed: () async {
                  if (Provider.of<Controller>(context, listen: false)
                          .dispatchedinfoList
                          .length >
                      0) {
                    return showDialog(
                        context: _scaffoldKey.currentContext!,
                        barrierDismissible: true,
                        builder: (BuildContext ctx) {
                          return new AlertDialog(
                            content: Text("Do you want to Approve ???"),
                            actions: <Widget>[
                              Consumer<Controller>(
                                builder: (context, value, child) {
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            primary: P_Settings.loginPagetheme),
                                        onPressed: () async {
                                          print("heloooooooooooooooo-----");
                                          Navigator.of(
                                                  _scaffoldKey.currentContext!)
                                              .pop();
                                          showDailogue(
                                              context, true, _keyLoader, 1);
                                          Provider.of<Controller>(context,
                                                  listen: false)
                                              .saveDeliveryApprovalList(
                                            _scaffoldKey.currentContext!,
                                            widget.os_id,
                                          );

                                          // Navigator.of(ctx).pop();
                                        },
                                        child: Text("Ok"),
                                      ),
                                      SizedBox(
                                        width: size.width * 0.01,
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            primary: P_Settings.loginPagetheme),
                                        onPressed: () {
                                          Navigator.of(
                                                  _scaffoldKey.currentContext!)
                                              .pop();
                                        },
                                        child: Text("Cancel"),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ],
                          );
                        });
                  }
                  // Provider.of<Controller>(context, listen: false).saveCartDetails(
                  //     context,
                  //     splitted[0],
                  //     selectedbranch.toString(),
                  //     remrk.text,
                  //     "0",
                  //     "0",
                  //     "save");
                },
                child: Text(
                  'Approve',
                  style: GoogleFonts.aBeeZee(
                    textStyle: Theme.of(context).textTheme.bodyText2,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: P_Settings.buttonColor,
                  ),
                ),
              ),
            ),
          ),
          elevation: 0,
        ),
        appBar: AppBar(
          backgroundColor: P_Settings.loginPagetheme,
        ),
        body: Consumer<Controller>(
          builder: (context, value, child) {
            print("fjkhfkj");
            if (value.isLoading) {
              return SpinKitCircle(
                color: P_Settings.loginPagetheme,
              );
            } else if (value.dispatchedinfoList.length == 0) {
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
              return ListView.builder(
                itemCount: value.dispatchedinfoList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: ListTile(
                        leading: Container(
                          // height: size.height*0.2,
                          // width: size.width*0.2,
                          child: CircleAvatar(
                            radius: 25,
                            backgroundImage: AssetImage(
                              'asset/noImg.png',
                            ),
                          ),
                        ),
                        title: Text(
                          value.dispatchedinfoList[index].item_name.toString(),
                          style: GoogleFonts.aBeeZee(
                            textStyle: Theme.of(context).textTheme.bodyText2,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: P_Settings.loginPagetheme,
                          ),
                        ),
                        subtitle: Text(
                          "Qty : ${value.dispatchedinfoList[index].qty.toString()}",
                          style: GoogleFonts.aBeeZee(
                            textStyle: Theme.of(context).textTheme.bodyText2,
                            fontSize: 16,
                            // fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                        // subtitle: Padding(
                        //   padding: const EdgeInsets.only(top: 8.0),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: [
                        //       Text(
                        //         "SRate1 : ${value.dispatchedinfoList[index].s_rate_1.toString()}",
                        //         style: GoogleFonts.aBeeZee(
                        //           textStyle:
                        //               Theme.of(context).textTheme.bodyText2,
                        //           fontSize: 16,
                        //           // fontWeight: FontWeight.bold,
                        //           color: P_Settings.loginPagetheme,
                        //         ),
                        //       ),
                        //       Text(
                        //         "SRate2 : ${value.dispatchedinfoList[index].s_rate_2.toString()}",
                        //         style: GoogleFonts.aBeeZee(
                        //           textStyle:
                        //               Theme.of(context).textTheme.bodyText2,
                        //           fontSize: 16,
                        //           // fontWeight: FontWeight.bold,
                        //           color: P_Settings.loginPagetheme,
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ));
  }
}

showDailogue(BuildContext context, bool isLoading, GlobalKey key, int content) {
  return showDialog(
      context: context,
      builder: (context) {
        Size size = MediaQuery.of(context).size;

        return new WillPopScope(
            onWillPop: () async => false,
            child: SimpleDialog(
                key: key,
                backgroundColor: Colors.white,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // SizedBox(
                          //   height: 10,
                          // ),
                          Text(
                            "Loading .... ",
                            style: TextStyle(color: Colors.black),
                          ),
                          CircularProgressIndicator(
                            color: Colors.green,
                          )
                        ]),
                  )
                ]));
      });
}
