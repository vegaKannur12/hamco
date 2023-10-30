import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hamco/components/commonColor.dart';
import 'package:hamco/components/customSnackbar.dart';
import 'package:hamco/components/globaldata.dart';
import 'package:hamco/controller/controller.dart';

import 'package:provider/provider.dart';
import 'package:photo_view/photo_view.dart';

class TransactionItemInfoSheet {
  showInfoSheet(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String? payment_mode;
    CustomSnackbar snackbar = CustomSnackbar();
    String imgGlobal = Globaldata.imageurl;

    // CommonPopup salepopup = CommonPopup();
    return showModalBottomSheet<void>(
      // isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Consumer<Controller>(
          builder: (context, value, child) {
            if (value.isListLoading) {
              return Container(
                  height: 200,
                  child: SpinKitCircle(
                    color: P_Settings.loginPagetheme,
                  ));
            } else {
              return SingleChildScrollView(
                physics: ScrollPhysics(),
                // scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Item Info :",
                            style: GoogleFonts.aBeeZee(
                              textStyle: Theme.of(context).textTheme.bodyText2,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: P_Settings.loginPagetheme,
                            ),
                          ),
                          Spacer(),
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(Icons.close))
                        ],
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: value.transaction_item_info.length,
                      itemBuilder: (context, index) {
                        return ListTile(
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
                          shape: Border(
                            bottom: BorderSide(
                                width: 0.4,
                                color: Color.fromARGB(255, 121, 117, 117)),
                          ),
                          // visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Flexible(
                                child: Text(
                                  "${value.transaction_item_info[index]["item_name"]}",
                                  style: GoogleFonts.aBeeZee(
                                      textStyle:
                                          Theme.of(context).textTheme.bodyText2,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey[700]
                                      // color: value.stockList[index]
                                      //             ["st"] ==
                                      //         "0"
                                      //     ? Colors.grey[600]
                                      //     : Colors.red,
                                      ),
                                ),
                              ),
                            ],
                          ),
                          subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Qty : ${value.transaction_item_info[index]["qty"]}",
                                style: GoogleFonts.aBeeZee(
                                    textStyle:
                                        Theme.of(context).textTheme.bodyText2,
                                    fontSize: 14,
                                    color: Colors.grey[600]
                                    // fontWeight: FontWeight.bold,
                                    ),
                              ),
                              // Text(
                              //   "SRate1 : ${value.transaction_item_info[index]["s_rate_1"]}",
                              //   style: GoogleFonts.aBeeZee(
                              //       textStyle:
                              //           Theme.of(context).textTheme.bodyText2,
                              //       fontSize: 14,
                              //       color: Colors.grey[600]
                              //       // fontWeight: FontWeight.bold,
                              //       ),
                              // ),
                              // Text(
                              //   "SRate2 : ${value.transaction_item_info[index]["s_rate_2"]}",
                              //   style: GoogleFonts.aBeeZee(
                              //       textStyle:
                              //           Theme.of(context).textTheme.bodyText2,
                              //       fontSize: 14,
                              //       color: Colors.grey[600]
                              //       // fontWeight: FontWeight.bold,
                              //       ),
                              // ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            }
          },
        );
      },
    );
  }
}
