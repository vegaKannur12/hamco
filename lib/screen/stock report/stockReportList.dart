import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hamco/components/commonColor.dart';
import 'package:hamco/components/customSnackbar.dart';
import 'package:hamco/controller/controller.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

// class StockReportList extends StatefulWidget {
//   List<Map<String, dynamic>> list;

//   StockReportList({
//     required this.list,
//   });

//   @override
//   State<StockReportList> createState() => _StockReportListState();
// }

// class _StockReportListState extends State<StockReportList> {
//   String? selected;
//   String? selecteditem;

//   String? hint;
//   List splitted = [];
//   List<_AZItem> items = [];
//   List<String> uniqueList = [];
//   // Bottomsheet showsheet = Bottomsheet();
//   // InfoBottomsheet infoshowsheet = InfoBottomsheet();
//   String? staff_id;
//   var itemstest = [
//     'kg',
//     'pcs',
//   ];
//   // List<String> items = [];
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     print("dgjxfkjgkg-----${widget.list}");
//     // hint = Provider.of<Controller>(context, listen: false).dropdwnVal;
//     // hint = widget.hint;
//     print("nzkjnjkdzfn----$hint");
//     // initList(widget.list);
//   }

// /////////////////////////////////////
//   void initList(List<Map<String, dynamic>> items) {
//     print("cjncn----${items}");
//     this.items = items
//         .map(
//           (item) => _AZItem(
//             tag: item["item_name"][0].toUpperCase(),
//             itemId: item["item_id"],
//             itemName: item["item_name"].toUpperCase(),
//             itemCode: item["item_code"],
//             rate: item["rate"],
//             stock: item["stock"],
//           ),
//         )
//         .toList();
//     SuspensionUtil.sortListBySuspensionTag(this.items);
//     SuspensionUtil.setShowSuspensionStatus(this.items);
//     setState(() {});
//   }

//   // void setBarData(List<Map<String, dynamic>> items) {
//   //   print("cjncn----${items}");
//   //   this.items = items
//   //       .map(
//   //         (item) => _AZItem(
//   //           title: item["item"].toUpperCase(),
//   //           tag: item["item"][0].toUpperCase(),
//   //         ),
//   //       )
//   //       .toList();
//   //   SuspensionUtil.sortListBySuspensionTag(this.items);
//   //   SuspensionUtil.setShowSuspensionStatus(this.items);
//   //   setState(() {});
//   // }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;

//     return Scaffold(
//         resizeToAvoidBottomInset: false,
//         appBar: AppBar(),
//         // appBar: AppBar(
//         //   leading: IconButton(
//         //       onPressed: () {
//         //         Provider.of<Controller>(context, listen: false)
//         //             .setfilter(false);
//         //         Navigator.pop(context);
//         //       },
//         //       icon: Icon(Icons.arrow_back)),
//         //   backgroundColor: P_Settings.loginPagetheme,
//         // ),
//         body: Consumer<Controller>(
//           builder: (context, value, child) {
//             // selected="dkjszdnkj";
//             print("value.dropdwn-------${value.dropdwnString}");
//             if (value.isLoading) {
//               return SpinKitFadingCircle(
//                 color: P_Settings.loginPagetheme,
//               );
//             } else {
//               return Column(
//                 children: [
//                   dropDownSite(size),
//                   SizedBox(
//                     height: size.height * 0.02,
//                   ),
//                   // Container(
//                   //   width: size.width * 0.9,
//                   //   decoration: BoxDecoration(
//                   //     borderRadius: BorderRadius.circular(10.0),
//                   //     border: Border.all(
//                   //         color: P_Settings.loginPagetheme,
//                   //         style: BorderStyle.solid,
//                   //         width: 0.3),
//                   //   ),
//                   //   child: DropdownButton<String>(
//                   //     isExpanded: true,
//                   //     value: selected,
//                   //     // value: selected,
//                   //     // isDense: true,
//                   //     hint: Padding(
//                   //       padding: const EdgeInsets.all(8.0),
//                   //       child: Text(value.dropdwnString == null ||
//                   //               value.dropdwnString!.isEmpty
//                   //           ? value.dropdwnVal.toString()
//                   //           : value.dropdwnString.toString()),
//                   //     ),
//                   //     // isExpanded: true,
//                   //     autofocus: false,
//                   //     underline: SizedBox(),
//                   //     elevation: 0,
//                   //     items: value.itemCategoryList
//                   //         .map((item) => DropdownMenuItem<String>(
//                   //             value: "${item.catId},${item.catName}",
//                   //             child: Container(
//                   //               width: size.width * 0.9,
//                   //               child: Padding(
//                   //                 padding: const EdgeInsets.all(8.0),
//                   //                 child: Text(
//                   //                   item.catName.toString(),
//                   //                   style: TextStyle(fontSize: 14),
//                   //                 ),
//                   //               ),
//                   //             )))
//                   //         .toList(),
//                   //     onChanged: (item) {
//                   //       print("clicked");
//                   //       if (item != null) {
//                   //         setState(() {
//                   //           selected = item;
//                   //         });
//                   //         splitted = selected!.split(',');
//                   //         print("splitted---$splitted");
//                   //         // Provider.of<Controller>(context, listen: false)
//                   //         //     .filterProduct(selected!);
//                   //         print("se;ected---$item");
//                   //       }
//                   //       Provider.of<Controller>(context, listen: false)
//                   //           .getProductDetails(splitted[0], splitted[1]);
//                   //     },
//                   //   ),
//                   // ),
//                   // Divider(),
//                   Expanded(child: Consumer<Controller>(
//                     builder: (context, value, child) {
//                       if (value.isLoading) {
//                         return SpinKitCircle(
//                           color: P_Settings.loginPagetheme,
//                         );
//                       } else {
//                         if (items.length == 0) {
//                           return Center(
//                               child: Container(
//                                   height: size.height * 0.2,
//                                   child: Lottie.asset(
//                                     'asset/returnListempty.json',
//                                     // height: size.height*0.3,
//                                     // width: size.height*0.3,
//                                   )));
//                         } else {

//                           print("item----------$items");
//                           return AzListView(
//                             data: items,
//                             itemCount: items.length,
//                             itemBuilder: (context, index) {
//                               final item = items[index];
//                               print("itemmmm------$item");
//                               return buildListitem(item, size, index);
//                             },
//                             indexHintBuilder: (context, tag) {
//                               return Container(
//                                 alignment: Alignment.center,
//                                 width: 60,
//                                 height: 60,
//                                 decoration: BoxDecoration(
//                                     color: Colors.blue, shape: BoxShape.circle),
//                                 child: Text(
//                                   tag,
//                                   style: TextStyle(
//                                       color: Colors.white, fontSize: 50),
//                                 ),
//                               );
//                             },
//                             indexBarMargin: EdgeInsets.all(10),
//                             indexBarAlignment: Alignment.centerLeft,
//                             indexBarItemHeight: 30,
//                             indexBarData: value.uniquelist,
//                             indexBarOptions: IndexBarOptions(
//                               needRebuild: true,
//                               selectTextStyle: TextStyle(
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.bold),
//                               selectItemDecoration: BoxDecoration(
//                                   shape: BoxShape.circle, color: Colors.blue),
//                               indexHintAlignment: Alignment.centerRight,
//                               indexHintOffset: Offset(-20, 0),
//                             ),
//                           );
//                         }
//                       }
//                       print("value------${items}");
//                     },
//                   ))
//                   // Expanded(
//                   //   child: AlphabetScrollPage(
//                   //       onClickedItem: (item) {
//                   //         final snackbar = SnackBar(
//                   //             content: Text(
//                   //           "Clicked Item  $item",
//                   //           style: TextStyle(fontSize: 20),
//                   //         ));
//                   //         ScaffoldMessenger.of(context)
//                   //           ..removeCurrentSnackBar()
//                   //           ..showSnackBar(snackbar);
//                   //       },
//                   //       items: value.filter
//                   //           ? value.filteredproductList
//                   //           : widget.list),
//                   // ),
//                 ],
//               );
//             }
//           },
//         ));
//   }

//   Widget buildListitem(_AZItem item, Size size, int index) {
//     double topInsets = MediaQuery.of(context).viewInsets.top;
//     CustomSnackbar snackbar = CustomSnackbar();

//     final offStage = item.isShowSuspension;
//     return Column(
//       children: [
//         // Offstage(offstage: offStage, child: buildHeader(tag)),
//         Consumer<Controller>(
//           builder: (context, value, child) {
//             return Column(
//               children: [
//                 Container(
//                   decoration: BoxDecoration(
//                     border: Border(
//                       bottom: BorderSide(
//                           width: 1,
//                           color: value.errorClicked[index]
//                               ? Colors.red
//                               : Colors.grey),
//                     ),
//                   ),
//                   // height: size.height * 0.08,
//                   margin: EdgeInsets.only(left: 40),
//                   child: ListTile(
//                     title: Text(item.itemName!,
//                         // overflow: TextOverflow.ellipsis,
//                         style: GoogleFonts.aBeeZee(
//                           textStyle: Theme.of(context).textTheme.bodyText2,
//                           fontSize: 16,
//                           // fontWeight: FontWeight.bold,
//                           color: P_Settings.loginPagetheme,
//                         )),
//                     subtitle: Column(
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Container(child: Text("Stock : ${item.stock}")),
//                           ],
//                         ),
//                         // Row(
//                         //   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         //   children: [
//                         //     Flexible(
//                         //       child: Container(
//                         //           // width: size.width * 0.,
//                         //           child: Text("MOP:${item.sRate1},")),
//                         //     ),
//                         //     Flexible(
//                         //       child: Container(
//                         //           // width: size.width * 0.3,
//                         //           child: Text(" MRP:${item.sRate2},")),
//                         //     ),
//                         //     Flexible(
//                         //       child: Container(
//                         //           // width: size.width * 0.3,
//                         //           child: Text(" Stock:${item.stock}")),
//                         //     ),
//                         //     GestureDetector(
//                         //       onTap: () {
//                         //         Provider.of<Controller>(context, listen: false)
//                         //             .getinfoList(context, item.itemId!);
//                         //         infoshowsheet.showInfoSheet(
//                         //           context,
//                         //         );
//                         //       },
//                         //       child: Icon(
//                         //         Icons.info,
//                         //         size: 19,
//                         //       ),
//                         //     )
//                         //   ],
//                         // ),
//                       ],
//                     ),
//                     // onTap: () {
//                     //   value.setqtyErrormsg(false);

//                     //   showsheet.showSheet(
//                     //       context,
//                     //       index,
//                     //       item.itemId!,
//                     //       item.catId!,
//                     //       item.batchCode!,
//                     //       item.itemName!,
//                     //       item.itemImg!,
//                     //       double.parse(item.sRate1!),
//                     //       double.parse(item.sRate2!),
//                     //       double.parse(item.stock!),
//                     //       widget.transVal,
//                     //       value.qty[index].text);
//                     // }
//                     // widget.onClickedItem(item.title!),
//                   ),
//                 ),
//                 // value.errorClicked[index]
//                 //     ? Padding(
//                 //         padding: const EdgeInsets.only(top: 8.0),
//                 //         child: Container(
//                 //             alignment: Alignment.topCenter,
//                 //             child: Text("Return Qty should be less than Stock",
//                 //                 style: TextStyle(color: Colors.red))),
//                 //       )
//                 //     : Container(),
//               ],
//             );
//           },
//         ),
//       ],
//     );
//   }

//   Widget buildHeader(String tag) {
//     return Container(
//       height: 40,
//       margin: EdgeInsets.only(right: 18),
//       padding: EdgeInsets.only(left: 18),
//       color: Colors.grey,
//       alignment: Alignment.centerLeft,
//       child: Text(
//         "$tag",
//         // softWrap: false,
//         style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//       ),
//     );
//   }

//   Widget dropDownSite(Size size) {
//     return Consumer<Controller>(
//       builder: (context, value, child) {
//         return Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Container(
//             width: size.height * 0.41,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(5.0),
//               border: Border.all(
//                   color: Colors.black, style: BorderStyle.solid, width: 0.5),
//             ),
//             child: DropdownButton<String>(
//               isExpanded: true,
//               value: value.selected,
//               // isDense: true,
//               hint: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Text(
//                   "select project",
//                   style: GoogleFonts.aBeeZee(
//                     textStyle: Theme.of(context).textTheme.bodyText2,
//                     fontSize: 14,
//                     // fontWeight: FontWeight.bold,
//                     color: Colors.grey[800],
//                   ),
//                 ),
//               ),
//               autofocus: true,
//               underline: SizedBox(),
//               elevation: 0,
//               items: value.siteList
//                   .map((item) => DropdownMenuItem<String>(
//                       value: item["UID"].toString(),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Text(
//                               item["branch"].toString(),
//                               style: TextStyle(fontSize: 14),
//                             ),
//                           ),
//                         ],
//                       )))
//                   .toList(),
//               onChanged: (item) async {
//                 print("clicked");
//                 if (item != null) {
//                   setState(() {
//                     value.selected = item;
//                   });
//                   List<Map<String, dynamic>>? list =await Provider.of<Controller>(context, listen: false)
//                           .getStockReportList(context, value.selected!) ;
//                   print("nkkzjsn-0---${value.stockReportList}");
//                   initList(value.stockReportList);
//                 }
//               },
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// class _AZItem extends ISuspensionBean {
//   String? tag;
//   String? itemId;
//   String? itemName;
//   String? itemCode;
//   String? rate;
//   String? stock;

//   _AZItem(
//       {this.tag,
//       this.itemId,
//       this.itemName,
//       this.itemCode,
//       this.rate,
//       this.stock});

//   @override
//   String getSuspensionTag() => tag!;
// }
///////////////////////////////////////////////////////////
class StockReportList extends StatefulWidget {
  String? title;
  StockReportList({this.title});

  @override
  State<StockReportList> createState() => _StockReportListState();
}

class _StockReportListState extends State<StockReportList> {
  // String? selected;

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
          return Column(
            children: [
              dropDownSite(size),
              Divider(),
              value.isLoading
                  ? Expanded(
                      child: SpinKitCircle(
                        color: P_Settings.loginPagetheme,
                      ),
                    )
                  : value.stockReportList.length == 0
                      ? Expanded(
                          child: Center(
                              child: Container(
                                  height: size.height * 0.2,
                                  child: Lottie.asset(
                                    'asset/returnListempty.json',
                                    // height: size.height*0.3,
                                    // width: size.height*0.3,
                                  ))),
                        )
                      : Expanded(
                          child: ListView.builder(
                            itemCount: value.stockReportList.length,
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
                                title: Row(
                                  children: [
                                    Flexible(
                                      child: Text(
                                          value.stockReportList[index]
                                              ["item_name"],
                                          // overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.aBeeZee(
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .bodyText2,
                                            fontSize: 16,
                                            // fontWeight: FontWeight.bold,
                                            color: P_Settings.loginPagetheme,
                                          )),
                                    ),
                                    Flexible(
                                      child: Text(
                                          "  (${value.stockReportList[index]["item_code"]})",
                                          // overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.aBeeZee(
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .bodyText2,
                                            fontSize: 16,
                                            // fontWeight: FontWeight.bold,
                                            color: Colors.grey,
                                          )),
                                    ),
                                  ],
                                ),
                                subtitle: Row(
                                  children: [
                                    Flexible(
                                      child: Text(
                                          "Stock : ${value.stockReportList[index]["stock"]}",
                                          // overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.aBeeZee(
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2,
                                              fontSize: 16,
                                              color: Colors.grey[600]
                                              // fontWeight: FontWeight.bold,
                                              // color: P_Settings.loginPagetheme,
                                              )),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
            ],
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
              value: value.selected,
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
                    value.selected = item;
                  });
                  Provider.of<Controller>(context, listen: false)
                      .getStockReportList(context, value.selected!);
                }
              },
            ),
          ),
        );
      },
    );
  }
}
