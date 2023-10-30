// import 'dart:io';

// import 'package:badges/badges.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:hamco/components/commonColor.dart';
// import 'package:hamco/controller/controller.dart';
// import 'package:hamco/screen/login&registration/login.dart';
// import 'package:hamco/screen/received/receivedList.dart';
// import 'package:hamco/screen/return/stockReturn.dart';
// import 'package:hamco/screen/search/searchScreen.dart';
// import 'package:hamco/screen/stock%20Request/stockRequest.dart';
// import 'package:hamco/screen/stock%20report/stockReport.dart';
// import 'package:hamco/screen/stock%20report/stockReportList.dart';
// import 'package:intl/intl.dart';
// import 'package:lottie/lottie.dart';

// import 'package:provider/provider.dart';
// import 'package:pull_to_refresh/pull_to_refresh.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class MainDashboard extends StatefulWidget {
//   @override
//   State<MainDashboard> createState() => _MainDashboardState();
// }

// class _MainDashboardState extends State<MainDashboard> {
//   RefreshController _refreshController =
//       RefreshController(initialRefresh: false);
//   String? branch_id;
//   String? staff_name;
//   String? branch_name;
//   String? branch_prefix;
//   String? user_id;
//   String? todaydate;

//   shared() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     branch_id = prefs.getString("branch_id");
//     staff_name = prefs.getString("staff_name");
//     branch_name = prefs.getString("branch_name");
//     branch_prefix = prefs.getString("branch_prefix");
//     user_id = prefs.getString("user_id");
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     shared();

//     Provider.of<Controller>(context, listen: false).userDetails();
//     Provider.of<Controller>(context, listen: false).getDeliveryList(context);
//     print("branch_id----$branch_id-----$branch_name");
//   }

//   void _onRefresh() async {
//     await Future.delayed(Duration(milliseconds: 1000));
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? cid = prefs.getString("cid");
//     Provider.of<Controller>(context, listen: false).userDetails();
//        Provider.of<Controller>(context, listen: false)
//                     .getDeliveryList(context);
//     _refreshController.refreshCompleted();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;

//     return WillPopScope(
//       onWillPop: () => _onBackPressed(context),
//       child: Scaffold(
//         backgroundColor: Colors.grey[200],
//         appBar: AppBar(
//           elevation: 0,
//           backgroundColor: P_Settings.loginPagetheme,
//           automaticallyImplyLeading: false,
//           actions: [
//             PopupMenuButton(
//                 // add icon, by default "3 dot" icon
//                 // icon: Icon(Icons.book)
//                 itemBuilder: (context) {
//               return [
//                 PopupMenuItem<int>(
//                   value: 0,
//                   child: Text("Refresh"),
//                 ),
//                 PopupMenuItem<int>(
//                   value: 1,
//                   child: Text("Logout"),
//                 ),
//               ];
//             }, onSelected: (value) async {
//               if (value == 0) {
//                 Provider.of<Controller>(context, listen: false).userDetails();
//                 Provider.of<Controller>(context, listen: false)
//                     .getDeliveryList(context);
//               } else if (value == 1) {
//                 final prefs = await SharedPreferences.getInstance();
//                 await prefs.remove('st_username');
//                 await prefs.remove('st_pwd');
//                 Navigator.pushReplacement(context,
//                     MaterialPageRoute(builder: (context) => LoginPage()));
//                 print('Pressed');
//               }
//             }),
//           ],
//         ),
//         body: SmartRefresher(
//           controller: _refreshController,
//           enablePullDown: true,
//           onRefresh: _onRefresh,
//           child: Container(
//             height: double.infinity,
//             // color: P_Settings.loginPagetheme,
//             child: Consumer<Controller>(
//               builder: (context, value, child) {
//                 return Stack(
//                   children: [
//                     Container(
//                       height: size.height * 0.2,
//                       child: Padding(
//                         padding: const EdgeInsets.only(left: 10.0),
//                         child: ListTile(
//                           leading: CircleAvatar(
//                             radius: 30,
//                             child: Image.asset("asset/login.png"),
//                           ),
//                           title: Text(
//                             value.staff_name.toString(),
//                             style: GoogleFonts.aBeeZee(
//                               textStyle: Theme.of(context).textTheme.bodyText2,
//                               fontSize: 23,
//                               fontWeight: FontWeight.bold,
//                               color: P_Settings.buttonColor,
//                             ),
//                           ),
//                           subtitle: Text(
//                             value.branch_name.toString(),
//                             style: GoogleFonts.aBeeZee(
//                               textStyle: Theme.of(context).textTheme.bodyText2,
//                               fontSize: 14,
//                               // fontWeight: FontWeight.bold,
//                               color: P_Settings.buttonColor,
//                             ),
//                           ),
//                           dense: false,
//                         ),
//                       ),
//                       color: P_Settings.loginPagetheme,
//                     ),
//                     SizedBox(
//                       height: size.height * 0.02,
//                     ),
//                     Positioned(
//                       top: 100,
//                       right: 10,
//                       left: 10,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           Container(
//                             width: size.width * 0.43,
//                             height: size.height * 0.2,
//                             child: Card(
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(15.0),
//                               ),
//                               color: Colors.white,
//                               child: ListTile(
//                                 onTap: () {
//                                   Provider.of<Controller>(context,
//                                           listen: false)
//                                       .getSiteList(context, "1");
//                                   value.stockItemSelection = [];
//                                   // Provider.of<Controller>(context,
//                                   //         listen: false)
//                                   //     .getbagData1(context, "");
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) => StockReport(title: "Stock Report",)),
//                                   );
//                                 },
//                                 // leading: CircleAvatar(
//                                 //     radius: 20,
//                                 //     child: Image.asset("asset/report.png")),
//                                 // trailing: Icon(Icons.arrow_forward),
//                                 title: Padding(
//                                   padding: const EdgeInsets.only(top: 8.0),
//                                   child: Column(
//                                     children: [
//                                       Padding(
//                                         padding: const EdgeInsets.all(8),
//                                         child: CircleAvatar(
//                                             radius: 30,
//                                             child: Image.asset(
//                                                 "asset/report.png")),
//                                       ),
//                                       Padding(
//                                         padding: const EdgeInsets.all(8),
//                                         child: Text(
//                                           "Stock Report",
//                                           style: GoogleFonts.aBeeZee(
//                                             textStyle: Theme.of(context)
//                                                 .textTheme
//                                                 .bodyText2,
//                                             fontSize: 15,
//                                             fontWeight: FontWeight.bold,
//                                             color: P_Settings.loginPagetheme,
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Container(
//                             width: size.width * 0.43,
//                             height: size.height * 0.2,
//                             child: Card(
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(15.0),
//                               ),
//                               color: Colors.white,
//                               child: ListTile(
//                                 onTap: () {
//                                   value.cartCount = null;
//                                   Provider.of<Controller>(context,
//                                           listen: false)
//                                       .bagList
//                                       .clear();
//                                   Provider.of<Controller>(context,
//                                           listen: false)
//                                       .selected = null;
//                                   Provider.of<Controller>(context,
//                                           listen: false)
//                                       .series = null;
//                                   Provider.of<Controller>(context,
//                                           listen: false)
//                                       .getSiteList(context, "0");
//                                   Provider.of<Controller>(context,
//                                           listen: false)
//                                       .getProductDetails("0", "");
//                                   Provider.of<Controller>(context,
//                                           listen: false)
//                                       .getbagData1(context, "main", "", "0");
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) => StockRequest(
//                                               from_type: "0",
//                                               title: "Stock Request",
//                                             )),
//                                   );
//                                 },
//                                 // leading: CircleAvatar(
//                                 //     radius: 20,
//                                 //     child: Image.asset("asset/stock.png")),
//                                 // trailing: Icon(Icons.arrow_forward),
//                                 title: Padding(
//                                   padding: const EdgeInsets.only(top: 8.0),
//                                   child: Column(
//                                     children: [
//                                       Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: CircleAvatar(
//                                             radius: 30,
//                                             child:
//                                                 Image.asset("asset/stock.png")),
//                                       ),
//                                       Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: Text(
//                                           "Stock Request",
//                                           style: GoogleFonts.aBeeZee(
//                                             textStyle: Theme.of(context)
//                                                 .textTheme
//                                                 .bodyText2,
//                                             fontSize: 15,
//                                             fontWeight: FontWeight.bold,
//                                             color: P_Settings.loginPagetheme,
//                                           ),
//                                         ),
//                                       ),

//                                       // Icon(Icons.arrow_forward),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                     Positioned(
//                       top: 280,
//                       right: 10,
//                       left: 10,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           Container(
//                             width: size.width * 0.43,
//                             height: size.height * 0.2,
//                             child: Card(
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(15.0),
//                               ),
//                               color: Colors.white,
//                               child: ListTile(
//                                 onTap: () {
//                                   Provider.of<Controller>(context,
//                                           listen: false)
//                                       .bagList
//                                       .clear();
//                                   Provider.of<Controller>(context,
//                                           listen: false)
//                                       .selected = null;
//                                   Provider.of<Controller>(context,
//                                           listen: false)
//                                       .series = null;
//                                   value.cartCount = null;
//                                   Provider.of<Controller>(context,
//                                           listen: false)
//                                       .getSiteList(context, "1");
//                                   Provider.of<Controller>(context,
//                                           listen: false)
//                                       .getProductDetails("0", "");
//                                   Provider.of<Controller>(context,
//                                           listen: false)
//                                       .getbagData1(
//                                           context, "main", "save", "1");
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) => StockReturn(
//                                               form_type: "1",title: "Stock Return",
//                                             )),
//                                   );
//                                 },
//                                 // leading: CircleAvatar(
//                                 //     radius: 20,
//                                 //     child: Image.asset("asset/stockReturn.png")),
//                                 // trailing: Icon(Icons.arrow_forward),
//                                 title: Padding(
//                                   padding: const EdgeInsets.only(top: 8.0),
//                                   child: Column(
//                                     children: [
//                                       Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: CircleAvatar(
//                                             radius: 30,
//                                             child: Image.asset(
//                                                 "asset/stockReturn.png")),
//                                       ),
//                                       Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: Text(
//                                           "Stock Return",
//                                           style: GoogleFonts.aBeeZee(
//                                             textStyle: Theme.of(context)
//                                                 .textTheme
//                                                 .bodyText2,
//                                             fontSize: 15,
//                                             fontWeight: FontWeight.bold,
//                                             color: P_Settings.loginPagetheme,
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Container(
//                             width: size.width * 0.43,
//                             height: size.height * 0.2,
//                             child: Card(
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(15.0),
//                               ),
//                               color: Colors.white,
//                               child: ListTile(
//                                 onTap: () {
//                                   // Provider.of<Controller>(context,
//                                   //         listen: false)
//                                   //     .getTransactionList(context);
//                                   Provider.of<Controller>(context,
//                                           listen: false)
//                                       .setIssearch(false);
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) =>
//                                             SearchScreen(type: "start")),
//                                   );
//                                 },
//                                 // leading: CircleAvatar(
//                                 //     radius: 20,
//                                 //     child: Image.asset("asset/search.png")),
//                                 // trailing: Icon(Icons.arrow_forward),
//                                 title: Padding(
//                                   padding: const EdgeInsets.only(top: 8.0),
//                                   child: Column(
//                                     children: [
//                                       Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: CircleAvatar(
//                                             radius: 30,
//                                             child: Image.asset(
//                                                 "asset/search.png")),
//                                       ),
//                                       Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: Text(
//                                           "Search",
//                                           style: GoogleFonts.aBeeZee(
//                                             textStyle: Theme.of(context)
//                                                 .textTheme
//                                                 .bodyText2,
//                                             fontSize: 15,
//                                             fontWeight: FontWeight.bold,
//                                             color: P_Settings.loginPagetheme,
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Badge(
//                       animationType: BadgeAnimationType.scale,
//                       toAnimate: true,
//                       badgeColor: Colors.red,
//                       badgeContent: Consumer<Controller>(
//                         builder: (context, value, child) {
//                           // print("cart count.....${value.cartCount}");
//                           // if (value.cartCount == null) {
//                           //   return SpinKitChasingDots(
//                           //       color: P_Settings.buttonColor, size: 9);
//                           // } else {
//                           return Container(
//                             height: size.height * 0.02,
//                             child: Center(
//                               child: Text(
//                                 value.deliveryListCount != null
//                                     ? value.deliveryListCount!
//                                     : "..",
//                                 style: TextStyle(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.white),
//                               ),
//                             ),
//                           );
//                           // }
//                         },
//                       ),
//                       position: const BadgePosition(start: 120, top: 470),
//                       child: Positioned(
//                           top: 460,
//                           right: 10,
//                           left: 30,
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               Container(
//                                 width: size.width * 0.43,
//                                 height: size.height * 0.2,
//                                 child: Card(
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(15.0),
//                                   ),
//                                   color: Colors.white,
//                                   child: ListTile(
//                                     onTap: () {
//                                       Provider.of<Controller>(context,
//                                               listen: false)
//                                           .getDeliveryList(context);

//                                       // Provider.of<Controller>(context,
//                                       //         listen: false)
//                                       //     .getTransactionList(context);
//                                       // Provider.of<Controller>(context,
//                                       //         listen: false)
//                                       //     .setIssearch(false);
//                                       Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                             builder: (context) =>
//                                                 ReceivedList(title: "Delivery List",)),
//                                       );
//                                     },
//                                     // leading: CircleAvatar(
//                                     //     radius: 20,
//                                     //     child: Image.asset("asset/search.png")),
//                                     // trailing: Icon(Icons.arrow_forward),
//                                     title: Padding(
//                                       padding: const EdgeInsets.only(top: 8.0),
//                                       child: Column(
//                                         children: [
//                                           Padding(
//                                             padding: const EdgeInsets.all(8.0),
//                                             child: CircleAvatar(
//                                                 radius: 30,
//                                                 child: Image.asset(
//                                                     "asset/received.png")),
//                                           ),
//                                           Padding(
//                                             padding: const EdgeInsets.all(8.0),
//                                             child: Text(
//                                               "Delivery List",
//                                               style: GoogleFonts.aBeeZee(
//                                                 textStyle: Theme.of(context)
//                                                     .textTheme
//                                                     .bodyText2,
//                                                 fontSize: 15,
//                                                 fontWeight: FontWeight.bold,
//                                                 color:
//                                                     P_Settings.loginPagetheme,
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           )),
//                       // value.dispatchedList.length == 0
//                       //     ? Container()
//                       //     : Padding(
//                       //         padding: const EdgeInsets.all(8.0),
//                       //         child: ListTile(
//                       //           visualDensity:
//                       //               VisualDensity(horizontal: 0, vertical: -4),
//                       //           title: Text(
//                       //             "Stock Approval",
//                       //             style: GoogleFonts.aBeeZee(
//                       //               textStyle:
//                       //                   Theme.of(context).textTheme.bodyText2,
//                       //               fontSize: 16,
//                       //               fontWeight: FontWeight.bold,
//                       //               color: P_Settings.loginPagetheme,
//                       //             ),
//                       //           ),
//                       //         ),
//                       //       ),
//                       // Positioned(
//                       //     top: 500,
//                       //     // bottom: 0,
//                       //     child: Expanded(
//                       //         child: Container(
//                       //       height: 400,
//                       //     ))),
//                       // value.isLoading
//                       //     ? Expanded(
//                       //         child: Container(
//                       //           height: double.infinity,
//                       //           child: SpinKitFadingCircle(
//                       //             color: P_Settings.loginPagetheme,
//                       //           ),
//                       //         ),
//                       //       )
//                       //     : Expanded(
//                       //         child: ListView.builder(
//                       //         itemCount: value.dispatchedList.length,
//                       //         itemBuilder: (context, index) {
//                       //           return Padding(
//                       //             padding: const EdgeInsets.all(8.0),
//                       //             child: Card(
//                       //               child: ListTile(
//                       //                 onTap: () {
//                       //                   Provider.of<Controller>(context,
//                       //                           listen: false)
//                       //                       .getStockApproveInfo(
//                       //                           context,
//                       //                           value.dispatchedList[index]
//                       //                               ["os_id"]);
//                       //                   // Navigator.push(
//                       //                   //   context,
//                       //                   //   MaterialPageRoute(
//                       //                   //       builder: (context) =>
//                       //                   //           StockApprovalPage(
//                       //                   //             os_id:
//                       //                   //                 value.stock_approve_list[
//                       //                   //                     index]["os_id"],
//                       //                   //           )),
//                       //                   // );
//                       //                 },
//                       //                 trailing: Icon(Icons.arrow_forward),
//                       //                 title: Row(
//                       //                   children: [
//                       //                     Text(
//                       //                       value.dispatchedList[index]["series"]
//                       //                           .toString(),
//                       //                       style: GoogleFonts.aBeeZee(
//                       //                         textStyle: Theme.of(context)
//                       //                             .textTheme
//                       //                             .bodyText2,
//                       //                         fontSize: 16,
//                       //                         fontWeight: FontWeight.bold,
//                       //                         color: P_Settings.loginPagetheme,
//                       //                       ),
//                       //                     ),
//                       //                     Padding(
//                       //                       padding:
//                       //                           const EdgeInsets.only(left: 14.0),
//                       //                       child: Text(
//                       //                         value.dispatchedList[index]
//                       //                                 ["entry_date"]
//                       //                             .toString(),
//                       //                         style: GoogleFonts.aBeeZee(
//                       //                           textStyle: Theme.of(context)
//                       //                               .textTheme
//                       //                               .bodyText2,
//                       //                           fontSize: 16,
//                       //                           // fontWeight: FontWeight.bold,
//                       //                           color: P_Settings.loginPagetheme,
//                       //                         ),
//                       //                       ),
//                       //                     ),
//                       //                   ],
//                       //                 ),
//                       //                 subtitle: Flexible(
//                       //                   child: Row(
//                       //                     children: [
//                       //                       Text(
//                       //                         "Branch : ",
//                       //                         style: GoogleFonts.aBeeZee(
//                       //                           textStyle: Theme.of(context)
//                       //                               .textTheme
//                       //                               .bodyText2,
//                       //                           fontSize: 15,
//                       //                           // fontWeight: FontWeight.bold,
//                       //                           color: Colors.grey[700],
//                       //                         ),
//                       //                       ),
//                       //                       Text(
//                       //                         value.dispatchedList[index]
//                       //                                 ["from_branch"]
//                       //                             .toString(),
//                       //                         style: GoogleFonts.aBeeZee(
//                       //                           textStyle: Theme.of(context)
//                       //                               .textTheme
//                       //                               .bodyText2,
//                       //                           fontSize: 15,
//                       //                           // fontWeight: FontWeight.bold,
//                       //                           color: P_Settings.loginPagetheme,
//                       //                         ),
//                       //                       ),
//                       //                     ],
//                       //                   ),
//                       //                 ),
//                       //               ),
//                       //             ),
//                       //           );
//                       //         },
//                       //       ))
//                       // Padding(
//                       //   padding:
//                       //       const EdgeInsets.only(left: 20, right: 30, top: 10),
//                       //   child: Card(
//                       //     shape: RoundedRectangleBorder(
//                       //       borderRadius: BorderRadius.circular(15.0),
//                       //     ),
//                       //     color: Colors.grey[200],
//                       //     child: ListTile(
//                       //       onTap: () {
//                       //         Provider.of<Controller>(context, listen: false)
//                       //             .getTransactionList(context);

//                       //         // Navigator.push(
//                       //         //   context,
//                       //         //   MaterialPageRoute(
//                       //         //       builder: (context) => TransactionPage()),
//                       //         // );
//                       //       },
//                       //       leading: CircleAvatar(
//                       //           radius: 20,
//                       //           child: Image.asset("asset/report.png")),
//                       //       trailing: Icon(Icons.arrow_forward),
//                       //       title: Text(
//                       //         "Stock Report",
//                       //         style: GoogleFonts.aBeeZee(
//                       //           textStyle: Theme.of(context).textTheme.bodyText2,
//                       //           fontSize: 16,
//                       //           fontWeight: FontWeight.bold,
//                       //           color: Colors.black,
//                       //         ),
//                       //       ),
//                       //     ),
//                       //   ),
//                       // ),

//                       // Padding(
//                       //   padding:
//                       //       const EdgeInsets.only(left: 20, right: 30, top: 10),
//                       //   child: Card(
//                       //     shape: RoundedRectangleBorder(
//                       //       borderRadius: BorderRadius.circular(15.0),
//                       //     ),
//                       //     color: Colors.grey[200],
//                       //     child: ListTile(
//                       //       onTap: () {
//                       //         Provider.of<Controller>(context, listen: false)
//                       //             .getTransactionList(context);
//                       //         Provider.of<Controller>(context, listen: false)
//                       //             .getbagData1(context, "");
//                       //         Navigator.push(
//                       //           context,
//                       //           MaterialPageRoute(
//                       //               builder: (context) => StockRequest()),
//                       //         );
//                       //       },
//                       //       leading: CircleAvatar(
//                       //           radius: 20,
//                       //           child: Image.asset("asset/stock.png")),
//                       //       trailing: Icon(Icons.arrow_forward),
//                       //       title: Text(
//                       //         "Stock Request",
//                       //         style: GoogleFonts.aBeeZee(
//                       //           textStyle: Theme.of(context).textTheme.bodyText2,
//                       //           fontSize: 16,
//                       //           fontWeight: FontWeight.bold,
//                       //           color: P_Settings.loginPagetheme,
//                       //         ),
//                       //       ),
//                       //     ),
//                       //   ),
//                       // ),
//                       // Padding(
//                       //   padding:
//                       //       const EdgeInsets.only(left: 20, right: 30, top: 10),
//                       //   child: Card(
//                       //     shape: RoundedRectangleBorder(
//                       //       borderRadius: BorderRadius.circular(15.0),
//                       //     ),
//                       //     color: Colors.grey[200],
//                       //     child: ListTile(
//                       //       onTap: () {
//                       //         Provider.of<Controller>(context, listen: false)
//                       //             .getTransactionList(context);
//                       //         Provider.of<Controller>(context, listen: false)
//                       //             .getbagData1(context, "");
//                       //         // Navigator.push(
//                       //         //   context,
//                       //         //   MaterialPageRoute(
//                       //         //       builder: (context) => TransactionPage2()),
//                       //         // );
//                       //       },
//                       //       leading: CircleAvatar(
//                       //           radius: 20,
//                       //           child: Image.asset("asset/stockReturn.png")),
//                       //       trailing: Icon(Icons.arrow_forward),
//                       //       title: Text(
//                       //         "Stock Return",
//                       //         style: GoogleFonts.aBeeZee(
//                       //           textStyle: Theme.of(context).textTheme.bodyText2,
//                       //           fontSize: 16,
//                       //           fontWeight: FontWeight.bold,
//                       //           color: P_Settings.loginPagetheme,
//                       //         ),
//                       //       ),
//                       //     ),
//                       //   ),
//                       // ),
//                       // Padding(
//                       //   padding:
//                       //       const EdgeInsets.only(left: 20, right: 30, top: 10),
//                       //   child: Card(
//                       //     shape: RoundedRectangleBorder(
//                       //       borderRadius: BorderRadius.circular(15.0),
//                       //     ),
//                       //     color: Colors.grey[200],
//                       //     child: ListTile(
//                       //       onTap: () {
//                       //         Provider.of<Controller>(context, listen: false)
//                       //             .getTransactionList(context);
//                       //         Provider.of<Controller>(context, listen: false)
//                       //             .setIssearch(false);
//                       //         Navigator.push(
//                       //           context,
//                       //           MaterialPageRoute(
//                       //               builder: (context) =>
//                       //                   SearchScreen(type: "start")),
//                       //         );
//                       //       },
//                       //       leading: CircleAvatar(
//                       //           radius: 20,
//                       //           child: Image.asset("asset/search.png")),
//                       //       trailing: Icon(Icons.arrow_forward),
//                       //       title: Text(
//                       //         "Search",
//                       //         style: GoogleFonts.aBeeZee(
//                       //           textStyle: Theme.of(context).textTheme.bodyText2,
//                       //           fontSize: 16,
//                       //           fontWeight: FontWeight.bold,
//                       //           color: P_Settings.loginPagetheme,
//                       //         ),
//                       //       ),
//                       //     ),
//                       //   ),
//                       // ),
//                       // value.stock_approve_list.length == 0
//                       //     ? Container()
//                       //     : Padding(
//                       //         padding: const EdgeInsets.all(8.0),
//                       //         child: ListTile(
//                       //           visualDensity:
//                       //               VisualDensity(horizontal: 0, vertical: -4),
//                       //           title: Text(
//                       //             "Stock Approval",
//                       //             style: GoogleFonts.aBeeZee(
//                       //               textStyle:
//                       //                   Theme.of(context).textTheme.bodyText2,
//                       //               fontSize: 16,
//                       //               fontWeight: FontWeight.bold,
//                       //               color: P_Settings.loginPagetheme,
//                       //             ),
//                       //           ),
//                       //         ),
//                       //       ),
//                       // value.isLoading
//                       //     ? Expanded(
//                       //         child: Container(
//                       //           height: double.infinity,
//                       //           child: SpinKitFadingCircle(
//                       //             color: P_Settings.loginPagetheme,
//                       //           ),
//                       //         ),
//                       //       )
//                       //     :
//                       //     Expanded(
//                       //         child: ListView.builder(
//                       //         itemCount: value.stock_approve_list.length,
//                       //         itemBuilder: (context, index) {
//                       //           return Padding(
//                       //             padding: const EdgeInsets.all(8.0),
//                       //             child: Card(
//                       //               child: ListTile(
//                       //                 onTap: () {
//                       //                   Provider.of<Controller>(context,
//                       //                           listen: false)
//                       //                       .getStockApproveInfo(
//                       //                           context,
//                       //                           value.stock_approve_list[index]
//                       //                               ["os_id"]);
//                       //                   // Navigator.push(
//                       //                   //   context,
//                       //                   //   MaterialPageRoute(
//                       //                   //       builder: (context) =>
//                       //                   //           StockApprovalPage(
//                       //                   //             os_id:
//                       //                   //                 value.stock_approve_list[
//                       //                   //                     index]["os_id"],
//                       //                   //           )),
//                       //                   // );
//                       //                 },
//                       //                 trailing: Icon(Icons.arrow_forward),
//                       //                 title: Row(
//                       //                   children: [
//                       //                     Text(
//                       //                       value.stock_approve_list[index]
//                       //                               ["series"]
//                       //                           .toString(),
//                       //                       style: GoogleFonts.aBeeZee(
//                       //                         textStyle: Theme.of(context)
//                       //                             .textTheme
//                       //                             .bodyText2,
//                       //                         fontSize: 16,
//                       //                         fontWeight: FontWeight.bold,
//                       //                         color: P_Settings.loginPagetheme,
//                       //                       ),
//                       //                     ),
//                       //                     Padding(
//                       //                       padding:
//                       //                           const EdgeInsets.only(left: 14.0),
//                       //                       child: Text(
//                       //                         value.stock_approve_list[index]
//                       //                                 ["entry_date"]
//                       //                             .toString(),
//                       //                         style: GoogleFonts.aBeeZee(
//                       //                           textStyle: Theme.of(context)
//                       //                               .textTheme
//                       //                               .bodyText2,
//                       //                           fontSize: 16,
//                       //                           // fontWeight: FontWeight.bold,
//                       //                           color: P_Settings.loginPagetheme,
//                       //                         ),
//                       //                       ),
//                       //                     ),
//                       //                   ],
//                       //                 ),
//                       //                 subtitle: Flexible(
//                       //                   child: Row(
//                       //                     children: [
//                       //                       Text(
//                       //                         "Branch : ",
//                       //                         style: GoogleFonts.aBeeZee(
//                       //                           textStyle: Theme.of(context)
//                       //                               .textTheme
//                       //                               .bodyText2,
//                       //                           fontSize: 15,
//                       //                           // fontWeight: FontWeight.bold,
//                       //                           color: Colors.grey[700],
//                       //                         ),
//                       //                       ),
//                       //                       Text(
//                       //                         value.stock_approve_list[index]
//                       //                                 ["from_branch"]
//                       //                             .toString(),
//                       //                         style: GoogleFonts.aBeeZee(
//                       //                           textStyle: Theme.of(context)
//                       //                               .textTheme
//                       //                               .bodyText2,
//                       //                           fontSize: 15,
//                       //                           // fontWeight: FontWeight.bold,
//                       //                           color: P_Settings.loginPagetheme,
//                       //                         ),
//                       //                       ),
//                       //                     ],
//                       //                   ),
//                       //                 ),
//                       //               ),
//                       //             ),
//                       //           );
//                       //         },
//                       //       ))
//                     ),
//                   ],
//                 );
//               },
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget customCard(Size size, String title, double value) {
//     return Container(
//       height: size.height * 0.2,
//       width: size.width * 0.45,
//       // color:P_Settings.tileColor,
//       child: Card(
//         color: P_Settings.tileColor,
//         shape: RoundedRectangleBorder(
//           // side: BorderSide(color: Colors.white70, width: 1),
//           borderRadius: BorderRadius.circular(20),
//         ),
//         // color: title == "Orders"
//         //     ? P_Settings.dashbordcl1
//         //     : title == "Collection"
//         //         ? P_Settings.dashbordcl2
//         //         : title == "Sales"
//         //             ? P_Settings.dashbordcl3
//         //             : title == "Return"
//         //                 ? P_Settings.dashbordcl4
//         //                 : title == "Shops visited"
//         //                     ? P_Settings.dashbordcl5
//         //                     : title == "Shops Not Visited"
//         //                         ? P_Settings.dashbordcl6
//         //                         : Colors.grey,
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             children: [
//               Container(
//                   // height: size.height * 0.1,
//                   // width: size.width * 0.12,
//                   child: title == "Stock"
//                       ? Image.asset(
//                           "asset/exchanging.png",
//                           height: size.height * 0.1,
//                           width: size.width * 0.12,
//                         )
//                       : title == "Transfer"
//                           ? Image.asset(
//                               "asset/stock.png",
//                               height: size.height * 0.1,
//                               width: size.width * 0.12,
//                             )
//                           : null),
//               Text(
//                 title.toString(),
//                 style: GoogleFonts.oswald(
//                   textStyle: Theme.of(context).textTheme.bodyText1,
//                   fontSize: 16,
//                   color: Colors.black,
//                 ),
//               ),
//               Text(
//                 value.toString(),
//                 style: GoogleFonts.oswald(
//                   textStyle: Theme.of(context).textTheme.bodyText1,
//                   fontSize: 20,
//                   color: Colors.black,
//                 ),
//                 // style: TextStyle(
//                 //     fontSize: 23,
//                 //     fontWeight: FontWeight.bold,
//                 //     color: Colors.white),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// Future<bool> _onBackPressed(BuildContext context) async {
//   return await showDialog(
//     context: context,
//     barrierDismissible: false, // user must tap button!
//     builder: (BuildContext context) {
//       return AlertDialog(
//         // title: const Text('AlertDialog Title'),
//         content: SingleChildScrollView(
//           child: ListBody(
//             children: const <Widget>[
//               Text('Do you want to exit from this app'),
//             ],
//           ),
//         ),
//         actions: <Widget>[
//           TextButton(
//             child: const Text('Cancel'),
//             onPressed: () {
//               Navigator.of(context).pop(false);
//             },
//           ),
//           TextButton(
//             child: const Text('Ok'),
//             onPressed: () {
//               exit(0);
//             },
//           ),
//         ],
//       );
//     },
//   );
// }
