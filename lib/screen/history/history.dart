import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hamco/components/commonColor.dart';
import 'package:hamco/components/datEfind.dart';
import 'package:hamco/controller/controller.dart';
import 'package:hamco/screen/bottomSheet/transaction_item_info_sheet.dart';
import 'package:hamco/screen/history/alertCommon.dart';
import 'package:hamco/screen/status%20monitoring/custom_stepper.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import 'package:provider/provider.dart';

class HistoryPage extends StatefulWidget {
  String form_type;
  HistoryPage({required this.form_type});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  DateTime now = DateTime.now();
  // TransaInfoBottomsheet infoshowsheet = TransaInfoBottomsheet();
  AlertCommon popup = AlertCommon();
  DateFind dateFind = DateFind();
  String? date;
  List<String> s = [];
  TransactionItemInfoSheet itemInfo = TransactionItemInfoSheet();
  ValueNotifier<bool> visible = ValueNotifier(false);
  String? selectedtransaction;
  String? todaydate;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    date = DateFormat('dd-MM-yyyy kk:mm:ss').format(now);
    todaydate = DateFormat('dd-MM-yyyy').format(now);
    s = date!.split(" ");
    print("formmm-------${widget.form_type}");
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.form_type == "0"
              ? "Material Request History"
              : widget.form_type == "1"
                  ? "Material Return History"
                  : "",
          style: GoogleFonts.aBeeZee(
            textStyle: Theme.of(context).textTheme.bodyText2,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: P_Settings.buttonColor,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: P_Settings.loginPagetheme,
      ),
      body: Consumer<Controller>(builder: (context, value, child) {
        return Column(
          children: [
            Container(
              height: size.height * 0.08,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      onPressed: () {
                        // String df;
                        // String tf;
                        dateFind.selectDateFind(context, "from date");
                        // if (value.fromDate == null) {
                        //   df = todaydate.toString();
                        // } else {
                        //   df = value.fromDate.toString();
                        // }
                        // if (value.todate == null) {
                        //   tf = todaydate.toString();
                        // } else {
                        //   tf = value.todate.toString();
                        // }
                        // Provider.of<Controller>(context, listen: false)
                        //     .historyData(context, splitted[0], "",
                        //         df, tf);
                      },
                      icon: Icon(
                        Icons.calendar_month,
                        color: P_Settings.loginPagetheme,
                      )),
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Text(
                      value.fromDate == null
                          ? todaydate.toString()
                          : value.fromDate.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        dateFind.selectDateFind(context, "to date");
                      },
                      icon: Icon(Icons.calendar_month)),
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Text(
                      value.todate == null
                          ? todaydate.toString()
                          : value.todate.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                  Flexible(
                      child: Container(
                    height: size.height * 0.05,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: P_Settings.loginPagetheme,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(2), // <-- Radius
                          ),
                        ),
                        onPressed: () {
                          String df;
                          String tf;

                          if (value.fromDate == null) {
                            df = todaydate.toString();
                          } else {
                            df = value.fromDate.toString();
                          }
                          if (value.todate == null) {
                            tf = todaydate.toString();
                          } else {
                            tf = value.todate.toString();
                          }

                          Provider.of<Controller>(context, listen: false)
                              .historyData(
                                  context, "", df, tf, widget.form_type);
                        },
                        child: Text(
                          "Apply",
                          style: GoogleFonts.aBeeZee(
                            textStyle: Theme.of(context).textTheme.bodyText2,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: P_Settings.buttonColor,
                          ),
                        )),
                  ))
                ],
              ),
              // dropDownCustom(size,""),
            ),
            Divider(),
            value.isLoading
                ? SpinKitFadingCircle(
                    color: P_Settings.loginPagetheme,
                  )
                : value.historyList.length == 0
                    ? Center(
                        child: Container(
                            height: size.height * 0.2,
                            child: Lottie.asset(
                              'asset/historyjson.json',
                              // height: size.height*0.3,
                              // width: size.height*0.3,
                            )),
                      )
                    : Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: value.historyList.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: ListTile(
                                onTap: () {
                                  Provider.of<Controller>(context,
                                          listen: false)
                                      .getStatus(
                                          value.historyList[index]['req_id'],
                                          context);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CustomStepper(
                                              reqId: value.historyList[index]
                                                  ['series'],
                                            )),
                                  );
                                },
                                trailing: Wrap(
                                  spacing: 10,
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          Provider.of<Controller>(context,
                                                  listen: false)
                                              .getRequestinfoList(
                                                  context,
                                                  value.historyList[index]
                                                      ['req_id'],
                                                  "");
                                          itemInfo.showInfoSheet(context);
                                        },
                                        icon: Icon(Icons.info)),
                                  ],
                                ),
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Row(
                                        children: [
                                          Text(
                                            "Series : ",
                                            style: GoogleFonts.aBeeZee(
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2,
                                              fontSize: 14,
                                              // fontWeight: FontWeight.bold,
                                              color: P_Settings.historyPageText,
                                            ),
                                          ),
                                          Flexible(
                                            child: Text(
                                              "${value.historyList[index]['series']} ",
                                              style: GoogleFonts.aBeeZee(
                                                textStyle: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color:
                                                    P_Settings.historyPageText,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Text(
                                            "Date:",
                                            style: GoogleFonts.aBeeZee(
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2,
                                              fontSize: 14,
                                              // fontStyle: FontStyle.italic,
                                              // fontWeight: FontWeight.bold,
                                              color: Colors.red,
                                            ),
                                          ),
                                          Flexible(
                                            child: Text(
                                              "${value.historyList[index]['entry_date']}",
                                              style: GoogleFonts.aBeeZee(
                                                textStyle: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2,
                                                fontSize: 15,
                                                // fontStyle: FontStyle.italic,
                                                // fontWeight: FontWeight.bold,
                                                color: Colors.red,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: size.height * 0.03,
                                    ),
                                  ],
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Item Count : ",
                                            style: GoogleFonts.aBeeZee(
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2,
                                              fontSize: 13,
                                              // fontWeight: FontWeight.bold,
                                              color: P_Settings.historyPageText,
                                            ),
                                          ),
                                          Text(
                                            "${value.historyList[index]['item_count']}",
                                            style: GoogleFonts.aBeeZee(
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: P_Settings.historyPageText,
                                            ),
                                          ),
                                        ],
                                      ),
                                      InkWell(
                                          onTap: () {
                                            Provider.of<Controller>(context,
                                                    listen: false)
                                                .getStatus(
                                                    value.historyList[index]
                                                        ['req_id'],
                                                    context);
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      CustomStepper(
                                                        reqId: value
                                                                .historyList[
                                                            index]['series'],
                                                      )),
                                            );
                                          },
                                          child: Container(
                                            color: Colors.yellow,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Track Order",
                                                    style: TextStyle(
                                                        color: Colors.grey[800],
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      )
          ],
        );
      }),
    );
  }
}
