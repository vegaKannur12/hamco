import 'dart:io';

// import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hamco/components/commonColor.dart';
import 'package:hamco/controller/controller.dart';
import 'package:hamco/screen/login&registration/login.dart';
import 'package:hamco/screen/received/receivedList.dart';
import 'package:hamco/screen/return/stockReturn.dart';
import 'package:hamco/screen/search/searchScreen.dart';
import 'package:hamco/screen/status%20monitoring/status_mon.dart';
import 'package:badges/badges.dart' as badges;

import 'package:hamco/screen/stock%20Request/stockFrstPage.dart';
import 'package:hamco/screen/stock%20Request/stockRequest.dart';
import 'package:hamco/screen/stock%20report/stockReport.dart';
import 'package:hamco/screen/stock%20report/stockReportList.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../status monitoring/custom_stepper.dart';

class MainDashboard extends StatefulWidget {
  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  String? branch_id;
  String? staff_name;
  String? branch_name;
  String? branch_prefix;
  String? user_id;
  String? todaydate;

  shared() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    branch_id = prefs.getString("branch_id");
    staff_name = prefs.getString("staff_name");
    branch_name = prefs.getString("branch_name");
    branch_prefix = prefs.getString("branch_prefix");
    user_id = prefs.getString("user_id");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    shared();

    Provider.of<Controller>(context, listen: false).userDetails();
    Provider.of<Controller>(context, listen: false).getDeliveryList(context);
    Provider.of<Controller>(context, listen: false).getDamagedList(context, "");

    print("branch_id----$branch_id-----$branch_name");
  }

  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cid = prefs.getString("cid");
    Provider.of<Controller>(context, listen: false).userDetails();
    Provider.of<Controller>(context, listen: false).getDeliveryList(context);
    Provider.of<Controller>(context, listen: false).getDamagedList(context, "");
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () => _onBackPressed(context),
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          elevation: 0,
          backgroundColor: P_Settings.loginPagetheme,
          automaticallyImplyLeading: false,
          actions: [
            PopupMenuButton(
                // add icon, by default "3 dot" icon
                // icon: Icon(Icons.book)
                itemBuilder: (context) {
              return [
                PopupMenuItem<int>(
                  value: 0,
                  child: Text("Refresh"),
                ),
                PopupMenuItem<int>(
                  value: 1,
                  child: Text("Logout"),
                ),
              ];
            }, onSelected: (value) async {
              if (value == 0) {
                Provider.of<Controller>(context, listen: false).userDetails();
                Provider.of<Controller>(context, listen: false)
                    .getDeliveryList(context);
              } else if (value == 1) {
                final prefs = await SharedPreferences.getInstance();
                await prefs.remove('st_username');
                await prefs.remove('st_pwd');
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
                print('Pressed');
              }
            }),
          ],
        ),
        body: SmartRefresher(
          controller: _refreshController,
          enablePullDown: true,
          onRefresh: _onRefresh,
          child: Container(
            height: double.infinity,
            // color: P_Settings.loginPagetheme,
            child: Consumer<Controller>(
              builder: (context, value, child) {
                return Stack(
                  children: [
                    Container(
                      // transform: Matrix4.translationValues(0.0, -1.0, 0.0),

                      height: size.height * 0.21,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 30,
                            child: Image.asset("asset/login.png"),
                          ),
                          title: Text(
                            value.staff_name.toString(),
                            style: GoogleFonts.aBeeZee(
                              textStyle: Theme.of(context).textTheme.bodyText2,
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                              color: P_Settings.buttonColor,
                            ),
                          ),
                          // subtitle: Text(
                          //   value.branch_name.toString(),
                          //   style: GoogleFonts.aBeeZee(
                          //     textStyle: Theme.of(context).textTheme.bodyText2,
                          //     fontSize: 14,
                          //     // fontWeight: FontWeight.bold,
                          //     color: P_Settings.buttonColor,
                          //   ),
                          // ),
                          dense: false,
                        ),
                      ),
                      color: P_Settings.loginPagetheme,
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Positioned(
                      top: 80,
                      right: 26,
                      left: 26,
                      child: GestureDetector(
                        onTap: () {
                          Provider.of<Controller>(context, listen: false)
                              .setIssearch(false);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    SearchScreen(type: "start")),
                          );
                        },
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.grey[100],
                              boxShadow: [
                                BoxShadow(color: Colors.black, spreadRadius: 1),
                              ],
                            ),
                            height: size.height * 0.08,
                            child: ListTile(
                              // leading: CircleAvatar(
                              //     radius: 20,
                              //     child: Image.asset("asset/search.png")),
                              // trailing: Icon(Icons.arrow_forward),
                              title: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    // mainAxisAlignment: ,
                                    children: [
                                      CircleAvatar(
                                          backgroundColor: Colors.transparent,
                                          radius: 18,
                                          child:
                                              Image.asset("asset/search.png")),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 18.0),
                                        child: Text(
                                          "Search",
                                          style: GoogleFonts.aBeeZee(
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .bodyText2,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: P_Settings.loginPagetheme,
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      Icon(
                                        Icons.arrow_right,
                                        size: 40,
                                        color: P_Settings.loginPagetheme,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )),
                      ),
                    ),
                    // Positioned(
                    //     top: 100, right: 10, left: 10, child: ListTile(
                    //       tileColor: Colors.white,
                    //       title: Text("sjdkfhjh"),
                    //     )),
                    Positioned(
                      top: 190,
                      right: 10,
                      left: 10,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: size.width * 0.44,
                            height: size.height * 0.2,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              color: Colors.white,
                              child: ListTile(
                                onTap: () {
                                  Provider.of<Controller>(context,
                                          listen: false)
                                      .selected = null;
                                  Provider.of<Controller>(context,
                                          listen: false)
                                      .getSiteList(context, "1");
                                  value.stockItemSelection = [];
                                  // Provider.of<Controller>(context,
                                  //         listen: false)
                                  //     .getbagData1(context, "");
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => StockReportList(
                                              title: "Stock Report",
                                            )),
                                  );
                                },
                                // leading: CircleAvatar(
                                //     radius: 20,
                                //     child: Image.asset("asset/report.png")),
                                // trailing: Icon(Icons.arrow_forward),
                                title: Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: CircleAvatar(
                                            radius: 30,
                                            backgroundColor: Colors.transparent,
                                            child: Image.asset(
                                                "asset/report.png")),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Text(
                                          "Stock Report",
                                          style: GoogleFonts.aBeeZee(
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .bodyText2,
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
                            ),
                          ),
                          Container(
                            width: size.width * 0.44,
                            height: size.height * 0.2,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              color: Colors.white,
                              child: ListTile(
                                onTap: () {
                                  value.cartCount = null;
                                  Provider.of<Controller>(context,
                                          listen: false)
                                      .bagList
                                      .clear();
                                  Provider.of<Controller>(context,
                                          listen: false)
                                      .selected = null;
                                  Provider.of<Controller>(context,
                                          listen: false)
                                      .series = null;
                                  Provider.of<Controller>(context,
                                          listen: false)
                                      .getSiteList(context, "0");
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => StockRequest(
                                              from_type: "0",
                                              title: "Material Request",
                                            )),
                                  );
                                },
                                title: Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            CircleAvatar(
                                                radius: 30,
                                                backgroundColor:
                                                    Colors.transparent,
                                                child: Image.asset(
                                                    "asset/stock.png")),
                                            value.damagedList.length == 0
                                                ? Container()
                                                : badges.Badge(
                                                    badgeStyle:
                                                        badges.BadgeStyle(
                                                            // badgeGradient: badges.BadgeGradient.radial(colors: Colors.primaries),
                                                            shape: badges
                                                                .BadgeShape
                                                                .circle,
                                                            badgeColor:
                                                                Colors.red),
                                                    position:
                                                        badges.BadgePosition
                                                            .topEnd(
                                                                top: -30,
                                                                end: -1),
                                                    badgeContent: value
                                                            .damLoading
                                                        ? SpinKitChasingDots(
                                                            size: 10,
                                                            color: P_Settings
                                                                .homeappbarColor,
                                                          )
                                                        : Text(
                                                            value
                                                                .damagedListCount
                                                                .toString(),
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                    child: Icon(
                                                      Icons.shopping_cart,
                                                      color: Colors.white,
                                                    ))
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Text(
                                              "Material Request",
                                              style: GoogleFonts.aBeeZee(
                                                textStyle: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color:
                                                    P_Settings.loginPagetheme,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 360,
                      right: 10,
                      left: 10,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: size.width * 0.44,
                            height: size.height * 0.2,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              color: Colors.white,
                              child: ListTile(
                                onTap: () {
                                  Provider.of<Controller>(context,
                                          listen: false)
                                      .bagList
                                      .clear();
                                  Provider.of<Controller>(context,
                                          listen: false)
                                      .selected = null;
                                  Provider.of<Controller>(context,
                                          listen: false)
                                      .series = null;
                                  value.cartCount = null;
                                  Provider.of<Controller>(context,
                                          listen: false)
                                      .getSiteList(context, "1");
                                  // Provider.of<Controller>(context,
                                  //         listen: false)
                                  // .getProductDetails("0", "");
                                  // Provider.of<Controller>(context,
                                  //         listen: false)
                                  //     .getbagData1(
                                  //         context, "main", "save", "1");
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => StockReturn(
                                              form_type: "1",
                                              title: "Material Return",
                                            )),
                                  );
                                },
                                // leading: CircleAvatar(
                                //     radius: 20,
                                //     child: Image.asset("asset/stockReturn.png")),
                                // trailing: Icon(Icons.arrow_forward),
                                title: Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: CircleAvatar(
                                            backgroundColor: Colors.transparent,
                                            radius: 30,
                                            child: Image.asset(
                                                "asset/stockReturn.png")),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Material Return",
                                          style: GoogleFonts.aBeeZee(
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .bodyText2,
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
                            ),
                          ),
                          Container(
                            width: size.width * 0.44,
                            height: size.height * 0.2,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              color: Colors.white,
                              child: ListTile(
                                onTap: () {
                                  Provider.of<Controller>(context,
                                          listen: false)
                                      .getDeliveryList(context);
                                  if (int.parse(value.deliveryListCount!) > 0) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ReceivedList(
                                                title: "Delivery List",
                                              )),
                                    );
                                  }
                                },
                                title: Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            CircleAvatar(
                                                backgroundColor:
                                                    Colors.transparent,
                                                radius: 30,
                                                child: Image.asset(
                                                    "asset/received.png")),
                                            value.dispatchedList.length == 0
                                                ? Container()
                                                : badges.Badge(
                                                    badgeStyle:
                                                        badges.BadgeStyle(
                                                            // badgeGradient: badges.BadgeGradient.radial(colors: Colors.primaries),
                                                            shape: badges
                                                                .BadgeShape
                                                                .circle,
                                                            badgeColor:
                                                                Colors.red),
                                                    position:
                                                        badges.BadgePosition
                                                            .topEnd(
                                                                top: -30,
                                                                end: -1),
                                                    badgeContent: value
                                                            .isLoading
                                                        ? SpinKitChasingDots(
                                                            color: P_Settings
                                                                .loginPagetheme,size: 10,
                                                          )
                                                        : Text(
                                                            value
                                                                .deliveryListCount
                                                                .toString(),
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                    child: Icon(
                                                      Icons.shopping_cart,
                                                      color: Colors.white,
                                                    ))
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Delivery List",
                                          style: GoogleFonts.aBeeZee(
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .bodyText2,
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
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _onBackPressed(BuildContext context) async {
    return await showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          // title: const Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Do you want to exit from this app'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                exit(0);
              },
            ),
          ],
        );
      },
    );
  }
}
