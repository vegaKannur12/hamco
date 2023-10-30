import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hamco/components/commonColor.dart';
import 'package:hamco/controller/controller.dart';

import 'package:lottie/lottie.dart';

import 'package:provider/provider.dart';

class SearchBottomSheet {
  // TextEditingController searchcontroller = TextEditingController();
  // TextEditingController qtycontroller = TextEditingController();
  String? oldText;
  showsearchSheet(
      BuildContext context, Size size, String form_type, String to_branch_id) {
    print("formtype---$form_type");
    return showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        // String imgGlobal = Globaldata.imageurl;
        return Consumer<Controller>(
          builder: (context, value, child) {
            // value.qty[index].text=qty.toString();

            return Container(
              // height: size.height * 0.6,
              child: SingleChildScrollView(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                                onPressed: () async {
                                  Provider.of<Controller>(context,
                                          listen: false)
                                      .getbagData1(context, "search page",
                                          "save", form_type, to_branch_id);
                                  Navigator.pop(context);
                                },
                                icon: Icon(Icons.close))
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: size.width * 0.9,
                              height: size.height * 0.09,
                              child: TextField(
                                controller: value.searchcontroller,
                                onChanged: (values) {
                                  Provider.of<Controller>(context,
                                          listen: false)
                                      .setisVisible(true);
                                  // values = value.searchcontroller.text;
                                  if (values != null || values.isNotEmpty) {
                                    // print("value-----$value");
                                    Provider.of<Controller>(context,
                                            listen: false)
                                        .setIssearch(true);
                                    // value = searchcontroll.text;
                                    print("valuess----$values");
                                    if (form_type == "0") {
                                      Provider.of<Controller>(context,
                                              listen: false)
                                          .searchItem(
                                              context, values, to_branch_id);
                                    } else {
                                      Provider.of<Controller>(context,
                                              listen: false)
                                          .searchStockReturnItem(
                                              context, values, to_branch_id);
                                    }
                                  } else {
                                    Provider.of<Controller>(context,
                                            listen: false)
                                        .setIssearch(false);
                                  }
                                },
                                decoration: InputDecoration(
                                  hintText: "Search Item here",
                                  prefixIcon: Icon(
                                    Icons.search,
                                    color: P_Settings.loginPagetheme,
                                  ),
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      value.searchcontroller.clear();
                                    },
                                    child: Icon(
                                      Icons.close,
                                      color: P_Settings.loginPagetheme,
                                    ),
                                  ),
                                  hintStyle: TextStyle(
                                      fontSize: 14.0, color: Colors.grey),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: P_Settings.loginPagetheme),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromARGB(255, 94, 95, 94)),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                            height: size.height * 0.4,
                            child: value.isSearchLoading
                                ? SpinKitCircle(
                                    color: P_Settings.loginPagetheme,
                                  )
                                // : value.searchList.length == 0
                                //     ? Text("No Item Found!!!")
                                : value.searchList.length == 0
                                    ? Container(
                                        // height: size.height * 0.05,

                                        // child: Text("No Data Found !!!"),
                                        child: Lottie.asset(
                                        'asset/search1.json',
                                        height: size.height * 0.2,
                                        width: size.height * 0.2,
                                      ))
                                    : ListView.builder(
                                        itemCount: value.searchList.length,
                                        itemBuilder: (context, index) {
                                          return ListTile(
                                              // trailing: Wrap(
                                              //   children: [

                                              //   ],
                                              // ),
                                              onTap: () {
                                                // Provider.of<Controller>(context,
                                                //         listen: false)
                                                //     .addDeletebagItem(
                                                //         value.searchList[index]["item_id"],
                                                //         value.searchList[index]["s_rate_1"]
                                                //             .toString(),
                                                //         value.searchList[index]["s_rate_2"]
                                                //             .toString(),
                                                //         "1",
                                                //         "0",
                                                //         "0",
                                                //         context,
                                                //         "save");
                                              },
                                              title: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Flexible(
                                                    child: Text(
                                                      value.searchList[index]
                                                          ["item_name"],
                                                      style:
                                                          GoogleFonts.aBeeZee(
                                                              textStyle: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyText2,
                                                              fontSize: 16,
                                                              // fontWeight: FontWeight.bold,
                                                              color: P_Settings
                                                                  .loginPagetheme),
                                                    ),
                                                  ),
                                                  Wrap(children: [
                                                    Container(
                                                      width: size.width * 0.12,
                                                      child: TextField(
                                                        controller:
                                                            value.qtycontroller[
                                                                index],
                                                        style:
                                                            GoogleFonts.aBeeZee(
                                                          textStyle:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyText2,
                                                          fontSize: 17,
                                                          color: P_Settings
                                                              .loginPagetheme,
                                                        ),
                                                        decoration:
                                                            InputDecoration(
                                                          isDense: true,
                                                          contentPadding:
                                                              EdgeInsets.all(0),
                                                          //border: InputBorder.none
                                                        ),
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        onTap: () {
                                                          value
                                                                  .qtycontroller[
                                                                      index]
                                                                  .selection =
                                                              TextSelection(
                                                                  baseOffset: 0,
                                                                  extentOffset: value
                                                                      .qtycontroller[
                                                                          index]
                                                                      .value
                                                                      .text
                                                                      .length);
                                                        },
                                                        onChanged: (values) {
                                                          print(
                                                              "ol;dText------${oldText}");
                                                          // Provider.of<Controller>(
                                                          //       context,
                                                          //       listen: false).justFun(values){

                                                          //       }
                                                          // values = value
                                                          //     .qtycontroller[index]
                                                          //     .text;
                                                          print(
                                                              "hjdhszjk---$values");
                                                          if (oldText != null) {
                                                            if (values.length !=
                                                                oldText!
                                                                    .length) {
                                                              Provider.of<Controller>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                                  .addToCartClicked(
                                                                      false,
                                                                      index);
                                                            }
                                                          }
                                                        },
                                                        onSubmitted:
                                                            (values) async {
                                                          oldText = values;
                                                          print(
                                                              "oldd----$oldText");
                                                          //   Provider.of<Controller>(
                                                          //           context,
                                                          //           listen: false)
                                                          //       .addToCartClicked(
                                                          //           true, index);
                                                          //  Provider.of<Controller>(
                                                          //                   context,
                                                          //                   listen:
                                                          //                       false)
                                                          //               .rawCalculation(
                                                          //                   double
                                                          //                       .parse(
                                                          //                     value.searchList[index]
                                                          //                         [
                                                          //                         "s_rate_fix"],
                                                          //                   ),
                                                          //                   double.parse(value
                                                          //                       .qtycontroller[
                                                          //                           index]
                                                          //                       .text),
                                                          //                   double.parse(value
                                                          //                       .discount_prercent[
                                                          //                           index]
                                                          //                       .text),
                                                          //                   double.parse(value
                                                          //                       .discount_amount[
                                                          //                           index]
                                                          //                       .text),
                                                          //                   double.parse(
                                                          //                       value.searchList[index]
                                                          //                           [
                                                          //                           "gst"]),
                                                          //                   double.parse(
                                                          //                       value.searchList[index]
                                                          //                           ["cess"]),
                                                          //                   "0",
                                                          //                   int.parse(gtype),
                                                          //                   index,
                                                          //                   false,
                                                          //                   "");

                                                          //           Provider.of<Controller>(
                                                          //                   context,
                                                          //                   listen:
                                                          //                       false)
                                                          //               .addDeletebagItem(
                                                          //                   "0",
                                                          //                   value.searchList[index]
                                                          //                       [
                                                          //                       "batch_id"],
                                                          //                   value.searchList[index]
                                                          //                       [
                                                          //                       "s_rate_fix"],
                                                          //                   value
                                                          //                       .qtycontroller[
                                                          //                           index]
                                                          //                       .text,
                                                          //                   context,
                                                          //                   "save",
                                                          //                   formType,
                                                          //                   value
                                                          //                       .gross,
                                                          //                   double.parse(value
                                                          //                       .discount_prercent[
                                                          //                           index]
                                                          //                       .text),
                                                          //                   double.parse(value
                                                          //                       .discount_amount[
                                                          //                           index]
                                                          //                       .text),
                                                          //                   0.0,
                                                          //                   value
                                                          //                       .cgst_amt,
                                                          //                   value
                                                          //                       .sgst_amt,
                                                          //                   value.igst_amt,
                                                          //                   value.cgst_per,
                                                          //                   value.sgst_per,
                                                          //                   value.igst_per,
                                                          //                   double.parse(
                                                          //                     value.searchList[index]
                                                          //                         [
                                                          //                         "cess"],
                                                          //                   ),
                                                          //                   value.cess,
                                                          //                   value.net_amt,
                                                          //                   double.parse(value.searchList[index]["gst"]),
                                                          //                   "0",
                                                          //                   "");
                                                        },
                                                        textAlign:
                                                            TextAlign.right,
                                                      ),
                                                    ),

                                                    // SizedBox(
                                                    //   width: size.width * 0.04,
                                                    // ),
                                                    value.addtoCart[index] ==
                                                            true
                                                        ? Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 28.0),
                                                            child: Icon(
                                                              Icons.done,
                                                              color:
                                                                  Colors.green,
                                                            ),
                                                          )
                                                        : Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 28.0),
                                                            child: GestureDetector(
                                                                onTap: () async {
                                                                  oldText = value
                                                                      .qtycontroller[
                                                                          index]
                                                                      .text;
                                                                  if (form_type ==
                                                                      "1") {
                                                                    if (value.qtycontroller[index].text !=
                                                                            null &&
                                                                        value
                                                                            .qtycontroller[index]
                                                                            .text
                                                                            .isNotEmpty) {
                                                                      if (double.parse(value
                                                                              .qtycontroller[
                                                                                  index]
                                                                              .text) >
                                                                          double.parse(value.searchList[index]
                                                                              [
                                                                              "stock"])) {
                                                                        value.errorClicked[index] =
                                                                            true;
                                                                        value
                                                                            .qtycontroller[
                                                                                index]
                                                                            .text = value
                                                                                .searchList[index]
                                                                            [
                                                                            "stock"];
                                                                      } else {
                                                                        Provider.of<Controller>(context, listen: false).addToCartClicked(
                                                                            true,
                                                                            index);

                                                                        Provider.of<Controller>(context, listen: false).addDeletebagItem(
                                                                            value.searchList[index]["item_id"],
                                                                            value.searchList[index]["s_rate_1"],
                                                                            value.searchList[index]["s_rate_2"],
                                                                            value.qtycontroller[index].text,
                                                                            "0",
                                                                            "0",
                                                                            context,
                                                                            "save",
                                                                            "",
                                                                            form_type,
                                                                            to_branch_id);
                                                                      }
                                                                    }
                                                                  } else {
                                                                    if (value.qtycontroller[index].text !=
                                                                            null &&
                                                                        value
                                                                            .qtycontroller[index]
                                                                            .text
                                                                            .isNotEmpty) {
                                                                      Provider.of<Controller>(
                                                                              context,
                                                                              listen:
                                                                                  false)
                                                                          .addToCartClicked(
                                                                              true,
                                                                              index);

                                                                      Provider.of<Controller>(context, listen: false).addDeletebagItem(
                                                                          value.searchList[index]
                                                                              [
                                                                              "item_id"],
                                                                          value.searchList[index]
                                                                              [
                                                                              "s_rate_1"],
                                                                          value.searchList[index]
                                                                              [
                                                                              "s_rate_2"],
                                                                          value
                                                                              .qtycontroller[index]
                                                                              .text,
                                                                          "0",
                                                                          "0",
                                                                          context,
                                                                          "save",
                                                                          "",
                                                                          form_type,
                                                                          to_branch_id);
                                                                    }
                                                                  }
                                                                },

                                                                // await Provider.of<
                                                                //             Controller>(
                                                                //         context,
                                                                //         listen: false)
                                                                //     .getbagData1(
                                                                //         context, "");

                                                                child: Icon(Icons.add)),
                                                          ),
                                                  ])
                                                ],
                                              ),
                                              subtitle: 
                                                   Row(
                                                      // mainAxisAlignment:
                                                      //     MainAxisAlignment
                                                      //         .spaceBetween,
                                                      children: [
                                                        // Text(
                                                        //     "SRate1 :${value.searchList[index]["s_rate_1"]}"),
                                                        // Text(
                                                        //     "SRate2 :${value.searchList[index]["s_rate_2"]}"),
                                                        Text(
                                                            "Stock :${value.searchList[index]["stock"]}")
                                                      ],
                                                    )
                                                  );
                                        },
                                      ))
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
