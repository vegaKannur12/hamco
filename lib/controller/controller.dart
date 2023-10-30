import 'package:flutter/material.dart';
import 'package:hamco/components/commonColor.dart';
import 'package:hamco/components/globalData.dart';
import 'package:hamco/components/networkConnectivity.dart';
import 'package:hamco/model/branchModel.dart';
import 'package:hamco/model/deliveryListInfoModel.dart';
import 'package:hamco/model/deliveryListModel.dart';
import 'package:hamco/model/itemcategroy.dart';
import 'package:hamco/model/productListModel.dart';
import 'package:hamco/model/registrationModel.dart';
// import 'package:hamco/model/stockReportList.dart';
import 'package:hamco/model/transactionModel.dart';
import 'package:hamco/screen/dashboard/mainDashboard.dart';
import 'package:hamco/screen/stock%20Request/stockRequest.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

class Controller extends ChangeNotifier {
  // bool isVisible = false;
  bool? arrowButtonclicked;
  TextEditingController searchcontroller = TextEditingController();
  bool isSearchLoading = false;
  bool isSaveLoading = false;
  bool addtoDone = false;
  String? fromDate;
  String? selected;

  String? brName;
  String? series;
  String? deliveryListCount;
  List<bool> transinfohide = [];
  bool isVisible = false;
  bool isProdLoading = false;
  bool isSearch = false;
  bool isStatusLoad = false;
  bool damLoading = false;

  String? dropdwnVal;
  String? dropdwnString;

  String? todate;
  String urlgolabl = Globaldata.apiglobal;
  bool isLoading = false;
  bool isListLoading = false;

  bool qtyerror = false;
  bool stocktransferselected = false;
  // String? branch_id;
  String? staff_name;
  String? branch_name;
  String? branch_prefix;
  String? user_id;

  String? menu_index;
  List<Map<String, dynamic>> statusList = [];
  List<Map<String, dynamic>> menuList = [];
  List<Map<String, dynamic>> searchList = [];
  List<Map<String, dynamic>> transaction_item_info = [];

  List<Map<String, dynamic>> infoList = [];
  List<Map<String, dynamic>> damagedList = [];
  String? damagedListCount;
  List<DeliveryListInfoModel> dispatchedinfoList = [];

  List<DeliveryListModel> dispatchedList = [];
  List<Map<String, dynamic>> stock_approve_masterlist = [];
  List<Map<String, dynamic>> stock_approve_detaillist = [];

  List<Map<String, dynamic>> stockList = [];

  List<Map<String, dynamic>> transinfoList = [];
  List<Map<String, dynamic>> transiteminfoList = [];

  // String urlgolabl = Globaldata.apiglobal;
  bool filter = false;
  double? totalPrice;
  String? priceval;
  List<bool> errorClicked = [];
  List<TextEditingController> qty = [];
  List<TextEditingController> returnQty = [];

  List<TextEditingController> qtycontroller = [];
  List<TextEditingController> t2qtycontroller = [];

  List<TextEditingController> historyqty = [];
  List<TextEditingController> oldhistoryqty = [];
  List<bool> addtoCart = [];
  String? cartCount;
  int? cartCountInc;

  List<Map<String, dynamic>> productList = [];
  List<Map<String, dynamic>> stockReportList = [];

  List<Map<String, dynamic>> stockItemSelection = [];
  List<Map<String, dynamic>> copystockItemSelection = [];

  // List<StockReportListModel> stockReturnList = [];

  List<Map<String, dynamic>> bagList = [];
  List<Map<String, dynamic>> historyList = [];

  List<BranchModel> branchist = [];
  List<Map<String, dynamic>> siteList = [];

  List<ItemCategoryModel> itemCategoryList = [];

  List<Map<String, dynamic>> filteredproductList = [];

  List<String> productbar = [];
  List<String> reporttbar = [];

  List<String> filteredproductbar = [];

  int? qtyinc;

  List<CD> c_d = [];

  List<String> uniquelist = [];
  List<String> filtereduniquelist = [];

  ///////////////////////////////////////////////////////////////////////

  getItemCategory(BuildContext context) async {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          Uri url = Uri.parse("$urlgolabl/category_list.php");

          // isDownloaded = true;
          isLoading = true;
          // notifyListeners();

          http.Response response = await http.post(
            url,
          );
          ItemCategoryModel itemCategory;
          List map = jsonDecode(response.body);
          print("dropdwn------$map");
          productList.clear();
          productbar.clear();
          itemCategoryList.clear();
          for (var item in map) {
            itemCategory = ItemCategoryModel.fromJson(item);
            itemCategoryList.add(itemCategory);
          }

          dropdwnVal = itemCategoryList[0].catName.toString();
          notifyListeners();

          // notifyListeners();

          isLoading = false;
          notifyListeners();
          print("sdhjz-----$dropdwnVal");

          return dropdwnVal;
          /////////////// insert into local db /////////////////////
        } catch (e) {
          print(e);
          // return null;
          return [];
        }
      }
    });
  }

/////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////
  getSiteList(BuildContext context, String form_type) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // branch_id = prefs.getString("branch_id");
    user_id = prefs.getString("user_id");
    print("branch_id--------$user_id");
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          BranchModel brnachModel = BranchModel();
          Uri url = Uri.parse("$urlgolabl/login_branch.php");
          Map body = {'staff_id': user_id, 'form_type': form_type};

          // isDownloaded = true;
          isLoading = true;
          // notifyListeners();

          http.Response response = await http.post(
            url,
            body: body,
          );
          var map = jsonDecode(response.body);
          print("site map----$map");
          // SiteModel siteModel;
          siteList.clear();
          series = map["series"];
          for (var item in map["branch_list"]) {
            // siteModel = SiteModel.fromJson(item);
            siteList.add(item);
          }

          isLoading = false;
          notifyListeners();

          /////////////// insert into local db /////////////////////
        } catch (e) {
          print(e);
          // return null;
          return [];
        }
      }
    });
  }

  //////////////////////////////////////////////////////////////////////
  Future<List<Map<String, dynamic>>?> getStockReportList(
      BuildContext context, String site_id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // branch_id = prefs.getString("branch_id");
    user_id = prefs.getString("user_id");
    print("site_id--------$site_id");
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          // branch_id = prefs.getString("branch_id");
          staff_name = prefs.getString("staff_name");
          branch_name = prefs.getString("branch_name");
          branch_prefix = prefs.getString("branch_prefix");
          user_id = prefs.getString("user_id");
          print("kjn----------------$user_id-");
          Uri url = Uri.parse("$urlgolabl/sitewise_stock.php");

          Map body = {
            'branch_id': site_id,
          };
          print("body----${body}");
          // isDownloaded = true;
          isLoading = true;
          notifyListeners();

          http.Response response = await http.post(
            url,
            body: body,
          );

          isLoading = false;
          notifyListeners();

          print("body ${body}");

          var map = jsonDecode(response.body);

          print("stockReturnList map-------${map}");
          // stockReturnList.clear();
          stockReportList.clear();
          reporttbar.clear();
          for (var pro in map) {
            print("pro------$pro");
            reporttbar.add(pro["item_name"][0]);
            stockReportList.add(pro);
          }
          notifyListeners();
          print("phhhh--$reporttbar---$stockReportList");
          // // for (var returnitem in map) {
          // //   stockReturnListModel = StockReportListModel.fromJson(returnitem);
          // //   stockReturnList.add(stockReturnListModel);
          // //   productbar.add(returnitem["item_name"][0]);
          // //   stockItemSelection.add(returnitem);
          // // }
          // copystockItemSelection = stockItemSelection;
          // // print("stockreturn list length-----${copystockItemSelection}");
          // returnQty = List.generate(
          //     stockItemSelection.length, (index) => TextEditingController());
          // errorClicked =
          //     List.generate(stockItemSelection.length, (index) => false);

          // for (int i = 0; i < stockItemSelection.length; i++) {
          //   returnQty[i].text = stockItemSelection[i]["stock"];
          // }
          var seen = Set<String>();
          uniquelist =
              reporttbar.where((productbar) => seen.add(productbar)).toList();
          uniquelist.sort();
          // for (int i = 0; i < stockReturnList.length; i++) {
          //   // print("qty------${stockReturnList[i]["qty"]}");
          //   // qty[i].text = stockReturnList[i]["qty"].toString();
          // }
          notifyListeners();
          return stockReportList;

          /////////////// insert into local db /////////////////////
        } catch (e) {
          print(e);
          // return null;
          return [];
        }
      }
    });
  }

  //////////////////////////////////////////////////////////////////////
  Future addDeletebagItem(
      String itemId,
      String srate1,
      String srate2,
      String qty,
      String event,
      String cart_id,
      BuildContext context,
      String action,
      String page,
      String form_type,
      String to_branch_id) async {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          SharedPreferences prefs = await SharedPreferences.getInstance();

          user_id = prefs.getString("user_id");
          print("kjn------------------$user_id-");
          Uri url = Uri.parse("$urlgolabl/save_cart.php");
          Map body = {
            'staff_id': user_id,
            'branch_id': to_branch_id,
            'item_id': itemId,
            'qty': qty,
            'event': event,
            'cart_id': cart_id,
            'form_type': form_type
          };
          print("add body-----$body");
          if (action != "edit") {
            if (action != "delete") {
              isLoading = true;
              notifyListeners();
            }
          }

          http.Response response = await http.post(
            url,
            body: body,
          );

          var map = jsonDecode(response.body);
          // print("delete response-----------------$map");
          if (action != "edit") {
            if (action != "delete") {
              isLoading = false;
              notifyListeners();
            }
          }
          print("save response-----------------${map}");
          // cartCount = map["cart_count"];
          if (map["err_status"] == 0) {
            getbagData1(context, "cart edit", action, form_type, to_branch_id);
          }

          /////////////// insert into local db /////////////////////
        } catch (e) {
          print(e);
          // return null;
          return [];
        }
      }
    });
  }

  //////////////////////////////////////////////////////////////////////
  getbagData1(BuildContext context, String page, String action,
      String form_type, String to_branch_id) async {
    // bagList.clear();
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          SharedPreferences prefs = await SharedPreferences.getInstance();

          user_id = prefs.getString("user_id");
          print("kjn----------$action------$user_id-");
          Uri url = Uri.parse("$urlgolabl/cart_list.php");
          Map body = {
            'staff_id': user_id,
            'branch_id': to_branch_id,
            'form_type': form_type
          };
          print("cart body-----$body");
          if (action != "edit") {
            if (action != "delete") {
              isLoading = true;
              notifyListeners();
            }
          }

          // if (action == "edit") {
          //   isLoading = true;
          //   notifyListeners();
          // }

          http.Response response = await http.post(
            url,
            body: body,
          );

          var map = jsonDecode(response.body);
          print("cart response-----------------${map}");

          ProductListModel productListModel;
          bagList.clear();
          if (map != null) {
            for (var item in map) {
              productListModel = ProductListModel.fromJson(item);
              bagList.add(item);
            }
            notifyListeners();
          }
          cartCount = bagList.length.toString();
          print("hjzkdzskjd------$cartCount");
          t2qtycontroller = List.generate(
            bagList.length,
            (index) => TextEditingController(),
          );

          for (var i = 0; i < bagList.length; i++) {
            t2qtycontroller[i].text = bagList[i]["qty"].toString();
          }
          print("bag list data........${cartCount}");

          if (action != "edit") {
            if (action != "delete") {
              isLoading = false;
              notifyListeners();
            }
          }

          /////////////// insert into local db /////////////////////
        } catch (e) {
          print("error...$e");
          // return null;
          return [];
        }
      }
    });
  }

///////////////////////////////////////////////////
  historyData(BuildContext context, String action, String fromDate,
      String tillDate, String form_type) async {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          SharedPreferences prefs = await SharedPreferences.getInstance();

          user_id = prefs.getString("user_id");
          print("history------------------$user_id-----");
          Uri url = Uri.parse("$urlgolabl/transaction_list.php");
          Map body = {
            'staff_id': user_id,
            'from_date': fromDate,
            'till_date': tillDate,
            'form_type': form_type
          };
          print("history body-----$body");
          if (action != "delete") {
            isLoading = true;
            notifyListeners();
          }

          http.Response response = await http.post(
            url,
            body: body,
          );

          var map = jsonDecode(response.body);
          print("history response-----------------${map}");

          if (action != "delete") {
            isLoading = false;
            notifyListeners();
          }

          historyList.clear();
          if (map != null) {
            for (var item in map) {
              historyList.add(item);
            }
          }

          print("history list data........${historyList}");
          // isLoading = false;
          notifyListeners();

          /////////////// insert into local db /////////////////////
        } catch (e) {
          print("error...$e");
          // return null;
          return [];
        }
      }
    });
  }

// //////////////////////////////////////////////
  saveCartDetails(
    BuildContext context,
    String to_branch_id,
    String type,
    String remark,
    String event,
    String os_id,
    String action,
    String page,
  ) async {
    List<Map<String, dynamic>> jsonResult = [];
    Map<String, dynamic> itemmap = {};
    Map<String, dynamic> resultmmap = {};

    SharedPreferences prefs = await SharedPreferences.getInstance();

    user_id = prefs.getString("user_id");

    print("datas------$to_branch_id---$type--$remark------$user_id");
    print("action........$action");
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        print("bagList-----$bagList");
        Uri url = Uri.parse("$urlgolabl/save_transaction.php");

        jsonResult.clear();

        jsonResult.clear();
        print("bagList-save------$bagList-----");

        for (var i = 0; i < bagList.length; i++) {
          var itemmap = {
            "item_id": bagList[i]["item_id"],
            "qty": bagList[i]["qty"],
            "s_rate_1": bagList[i]["s_rate_1"],
            "s_rate_2": bagList[i]["s_rate_2"],
          };
          jsonResult.add(itemmap);
          print("jsonResult----$jsonResult");
        }
        print("jsonResult----$jsonResult");

        Map masterMap = {
          "event": event,
          "os_id": os_id,
          "req_type": type,
          "remark": remark,
          "staff_id": user_id,
          "branch_id": to_branch_id,
          "details": jsonResult
        };

        // var jsonBody = jsonEncode(masterMap);
        print("resultmap----$masterMap");
        // var body = {'json_data': masterMap};
        // print("body-----$body");

        var jsonEnc = jsonEncode(masterMap);

        print("jsonEnc-----$jsonEnc");
        isSaveLoading = true;
        notifyListeners();
        http.Response response = await http.post(
          url,
          body: {'json_data': jsonEnc},
        );

        var map = jsonDecode(response.body);
        isSaveLoading = false;
        notifyListeners();
        print("json cart--save----$map");

        // if (action == "delete" && map["err_status"] == 0) {
        //   // print("hist-----------$historyList");
        //   historyData(context, "delete", "", "");
        // }

        if (action == "save") {
          print("savedd");
          return showDialog(
              context: context,
              builder: (ct) {
                Size size = MediaQuery.of(ct).size;

                Future.delayed(Duration(seconds: 2), () {
                  // Navigator.of(context).pop(true);

                  Navigator.of(ct).pop(true);

                  if (map["err_status"] == 0) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MainDashboard(
                            // formType: form_type,
                            // type: "",
                            ),
                      ),
                    );
                  }

                  // Navigator.pop(context);
                });
                return AlertDialog(
                    content: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Flexible(
                      child: Text(
                        '${map['msg']}',
                        style: TextStyle(color: P_Settings.loginPagetheme),
                      ),
                    ),
                    Icon(
                      Icons.done,
                      color: Colors.green,
                    )
                  ],
                ));
              });
        } else if (action == "delete") {
          print("heloooooo");

          return showDialog(
              context: context,
              builder: (BuildContext mycontext) {
                Size size = MediaQuery.of(mycontext).size;

                Future.delayed(Duration(seconds: 2), () {
                  Navigator.pop(context);

                  Navigator.of(mycontext).pop();

                  // Navigator.of(mycontext).pop(false);
                  // Navigator.of(dialogContex).pop(true);

                  // Navigator.of(context).push(
                  //   PageRouteBuilder(
                  //       opaque: false, // set to false
                  //       pageBuilder: (_, __, ___) => MainDashboard()
                  //       // OrderForm(widget.areaname,"return"),
                  //       ),
                  // );
                });
                return AlertDialog(
                    content: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Flexible(
                      child: Text(
                        '${map['msg']}',
                        style: TextStyle(color: P_Settings.loginPagetheme),
                      ),
                    ),
                    Icon(
                      Icons.done,
                      color: Colors.green,
                    )
                  ],
                ));
              });
        } else {}
      }
    });
  }

/////////////////////////////////////////////////////////////////////
  saveReturnCartDetails(BuildContext context, String remark, String event,
      String os_id, String action, String page, String to_branch_id) async {
    List<Map<String, dynamic>> jsonResult = [];
    Map<String, dynamic> itemmap = {};
    Map<String, dynamic> resultmmap = {};

    SharedPreferences prefs = await SharedPreferences.getInstance();
    // branch_id = prefs.getString("branch_id");
    user_id = prefs.getString("user_id");

    print("datas-------$remark---------$user_id");
    print("action........$action");
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        print("bagList-----$bagList");
        Uri url = Uri.parse("$urlgolabl/save_return_transaction.php");

        jsonResult.clear();

        jsonResult.clear();
        print("bagList-save------$bagList-----");

        for (var i = 0; i < bagList.length; i++) {
          var itemmap = {
            "item_id": bagList[i]["item_id"],
            "qty": bagList[i]["qty"],
            "s_rate_1": bagList[i]["s_rate_1"],
            "s_rate_2": bagList[i]["s_rate_2"],
          };
          jsonResult.add(itemmap);
          print("jsonResult----$jsonResult");
        }
        print("jsonResult----$jsonResult");

        Map masterMap = {
          "event": event,
          "os_id": os_id,
          "remark": remark,
          "staff_id": user_id,
          "branch_id": to_branch_id,
          "details": jsonResult
        };

        // var jsonBody = jsonEncode(masterMap);
        print("resultmap----$masterMap");
        // var body = {'json_data': masterMap};
        // print("body-----$body");

        var jsonEnc = jsonEncode(masterMap);

        print("jsonEnc-----$jsonEnc");
        // isLoading = true;
        // notifyListeners();
        http.Response response = await http.post(
          url,
          body: {'json_data': jsonEnc},
        );

        var map = jsonDecode(response.body);

        print("json cart--save----$map");

        // if (action == "delete" && map["err_status"] == 0) {
        //   // print("hist-----------$historyList");
        //   historyData(context, "delete", "", "");
        // }

        print("savedd");
        return showDialog(
            context: context,
            builder: (ct) {
              Size size = MediaQuery.of(ct).size;

              Future.delayed(Duration(seconds: 2), () {
                Navigator.of(context).pop(true);
                Navigator.of(ct).pop(true);

                if (map["err_status"] == 0) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MainDashboard(
                          // formType: form_type,
                          // type: "",
                          ),
                    ),
                  );
                }

                // Navigator.pop(context);
              });
              return AlertDialog(
                  content: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Flexible(
                    child: Text(
                      '${map['msg']}',
                      style: TextStyle(color: P_Settings.loginPagetheme),
                    ),
                  ),
                  Icon(
                    Icons.done,
                    color: Colors.green,
                  )
                ],
              ));
            });
      }
    });
  }
  /////////////////////////////////////////////////////////////////////
  // saveStockReturnList(BuildContext context, String event, String os_id,
  //     String to_branch_id) async {
  //   List<Map<String, dynamic>> jsonResult = [];
  //   Map<String, dynamic> itemmap = {};
  //   Map<String, dynamic> resultmmap = {};

  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   branch_id = prefs.getString("branch_id");
  //   user_id = prefs.getString("user_id");

  //   NetConnection.networkConnection(context).then((value) async {
  //     if (value == true) {
  //       // print("bagList-----$bagList");
  //       Uri url = Uri.parse("$urlgolabl/save_transaction.php");

  //       jsonResult.clear();
  //       String ret;
  //       jsonResult.clear();
  //       print("project-save------$to_branch_id-----");

  //       for (var i = 0; i < copystockItemSelection.length; i++) {
  //         if (copystockItemSelection[i]["return_qty"] == null) {
  //           ret = copystockItemSelection[i]["stock"].toString();
  //         } else {
  //           ret = copystockItemSelection[i]["return_qty"].toString();
  //         }
  //         var itemmap = {
  //           "item_id": copystockItemSelection[i]["item_id"],
  //           "return_qty": ret,
  //           "stock": copystockItemSelection[i]["stock"],
  //         };
  //         jsonResult.add(itemmap);
  //         print("jsonResult----$jsonResult");
  //       }
  //       print("jsonResult----$jsonResult");

  //       Map masterMap = {
  //         "event": event,
  //         "to_branch_id": to_branch_id,
  //         "os_id": os_id,
  //         "details": jsonResult
  //       };

  //       // var jsonBody = jsonEncode(masterMap);
  //       print("resultmap----$masterMap");
  //       // var body = {'json_data': masterMap};
  //       // print("body-----$body");

  //       var jsonEnc = jsonEncode(masterMap);

  //       print("jsonEnc-----$jsonEnc");
  //       isLoading = true;
  //       notifyListeners();
  //       // http.Response response = await http.post(
  //       //   url,
  //       //   body: {'json_data': jsonEnc},
  //       // );

  //       // var map = jsonDecode(response.body);
  //       isLoading = false;
  //       notifyListeners();
  //       // print("json cart--save----$map");

  //       return showDialog(
  //           context: context,
  //           builder: (ct) {
  //             Size size = MediaQuery.of(ct).size;
  //             Future.delayed(Duration(seconds: 2), () {
  //               Navigator.of(ct).pop(true);
  //               Navigator.of(context).pop(true);

  //               // if (map["err_status"] == 0) {
  //               //   Navigator.push(
  //               //     context,
  //               //     MaterialPageRoute(
  //               //       builder: (context) => MainDashboard(
  //               //           // formType: form_type,
  //               //           // type: "",
  //               //           ),
  //               //     ),
  //               //   );
  //               // }

  //               // Navigator.pop(context);
  //             });
  //             return AlertDialog(
  //                 content: Row(
  //               mainAxisAlignment: MainAxisAlignment.end,
  //               children: [
  //                 Flexible(
  //                   child: Text(
  //                     'adszd',
  //                     style: TextStyle(color: P_Settings.loginPagetheme),
  //                   ),
  //                 ),
  //                 Icon(
  //                   Icons.done,
  //                   color: Colors.green,
  //                 )
  //               ],
  //             ));
  //           });
  //     }
  //   });
  // }

////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////
  getDeliveryList(BuildContext context) async {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          user_id = prefs.getString("user_id");

          Uri url = Uri.parse("$urlgolabl/delivery_list.php");
          Map body = {
            'staff_id': user_id,
          };
          print("mbody-----$body");
          // isDownloaded = true;
          isLoading = true;
          notifyListeners();

          http.Response response = await http.post(
            url,
            body: body,
          );
          DeliveryListModel deliveryListModel;
          var map = jsonDecode(response.body);
          print("stock approval list-----------------$map");

          isLoading = false;
          notifyListeners();
          dispatchedList.clear();
          if (map != null) {
            for (var item in map) {
              deliveryListModel = DeliveryListModel.fromJson(item);
              dispatchedList.add(deliveryListModel);
            }
          }

          deliveryListCount = dispatchedList.length.toString();

          print("stock_approve_list---$dispatchedList");
          notifyListeners();

          /////////////// insert into local db /////////////////////
        } catch (e) {
          print(e);
          // return null;
          return [];
        }
      }
    });
  }

//////////////////////////////////////////////////
  getDamagedList(BuildContext context, String type) async {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          user_id = prefs.getString("user_id");

          Uri url = Uri.parse("$urlgolabl/damage_pdt_list.php");
          Map body = {
            'staff_id': user_id,
          };
          print("mbody-----$body");
          if (type != "from confirm") {
            damLoading = true;
            notifyListeners();
          }
          http.Response response = await http.post(
            url,
            body: body,
          );

          var map = jsonDecode(response.body);
          print("damaged list-----------------$map");

          damagedList.clear();
          if (map != null) {
            for (var item in map) {
              damagedList.add(item);
            }
          }

          damagedListCount = damagedList.length.toString();
          if (type != "from confirm") {
            damLoading = false;
            notifyListeners();
          }

          if (type == "from confirm") {
            Navigator.push(
              context, 
              MaterialPageRoute(
                  builder: (context) => StockRequest(
                        from_type: "0",
                        title: "Material Request",
                      )),
            );
          }

          print("damaged vcv---$damagedList");
          notifyListeners();

          /////////////// insert into local db /////////////////////
        } catch (e) {
          print(e);
          // return null;
          return [];
        }
      }
    });
  }

  //////////////////////////////////////////////////////////////////
  confirmDamagedList(BuildContext context, String pdm_id) async {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          user_id = prefs.getString("user_id");

          Uri url = Uri.parse("$urlgolabl/cnfrm_dmg_pd.php");
          Map body = {
            'pdm_id': pdm_id,
          };
          print("mbody-----$body");

          http.Response response = await http.post(
            url,
            body: body,
          );
          print("damaged list--confrm---------------${response.body}");

          var map = jsonDecode(response.body);
          print("damaged list--confrm-----map----------${map}");

          if (map["err_status"] == 0) {
            getDamagedList(context, "from confirm");

            // Navigator.push(
            //                       context,
            //                       MaterialPageRoute(
            //                           builder: (context) => DamagedList()),
            //                     );
          }
          print("damaged confrm---$damagedList");
          notifyListeners();

          /////////////// insert into local db /////////////////////
        } catch (e) {
          print(e);
          // return null;
          return [];
        }
      }
    });
  }

  ///////////////////////////////////////////////////////////////////
  saveDeliveryApprovalList(BuildContext context, String osId) async {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          SharedPreferences prefs = await SharedPreferences.getInstance();

          user_id = prefs.getString("user_id");

          Uri url = Uri.parse("$urlgolabl/save_delivery_approve.php");
          Map body = {
            'staff_id': user_id,
            'os_id': osId,
          };
          print("dmbody-----$body");
          // isDownloaded = true;
          isLoading = true;
          notifyListeners();

          http.Response response = await http.post(
            url,
            body: body,
          );
          var map = jsonDecode(response.body);
          print("stock approval save----------------$map");

          isLoading = false;
          notifyListeners();

          return showDialog(
              context: context,
              builder: (ct) {
                Size size = MediaQuery.of(context).size;

                Future.delayed(Duration(seconds: 2), () {
                  Navigator.of(ct).pop(true);
                  if (map["err_status"] == 0) {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                          opaque: false, // set to false
                          pageBuilder: (_, __, ___) => MainDashboard()
                          // OrderForm(widget.areaname,"return"),
                          ),
                    );
                  }
                });
                return AlertDialog(
                    content: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Flexible(
                      child: Text(
                        map["msg"].toString(),
                        style: TextStyle(color: P_Settings.loginPagetheme),
                      ),
                    ),
                    map["err_status"] == 0
                        ? Icon(
                            Icons.done,
                            color: Colors.green,
                          )
                        : Container()
                  ],
                ));
              });

          // stock_approve_list.clear();
          // if (map != null) {
          //   for (var item in map) {
          //     stock_approve_list.add(item);
          //   }
          // }

          // print("stock_approve_list---$stock_approve_list");
          // notifyListeners();

          /////////////// insert into local db /////////////////////
        } catch (e) {
          print(e);
          // return null;
          return [];
        }
      }
    });
  }

///////////////////////////////////////////////////////////////////////
  getdispatchedListInfo(BuildContext context, String osId) async {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          SharedPreferences prefs = await SharedPreferences.getInstance();

          Uri url = Uri.parse("$urlgolabl/delivery_list_detail.php");
          Map body = {
            'os_id': osId,
          };
          print("deliverylist  body-----$body");
          // isDownloaded = true;
          isLoading = true;
          notifyListeners();

          http.Response response = await http.post(
            url,
            body: body,
          );
          var map = jsonDecode(response.body);
          print("delivery list detail----------$map");

          isLoading = false;
          notifyListeners();
          DeliveryListInfoModel deliveryListInfo;
          dispatchedinfoList.clear();
          for (var item in map) {
            deliveryListInfo = DeliveryListInfoModel.fromJson(item);
            dispatchedinfoList.add(deliveryListInfo);
          }
          // ProductListModel productListModel;
          // if (map != null) {
          //   stock_approve_masterlist.clear();
          //   for (var item in map["master"]) {
          //     print("haiiiiii----$item");
          //     stock_approve_masterlist.add(item);
          //   }
          //   stock_approve_detaillist.clear();
          //   for (var item in map["detail"]) {
          //     print("sd---$item");
          //     stock_approve_detaillist.add(item);
          //   }
          // }

          print("stock_approve_detaillist--$stock_approve_detaillist---");
          notifyListeners();

          /////////////// insert into local db /////////////////////
        } catch (e) {
          print(e);
          // return null;
          return [];
        }
      }
    });
  }

///////////////////////////////////////////////////////////////////////
  getRequestinfoList(BuildContext context, String os_id, String type) async {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          SharedPreferences prefs = await SharedPreferences.getInstance();

          Uri url = Uri.parse("$urlgolabl/transaction_list_detail.php");
          Map body = {
            'os_id': os_id,
          };
          print("os_id-----$body");

          isListLoading = true;
          notifyListeners();

          http.Response response = await http.post(
            url,
            body: body,
          );
          var map = jsonDecode(response.body);

          print("i tag-----$map");
          transaction_item_info.clear();
          if (map != null) {
            for (var item in map) {
              transaction_item_info.add(item);
            }
          }
          isListLoading = false;
          notifyListeners();

          /////////////// insert into local db /////////////////////
        } catch (e) {
          print(e);
          // return null;
          return [];
        }
      }
    });
  }

  //////////////////////////////////////////////////////////////////////
  searchItem(BuildContext context, String itemName, String to_branch_id) async {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          print("value-----$itemName");

          Uri url = Uri.parse("$urlgolabl/search_products_list.php");
          Map body = {'item_name': itemName, "branch_id": to_branch_id};
          print("body-----$body");
          // isDownloaded = true;
          isSearchLoading = true;
          notifyListeners();

          http.Response response = await http.post(
            url,
            body: body,
          );
          var map = jsonDecode(response.body);
          print("item_search_s------$map");
          searchList.clear();
          for (var item in map) {
            searchList.add(item);
          }

          qtycontroller = List.generate(
            searchList.length,
            (index) => TextEditingController(),
          );
          addtoCart = List.generate(searchList.length, (index) => false);

          isSearchLoading = false;
          notifyListeners();

          /////////////// insert into local db /////////////////////
        } catch (e) {
          print(e);
          // return null;
          return [];
        }
      }
    });
  }

//////////////////////////////////////////////////////////////////////////
  searchStockReturnItem(
      BuildContext context, String itemName, String to_branch_id) async {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          print("value-----$itemName");
          SharedPreferences prefs = await SharedPreferences.getInstance();
          // branch_id = prefs.getString("branch_id");
          Uri url = Uri.parse("$urlgolabl/search_return_products_list.php");
          Map body = {'item_name': itemName, 'branch_id': to_branch_id};
          print("body- b ----$body");
          // isDownloaded = true;
          isSearchLoading = true;
          notifyListeners();

          http.Response response = await http.post(
            url,
            body: body,
          );
          var map = jsonDecode(response.body);
          print("item_search_stock return------$map");
          searchList.clear();
          for (var item in map) {
            searchList.add(item);
          }

          qtycontroller = List.generate(
            searchList.length,
            (index) => TextEditingController(),
          );
          addtoCart = List.generate(searchList.length, (index) => false);
          errorClicked = List.generate(searchList.length, (index) => false);
          isSearchLoading = false;
          notifyListeners();

          /////////////// insert into local db /////////////////////
        } catch (e) {
          print(e);
          // return null;
          return [];
        }
      }
    });
  }

/////////////////////////////////////////////////////////////////////////
  // Future<List<Map<String, dynamic>>> getProductDetails(
  //     String cat_id, String catName) async {
  //   print("cat_id.......$cat_id---$catName");
  //   try {
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     branch_id = prefs.getString("branch_id");
  //     staff_name = prefs.getString("staff_name");
  //     branch_name = prefs.getString("branch_name");
  //     branch_prefix = prefs.getString("branch_prefix");
  //     user_id = prefs.getString("user_id");
  //     print("kjn---------------$branch_id----$user_id-");
  //     Uri url = Uri.parse("$urlgolabl/products_list2.php");

  //     Map body = {
  //       'staff_id': user_id,
  //       'branch_id': branch_id,
  //       'cat_id': cat_id
  //     };
  //     print("body----${body}");
  //     // isDownloaded = true;
  //     isProdLoading = true;
  //     notifyListeners();

  //     http.Response response = await http.post(
  //       url,
  //       body: body,
  //     );

  //     isProdLoading = false;
  //     notifyListeners();

  //     print("body ${body}");
  //     var map = jsonDecode(response.body);

  //     print("nmnmkzd-------${map}");
  //     productList.clear();
  //     productbar.clear();

  //     // cartCount = map["cart_count"].toString();

  //     notifyListeners();
  //     // print("map["product_list"]")
  //     for (var pro in map["product_list"]) {
  //       print("pro------$pro");
  //       productbar.add(pro["item_name"][0]);
  //       productList.add(pro);
  //     }
  //     qty =
  //         List.generate(productList.length, (index) => TextEditingController());
  //     errorClicked = List.generate(productList.length, (index) => false);

  //     print("qty------$qty");

  //     for (int i = 0; i < productList.length; i++) {
  //       print("qty------${productList[i]["qty"]}");
  //       qty[i].text = productList[i]["qty"].toString();
  //     }
  //     notifyListeners();
  //     var seen = Set<String>();
  //     uniquelist =
  //         productbar.where((productbar) => seen.add(productbar)).toList();
  //     uniquelist.sort();
  //     print("productDetailsTable--map ${productList}");
  //     print("productbar--map ${uniquelist}");
  //     dropdwnString = catName.toString();
  //     print("catName-----$dropdwnVal");
  //     notifyListeners();
  //     return productList;

  //     /////////////// insert into local db /////////////////////
  //   } catch (e) {
  //     print(e);
  //     // return null;
  //     return [];
  //   }
  // }

  ///////////////////////////////////////////////////////
  filterProduct(String selected) {
    print("productzszscList----$productList");
    isLoading = true;
    filteredproductList.clear();
    filteredproductbar.clear();
    for (var item in productList) {
      if (item["cat_id"] == selected) {
        filteredproductbar.add(item["item_name"][0]);
        filteredproductList.add(item);
      }
    }

    isLoading = false;
    print("filsfns----$filteredproductList");
    notifyListeners();
  }

////////////////////////////////////////////////////////////////////
  setbardata() {
    filter = true;
    isLoading = true;
    notifyListeners();
    print("filterdeproductbar---$filteredproductbar");
    var seen = Set<String>();
    filtereduniquelist.clear();
    filtereduniquelist =
        filteredproductbar.where((productbar) => seen.add(productbar)).toList();
    filtereduniquelist.sort();
    notifyListeners();

    print("filtereduniquelist-----$filtereduniquelist");
    isLoading = false;
    notifyListeners();
  }

  ///////////////////////////////////////////////////////
  uploadImage(filepath, context) async {
    final String uploadUrl = 'https://api.imgur.com/3/upload';
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          var request = http.MultipartRequest('POST', Uri.parse(uploadUrl));
          request.files
              .add(await http.MultipartFile.fromPath('image', filepath));
          var res = await request.send();
          print("res.reasonPhrase------${res.reasonPhrase}");
          return res.reasonPhrase!;
        } catch (e) {
          print(e);
        }
      }
    });
  }

  setfilter(bool fff) {
    print("filter----$filter");
    filter = fff;
    notifyListeners();
  }

  setQty(int qty) {
    qtyinc = qty;
    print("qty.......$qty");
    // notifyListeners();
  }

  setAmt(
    String price,
  ) {
    totalPrice = double.parse(price);
    priceval = double.parse(price).toStringAsFixed(2);
    // notifyListeners();
  }

  qtyDecrement() {
    // returnqty = true;
    qtyinc = qtyinc! - 1;
    print("qty-----$qtyinc");
    notifyListeners();
  }

  qtyIncrement() {
    qtyinc = 1 + qtyinc!;
    print("qty increment-----$qtyinc");
    notifyListeners();
  }

  totalCalculation(double rate) {
    totalPrice = rate * qtyinc!;
    priceval = totalPrice!.toStringAsFixed(2);
    print("total pri-----$totalPrice");
    notifyListeners();
  }

  seterrorClicked(bool apply, int index) {
    errorClicked[index] = apply;
    notifyListeners();
  }
  /////////////////////////////////////////////////////////
  // uploadBagData(
  //     String cid, BuildContext context, int? index, String page) async {
  //   List<Map<String, dynamic>> resultQuery = [];
  //   List<Map<String, dynamic>> om = [];
  //   var result;

  //   // var result = await OrderAppDB.instance.selectMasterTable();
  //   print("output------$result");
  //   if (result.length > 0) {
  //     // isUpload = true;
  //     notifyListeners();
  //     String jsonE = jsonEncode(result);
  //     var jsonDe = jsonDecode(jsonE);
  //     print("jsonDe--${jsonDe}");
  //     for (var item in jsonDe) {
  //       resultQuery = await OrderAppDB.instance.selectDetailTable(item["oid"]);
  //       item["od"] = resultQuery;
  //       om.add(item);
  //     }
  //     if (om.length > 0) {
  //       print("entede");
  //       saveOrderDetails(cid, om, context);
  //     }
  //     isUpload = false;
  //     if (page == "upload page") {
  //       isUp[index!] = true;
  //     }

  //     notifyListeners();
  //     print("om----$om");
  //   } else {
  //     isUp[index!] = false;
  //     notifyListeners();
  //     snackbar.showSnackbar(context, "Nothing to upload!!!", "");
  //   }

  //   notifyListeners();
  // }

  setstockTranserselected(bool value) {
    stocktransferselected = value;
    notifyListeners();
  }

  userDetails() async {
    final prefs = await SharedPreferences.getInstance();
    String? staff_nam = prefs.getString("staff_name");
    String? branch_nam = prefs.getString("branch_name");

    staff_name = staff_nam;
    branch_name = branch_nam;
    notifyListeners();
  }

  setqtyErrormsg(bool qtyerrormsg) {
    qtyerror = qtyerrormsg;
    notifyListeners();
  }

  setDate(String date1, String date2) {
    fromDate = date1;
    todate = date2;
    print("gtyy----$fromDate----$todate");
    notifyListeners();
  }

  setIssearch(bool isSrach) {
    isSearch = isSrach;
    notifyListeners();
  }

////////////////////////////////////////////////////////////////
  // editDeleteTransaction(
  //     String transId,
  //     String transaval,
  //     String osId,
  //     String item_id,
  //     String oldqty,
  //     String newqty,
  //     String msg,
  //     String event,
  //     BuildContext context,
  //     String frDate,
  //     String todate,
  //     int index) async {
  //   NetConnection.networkConnection(context).then((value) async {
  //     if (value == true) {
  //       try {
  //         Uri url = Uri.parse("$urlgolabl/transaction_update.php");
  //         SharedPreferences prefs = await SharedPreferences.getInstance();
  //         branch_id = prefs.getString("branch_id");
  //         String? user_id = prefs.getString("user_id");

  //         Map body = {
  //           'os_id': osId,
  //           'trans_val': transaval,
  //           'item_id': item_id,
  //           'old_qty': oldqty,
  //           'qty': newqty,
  //           'msg': msg,
  //           'event': event,
  //           'branch_id': branch_id,
  //           'staff_id': user_id
  //         };
  //         print("editdelete body----------------------$body");

  //         isLoading = true;
  //         notifyListeners();
  //         http.Response response = await http.post(
  //           url,
  //           body: body,
  //         );
  //         var map = jsonDecode(response.body);

  //         print("edit delete -----$map");

  //         isLoading = false;
  //         notifyListeners();
  //         if (event == "2" && map["err_status"] == 0) {
  //           print("event----2---$event");
  //           // historyData(context, "", frDate, todate);
  //         }
  //         if (event == "1" && map["err_status"] == 0) {
  //           transinfohide[index] = true;
  //           print("event----2---$event");
  //           notifyListeners();

  //           getRequestinfoList(context, osId, "delete");
  //         }
  //         // print("savedd");
  //         return showDialog(
  //             context: context,
  //             builder: (context) {
  //               Size size = MediaQuery.of(context).size;

  //               Future.delayed(Duration(seconds: 2), () {
  //                 // if (map["err_status"] == 0) {
  //                 //   getTransinfoList(context, osId, "delete");
  //                 // }
  //                 Navigator.of(context).pop(true);

  //                 // Navigator.of(context).push(
  //                 //   PageRouteBuilder(
  //                 //       opaque: false, // set to false
  //                 //       pageBuilder: (_, __, ___) => TransactionPage()
  //                 //       // OrderForm(widget.areaname,"return"),
  //                 //       ),
  //                 // );
  //               });
  //               return AlertDialog(
  //                   content: Row(
  //                 mainAxisAlignment: MainAxisAlignment.end,
  //                 children: [
  //                   Flexible(
  //                     child: Text(
  //                       map["msg"].toString(),
  //                       style: TextStyle(color: P_Settings.loginPagetheme),
  //                     ),
  //                   ),
  //                   Icon(
  //                     Icons.done,
  //                     color: Colors.green,
  //                   )
  //                 ],
  //               ));
  //             });
  //       } catch (e) {
  //         print(e);
  //       }
  //     }
  //   });
  // }

  /////////////////////////////////////////////////
  cartCountFun(int count) {
    print("count------$count");
    cartCountInc = count + 1;
    notifyListeners();
  }

  ///////////////////////////////////////////////
  addToCartClicked(bool clicked, int index) {
    addtoCart[index] = clicked;
    notifyListeners();
  }

  setisVisible(bool isvis) {
    isVisible = isvis;
    notifyListeners();
  }

  clearBagList() {
    bagList.clear();
    notifyListeners();
  }

  justFun(String hhh) {
    print("hhh-------$hhh");
    notifyListeners();
  }

  setarrowClicked(bool value) {
    arrowButtonclicked = value;
    notifyListeners();
  }

  stockReturnQtyEdit(double qty, String itemId) {
    print("itemId-----$itemId");
    for (int i = 0; i < copystockItemSelection.length; i++) {
      if (copystockItemSelection[i]["item_id"] == itemId) {
        copystockItemSelection[i]["return_qty"] = qty;
      } else {
        // copystockItemSelection[i]["return_qty"] =
        //     copystockItemSelection[i]["stock"];
      }
    }

    print("copystockItemSelection aftr edit----$copystockItemSelection");
    notifyListeners();
  }

  /////////////////////////////////////////////////////////////
  getStatus(String reqId, BuildContext context) {
    // statusList = [
    //   {"isAct": "1", "title": "Levele1", "content": "Hai from l1"},
    //   {"isAct": "1", "title": "Levele2", "content": "Hai from l2"},
    //   {"isAct": "1", "title": "Levele3", "content": "Hai from l3"},
    //   {"isAct": "0", "title": "Levele4", "content": "Hai from l4"},
    // ];
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          print("value-----$reqId");

          Uri url = Uri.parse("$urlgolabl/time_line.php");
          Map body = {
            'req_id': reqId,
          };
          print("body-----$body");
          // isDownloaded = true;
          isStatusLoad = true;
          notifyListeners();

          http.Response response = await http.post(
            url,
            body: body,
          );
          var map = jsonDecode(response.body);
          print("statusList------$map");
          statusList.clear();
          for (var item in map) {
            statusList.add(item);
          }

          isStatusLoad = false;
          notifyListeners();

          /////////////// insert into local db /////////////////////
        } catch (e) {
          print(e);
          // return null;
          return [];
        }
      }
    });
    // notifyListeners();
  }
}
