
import "package:flutter/material.dart";
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hamco/components/commonColor.dart';

import 'package:hamco/screen/stock%20report/stockReportList.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../controller/controller.dart';

class StockReport extends StatefulWidget {
  String title;
 StockReport({required this.title});

  @override
  State<StockReport> createState() => _StockReportState();
}

class _StockReportState extends State<StockReport> {
  String? selected;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      
      appBar: AppBar(
        title: Text(widget.title.toString(),style: TextStyle(fontSize: 17),),
        backgroundColor: P_Settings.loginPagetheme,
      ),
      body: Consumer<Controller>(
        builder: (context, value, child) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                dropDownSite(size),
                Divider(),
                Expanded(
                  child: value.isProdLoading
                      ? SpinKitCircle(
                          color: P_Settings.loginPagetheme,
                        )
                      : value.stockItemSelection.length == 0
                          ? Center(
                              child: Container(
                                  height: size.height * 0.2,
                                  child: Lottie.asset(
                                    'asset/returnListempty.json',
                                    // height: size.height*0.3,
                                    // width: size.height*0.3,
                                  )))
                          : StockReportList(
                              title: "",
                            ),
                )
                // Expanded(
                //   child: value.isProdLoading
                //       ? SpinKitCircle(
                //           color: P_Settings.loginPagetheme,
                //         )
                //       : value.stockReturnList.length == 0
                //           ? Center(
                //               child: Container(
                //                   height: size.height * 0.2,
                //                   child: Lottie.asset(
                //                     'asset/returnListempty.json',
                //                     // height: size.height*0.3,
                //                     // width: size.height*0.3,
                //                   )),
                //             )
                //           : ListView.builder(
                //               itemCount: value.stockReturnList.length,
                //               itemBuilder: (context, index) {
                //                 return Card(
                //                   child: ListTile(
                //                     title: Row(
                //                       mainAxisAlignment: MainAxisAlignment.center,
                //                       children: [
                //                         Flexible(
                //                           child: Text(
                //                             value.stockReturnList[index].itemName
                //                                 .toString(),
                //                             style: GoogleFonts.aBeeZee(
                //                                 textStyle: Theme.of(context)
                //                                     .textTheme
                //                                     .bodyText2,
                //                                 fontSize: 14,
                //                                 color: P_Settings.bagText,
                //                                 fontWeight: FontWeight.bold),
                //                           ),
                //                         )
                //                       ],
                //                     ),
                //                     subtitle: Row(
                //                       mainAxisAlignment:
                //                           MainAxisAlignment.spaceBetween,
                //                       children: [
                //                         Row(
                //                           children: [
                //                             Text(
                //                               "Stock :",
                //                               style: GoogleFonts.aBeeZee(
                //                                 textStyle: Theme.of(context)
                //                                     .textTheme
                //                                     .bodyText2,
                //                                 fontSize: 14,
                //                                 color: Colors.grey[600],
                //                               ),
                //                             ),
                //                             Text(
                //                               "${value.stockReturnList[index].stock.toString()}",
                //                               style: GoogleFonts.aBeeZee(
                //                                 fontWeight: FontWeight.bold,
                //                                 textStyle: Theme.of(context)
                //                                     .textTheme
                //                                     .bodyText2,
                //                                 fontSize: 14,
                //                                 color: Colors.grey[600],
                //                               ),
                //                             ),
                //                           ],
                //                         ),
                //                         Row(
                //                           children: [
                //                             Text(
                //                               "return Qty :",
                //                               style: GoogleFonts.aBeeZee(
                //                                 textStyle: Theme.of(context)
                //                                     .textTheme
                //                                     .bodyText2,
                //                                 fontSize: 14,
                //                                 color: Colors.grey[600],
                //                               ),
                //                             ),
                //                             Container(
                //                               width: size.width * 0.12,
                //                               child: FocusScope(
                //                                 // onFocusChange: (valuess) {
                //                                 //   double valueqty = 0.0;
                //                                 //   if (valuess == false) {
                //                                 //     Provider.of<Controller>(
                //                                 //             context,
                //                                 //             listen: false)
                //                                 //         .addDeletebagItem(
                //                                 //             value.bagList[index]
                //                                 //                 ["item_id"],
                //                                 //             value.bagList[index]
                //                                 //                     ["s_rate_1"]
                //                                 //                 .toString(),
                //                                 //             value.bagList[index]
                //                                 //                     ["s_rate_2"]
                //                                 //                 .toString(),
                //                                 //             value
                //                                 //                 .t2qtycontroller[
                //                                 //                     index]
                //                                 //                 .text,
                //                                 //             "0",
                //                                 //             "0",
                //                                 //             context,
                //                                 //             "save",
                //                                 //             "transaction2");
                //                                 //   }
                //                                 // },
                //                                 child: TextField(
                //                                   controller:
                //                                       value.returnQty[index],
                //                                   // autofocus: true,
                //                                   // onTap: () {
                //                                   //   value.t2qtycontroller[index].selection =
                //                                   //       TextSelection(
                //                                   //           baseOffset: 0,
                //                                   //           extentOffset: value
                //                                   //               .t2qtycontroller[index]
                //                                   //               .value
                //                                   //               .text
                //                                   //               .length);
                //                                   // },

                //                                   // autofocus: true,
                //                                   style: GoogleFonts.aBeeZee(
                //                                     textStyle: Theme.of(context)
                //                                         .textTheme
                //                                         .bodyText2,
                //                                     fontSize: 17,
                //                                     // fontWeight: FontWeight.bold,
                //                                     color:
                //                                         P_Settings.loginPagetheme,
                //                                   ),
                //                                   decoration: InputDecoration(
                //                                     isDense: true,
                //                                     contentPadding:
                //                                         EdgeInsets.all(0),
                //                                     //border: InputBorder.none
                //                                   ),

                //                                   // maxLines: 1,
                //                                   // minLines: 1,
                //                                   keyboardType:
                //                                       TextInputType.number,
                //                                   onSubmitted: (values) {
                //                                     double valueqty = 0.0;
                //                                     // Provider.of<Controller>(context,
                //                                     //         listen: false)
                //                                     //     .addDeletebagItem(
                //                                     //         value.bagList[index]["item_id"],
                //                                     //         value.bagList[index]["s_rate_1"]
                //                                     //             .toString(),
                //                                     //         value.bagList[index]["s_rate_2"]
                //                                     //             .toString(),
                //                                     //         value.t2qtycontroller[index]
                //                                     //             .text,
                //                                     //         "0",
                //                                     //         "0",
                //                                     //         context,
                //                                     //         "save",
                //                                     //         "transaction2");
                //                                   },

                //                                   textAlign: TextAlign.right,
                //                                   // controller: value.qty[index],
                //                                 ),
                //                               ),
                //                             ),
                //                           ],
                //                         )
                //                       ],
                //                     ),
                //                   ),
                //                 );
                //               },
                //             ),
                // ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget dropDownSite(Size size) {
    return Consumer<Controller>(
      builder: (context, value, child) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: size.height * 0.41,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              border: Border.all(
                  color: Colors.black, style: BorderStyle.solid, width: 0.5),
            ),
            child: DropdownButton<String>(
              isExpanded: true,
              value: selected,
              // isDense: true,
              hint: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "select project",
                  style: GoogleFonts.aBeeZee(
                    textStyle: Theme.of(context).textTheme.bodyText2,
                    fontSize: 14,
                    // fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
              ),
              autofocus: true,
              underline: SizedBox(),
              elevation: 0,
              items: value.siteList
                  .map((item) => DropdownMenuItem<String>(
                      value: item["UID"].toString(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              item["branch"].toString(),
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                        ],
                      )))
                  .toList(),
              onChanged: (item) {
                print("clicked");
                if (item != null) {
                  setState(() {
                    selected = item;
                  });
                  Provider.of<Controller>(context, listen: false)
                      .getStockReportList(context, selected!);
                }
              },
            ),
          ),
        );
      },
    );
  }
}
