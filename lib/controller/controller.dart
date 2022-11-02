import 'package:flutter/material.dart';
import 'package:hamco/components/commonColor.dart';
import 'package:hamco/components/globalData.dart';
import 'package:hamco/components/networkConnectivity.dart';
import 'package:hamco/model/branchModel.dart';
import 'package:hamco/model/itemcategroy.dart';
import 'package:hamco/model/productListModel.dart';
import 'package:hamco/model/registrationModel.dart';
import 'package:hamco/model/transactionModel.dart';
import 'package:hamco/screen/dashboard/mainDashboard.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

class Controller extends ChangeNotifier {
  // bool isVisible = false;
  bool? arrowButtonclicked;
  TextEditingController searchcontroller = TextEditingController();
  bool isSearchLoading = false;
  bool addtoDone = false;
  String? fromDate;
  String? brName;
  List<bool> transinfohide = [];
  bool isVisible = false;
  bool isProdLoading = false;
  bool isSearch = false;
  String? dropdwnVal;
  String? dropdwnString;

  String? todate;
  String urlgolabl = Globaldata.apiglobal;
  bool isLoading = false;
  bool isListLoading = false;

  bool qtyerror = false;
  bool stocktransferselected = false;
  String? branch_id;
  String? staff_name;
  String? branch_name;
  String? branch_prefix;
  String? user_id;

  String? menu_index;
  List<Map<String, dynamic>> menuList = [];
  List<Map<String, dynamic>> searchList = [];

  List<Map<String, dynamic>> infoList = [];
  List<Map<String, dynamic>> dispatchedinfoList = [];

  List<Map<String, dynamic>> dispatchedList = [];
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
  List<TextEditingController> qtycontroller = [];
  List<TextEditingController> t2qtycontroller = [];

  List<TextEditingController> historyqty = [];
  List<TextEditingController> oldhistoryqty = [];
  List<bool> addtoCart = [];
  String? cartCount;
  int? cartCountInc;

  List<Map<String, dynamic>> productList = [];
  List<Map<String, dynamic>> bagList = [];
  List<Map<String, dynamic>> historyList = [];

  List<BranchModel> branchist = [];
  List<TransactionTypeModel> siteList = [];

  List<ItemCategoryModel> itemCategoryList = [];

  List<Map<String, dynamic>> filteredproductList = [];

  List<String> productbar = [];
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
  getBranchList(BuildContext context, String page, String brId) async {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          BranchModel brnachModel = BranchModel();
          SharedPreferences prefs = await SharedPreferences.getInstance();
          branch_id = prefs.getString("branch_id");
          Uri url = Uri.parse("$urlgolabl/branch_list.php");
          Map body = {
            'branch_id': branch_id,
          };
          isLoading = true;
          // notifyListeners();

          http.Response response = await http.post(
            url,
            body: body,
          );

          // print("body ${body}");
          var map = jsonDecode(response.body);
          print("branchlist-----$map");
          branchist.clear();
          // productbar.clear();
          for (var item in map) {
            brnachModel = BranchModel.fromJson(item);
            branchist.add(brnachModel);
          }

          if (page == "history") {
            for (var i = 0; i < branchist.length; i++) {
              if (branchist[i].uID == brId) {
                brName = branchist[i].branchName;
              }
            }
            // print("brId------${branchist[i].branchName}");
          }

          isLoading = false;
          notifyListeners();
          return branchist;
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
  getSiteList(BuildContext context) async {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          BranchModel brnachModel = BranchModel();
          Uri url = Uri.parse("$urlgolabl/transaction_type.php");
          // Map body = {
          //   'cid': cid,
          // };

          // isDownloaded = true;
          isLoading = true;
          // notifyListeners();

          http.Response response = await http.post(
            url,
            // body: body,
          );
          var map = jsonDecode(response.body);
          print("transaction map----$map");
          TransactionTypeModel transactionTypeModel;
          siteList.clear();

          for (var item in map) {
            transactionTypeModel = TransactionTypeModel.fromJson(item);
            siteList.add(transactionTypeModel);
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
  Future addDeletebagItem(
      String itemId,
      String srate1,
      String srate2,
      String qty,
      String event,
      String cart_id,
      BuildContext context,
      String action,
      String page) async {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          branch_id = prefs.getString("branch_id");
          user_id = prefs.getString("user_id");
          print("kjn---------------$branch_id----$user_id-");
          Uri url = Uri.parse("$urlgolabl/save_cart.php");
          Map body = {
            'staff_id': user_id,
            'branch_id': branch_id,
            'item_id': itemId,
            'qty': qty,
            'event': event,
            'cart_id': cart_id
          };
          print("add body-----$body");
          if (action != "delete") {
            isLoading = true;
            notifyListeners();
          }

          http.Response response = await http.post(
            url,
            body: body,
          );

          var map = jsonDecode(response.body);
          // print("delete response-----------------$map");
          if (action != "delete") {
            isLoading = false;
            notifyListeners();
          }
          print("delete response-----------------${map}");
          cartCount = map["cart_count"];
          var res = map["msg"];
          if (res == "Bag Edit Successfully" && page == "transaction2") {
            getbagData1(context, page);
          }
          if (res == "Bag deleted Successfully") {
            getbagData1(context, "");
          }
          return res;
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
  getbagData1(BuildContext context, String page) async {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          branch_id = prefs.getString("branch_id");
          user_id = prefs.getString("user_id");
          print("kjn---------------$branch_id----$user_id-");
          Uri url = Uri.parse("$urlgolabl/cart_list.php");
          Map body = {
            'staff_id': user_id,
            'branch_id': branch_id,
          };
          print("cart body-----$body");
          if (page != "transaction2") {
            isLoading = true;
            notifyListeners();
          }

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
          }
          t2qtycontroller = List.generate(
            bagList.length,
            (index) => TextEditingController(),
          );

          for (var i = 0; i < bagList.length; i++) {
            t2qtycontroller[i].text = bagList[i]["qty"].toString();
          }
          print("bag list data........${bagList}");
          if (page != "transaction2") {
            isLoading = false;
            notifyListeners();
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
  historyData(BuildContext context, String trans_id, String action,
      String fromDate, String tillDate) async {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          branch_id = prefs.getString("branch_id");
          user_id = prefs.getString("user_id");
          print("history---------------$branch_id----$user_id------$trans_id");
          Uri url = Uri.parse("$urlgolabl/transaction_list.php");
          Map body = {
            'staff_id': user_id,
            'branch_id': branch_id,
            'trans_id': trans_id,
            'from_date': fromDate,
            'till_date': tillDate
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
      String transid,
      String to_branch_id,
      String remark,
      String event,
      String os_id,
      String action,
      String page) async {
    List<Map<String, dynamic>> jsonResult = [];
    Map<String, dynamic> itemmap = {};
    Map<String, dynamic> resultmmap = {};

    SharedPreferences prefs = await SharedPreferences.getInstance();
    branch_id = prefs.getString("branch_id");
    user_id = prefs.getString("user_id");

    print(
        "datas------$transid---$to_branch_id----$remark------$branch_id----$user_id");
    print("action........$action");
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        print("bagList-----$bagList");
        Uri url = Uri.parse("$urlgolabl/save_transaction.php");

        jsonResult.clear();
        itemmap.clear();

        bagList.map((e) {
          itemmap["item_id"] = e["item_id"];
          itemmap["qty"] = e["qty"];
          itemmap["s_rate_1"] = e["s_rate_1"];
          itemmap["s_rate_2"] = e["s_rate_2"];
          print("itemmap----$itemmap");
          jsonResult.add(e);
        }).toList();

        // for (var i = 0; i < bagList.length; i++) {
        //   print("bagList[i]-------------${bagList[i]}");
        //   itemmap["item_id"] = bagList[i]["item_id"];
        //   itemmap["qty"] = bagList[i]["qty"];
        //   itemmap["s_rate_1"] = bagList[i]["s_rate_1"];
        //   itemmap["s_rate_2"] = bagList[i]["s_rate_2"];
        //   print("itemmap----$itemmap");
        //   jsonResult.add(itemmap);
        // }

        print("jsonResult----$jsonResult");

        Map masterMap = {
          "trans_id": transid,
          "to_branch_id": to_branch_id,
          "remark": remark,
          "staff_id": user_id,
          "branch_id": branch_id,
          "event": event,
          "os_id": os_id,
          "details": jsonResult
        };

        // var jsonBody = jsonEncode(masterMap);
        print("resultmap----$masterMap");
        // var body = {'json_data': masterMap};
        // print("body-----$body");

        var jsonEnc = jsonEncode(masterMap);

        print("jsonEnc-----$jsonEnc");
        isLoading = true;
        notifyListeners();
        http.Response response = await http.post(
          url,
          body: {'json_data': jsonEnc},
        );

        var map = jsonDecode(response.body);
        isLoading = false;
        notifyListeners();
        print("json cart------$map");

        if (action == "delete" && map["err_status"] == 0) {
          // print("hist-----------$historyList");
          historyData(context, transid, "delete", "", "");
        }

        if (action == "save") {
          print("savedd");
          return showDialog(
              context: context,
              builder: (BuildContext ct) {
                Size size = MediaQuery.of(ct).size;

                Future.delayed(Duration(seconds: 2), () {
                  Navigator.of(ct).pop(true);

                  Navigator.pop(context);

                  if (map["err_status"] == 0) {
                    clearBagList();
                    // bagList.clear();
                    // print("after clear baglist----${bagList.length}");
                  }
                  if (page == "transaction1") {
                    // Navigator.of(context).push(
                    //   PageRouteBuilder(
                    //       opaque: false, // set to false
                    //       pageBuilder: (_, __, ___) => TransactionPage()
                    //       // OrderForm(widget.areaname,"return"),
                    //       ),
                    // );
                  }
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
                  Navigator.of(mycontext).pop();

                  Navigator.pop(context);
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

////////////////////////////////////////////////////////////////////////
  getinfoList(BuildContext context, String itemId) async {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          branch_id = prefs.getString("branch_id");

          Uri url = Uri.parse("$urlgolabl/item_search_stock.php");
          Map body = {
            'item_id': itemId,
            'branch_id': branch_id,
          };
          print("cart bag body-----$body");
          // isDownloaded = true;
          isListLoading = true;
          notifyListeners();

          http.Response response = await http.post(
            url,
            body: body,
          );
          var map = jsonDecode(response.body);
          print("item_search_stock bag response-----------------$map");

          isListLoading = false;
          notifyListeners();
          // ProductListModel productListModel;
          if (map != null) {
            infoList.clear();
            for (var item in map["item_info"]) {
              infoList.add(item);
            }
            stockList.clear();
            for (var item in map["Stock_info"]) {
              stockList.add(item);
            }
          }

          print("infoList---$infoList----$stockList");
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
  getDispatchedList(BuildContext context) async {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          branch_id = prefs.getString("branch_id");

          Uri url = Uri.parse("$urlgolabl/stock_approve_list.php");
          Map body = {
            'branch_id': branch_id,
          };
          print("mbody-----$body");
          // isDownloaded = true;
          isLoading = true;
          notifyListeners();

          http.Response response = await http.post(
            url,
            body: body,
          );
          var map = jsonDecode(response.body);
          print("stock approval list-----------------$map");

          isLoading = false;
          notifyListeners();
          dispatchedList.clear();
          if (map != null) {
            for (var item in map) {
              dispatchedList.add(item);
            }
          }

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

  ///////////////////////////////////////////////////////////////////
  saveStockApprovalList(BuildContext context, String osId) async {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          branch_id = prefs.getString("branch_id");
          user_id = prefs.getString("user_id");

          Uri url = Uri.parse("$urlgolabl/save_stock_approve.php");
          Map body = {
            'staff_id': user_id,
            'branch_id': branch_id,
            'os_id': osId
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

          if (map["err_status"] == 0) {
            return showDialog(
                context: context,
                builder: (context) {
                  Size size = MediaQuery.of(context).size;

                  Future.delayed(Duration(seconds: 2), () {
                    Navigator.of(context).pop(true);
                    getDispatchedList(context);
                    Navigator.of(context).push(
                      PageRouteBuilder(
                          opaque: false, // set to false
                          pageBuilder: (_, __, ___) => MainDashboard()
                          // OrderForm(widget.areaname,"return"),
                          ),
                    );
                  });
                  return AlertDialog(
                      content: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        map["msg"].toString(),
                        style: TextStyle(color: P_Settings.loginPagetheme),
                      ),
                      Icon(
                        Icons.done,
                        color: Colors.green,
                      )
                    ],
                  ));
                });
          }

          // stock_approve_list.clear();
          // if (map != null) {
          //   for (var item in map) {
          //     stock_approve_list.add(item);
          //   }
          // }

          // print("stock_approve_list---$stock_approve_list");
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
  getdispatchedListInfo(BuildContext context, String osId) async {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          branch_id = prefs.getString("branch_id");

          Uri url = Uri.parse("$urlgolabl/stock_approve_info.php");
          Map body = {
            'os_id': osId,
          };
          print("cart bag body-----$body");
          // isDownloaded = true;
          isLoading = true;
          notifyListeners();

          http.Response response = await http.post(
            url,
            body: body,
          );
          var map = jsonDecode(response.body);
          print("stockinfo----------$map");

          isLoading = false;
          notifyListeners();

          dispatchedinfoList.clear();
          for (var item in map) {
            dispatchedinfoList.add(item);
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
  getTransinfoList(BuildContext context, String os_id, String type) async {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          branch_id = prefs.getString("branch_id");

          Uri url = Uri.parse("$urlgolabl/transaction_info.php");
          Map body = {
            'os_id': os_id,
          };
          print("os_id-----$body");
          if (type != "delete") {
            isListLoading = true;
            notifyListeners();
          }

          http.Response response = await http.post(
            url,
            body: body,
          );
          var map = jsonDecode(response.body);

          print("i tag-----$map");
          if (map != null) {
            transinfoList.clear();
            for (var item in map["master"]) {
              transinfoList.add(item);
            }
            transiteminfoList.clear();
            for (var item in map["detail"]) {
              transiteminfoList.add(item);
            }
            historyqty = List.generate(
              transiteminfoList.length,
              (index) => TextEditingController(),
            );

            oldhistoryqty = List.generate(
              transiteminfoList.length,
              (index) => TextEditingController(),
            );
            transinfohide =
                List.generate(transiteminfoList.length, (index) => false);

            for (int i = 0; i < transiteminfoList.length; i++) {
              historyqty[i].text = transiteminfoList[i]["qty"].toString();
              oldhistoryqty[i].text = transiteminfoList[i]["qty"].toString();
            }
          }
          print(
              "transinfoList--------------------$transinfoList------------$transiteminfoList");
          if (type != "delete") {
            isListLoading = false;
            notifyListeners();
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
  searchItem(BuildContext context, String itemName) async {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          print("value-----$itemName");

          Uri url = Uri.parse("$urlgolabl/search_products_list.php");
          Map body = {
            'item_name': itemName,
          };
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

/////////////////////////////////////////////////////////////////////////
  Future<List<Map<String, dynamic>>> getProductDetails(
      String cat_id, String catName) async {
    print("cat_id.......$cat_id---$catName");
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      branch_id = prefs.getString("branch_id");
      staff_name = prefs.getString("staff_name");
      branch_name = prefs.getString("branch_name");
      branch_prefix = prefs.getString("branch_prefix");
      user_id = prefs.getString("user_id");
      print("kjn---------------$branch_id----$user_id-");
      Uri url = Uri.parse("$urlgolabl/products_list2.php");

      Map body = {
        'staff_id': user_id,
        'branch_id': branch_id,
        'cat_id': cat_id
      };
      print("body----${body}");
      // isDownloaded = true;
      isProdLoading = true;
      notifyListeners();

      http.Response response = await http.post(
        url,
        body: body,
      );

      isProdLoading = false;
      notifyListeners();

      print("body ${body}");
      var map = jsonDecode(response.body);

      print("nmnmkzd-------${map}");
      productList.clear();
      productbar.clear();

      cartCount = map["cart_count"].toString();

      notifyListeners();
      // print("map["product_list"]")
      for (var pro in map["product_list"]) {
        print("pro------$pro");
        productbar.add(pro["item_name"][0]);
        productList.add(pro);
      }
      qty =
          List.generate(productList.length, (index) => TextEditingController());
      errorClicked = List.generate(productList.length, (index) => false);

      print("qty------$qty");

      for (int i = 0; i < productList.length; i++) {
        print("qty------${productList[i]["qty"]}");
        qty[i].text = productList[i]["qty"].toString();
      }
      notifyListeners();
      var seen = Set<String>();
      uniquelist =
          productbar.where((productbar) => seen.add(productbar)).toList();
      uniquelist.sort();
      print("productDetailsTable--map ${productList}");
      print("productbar--map ${uniquelist}");
      dropdwnString = catName.toString();
      print("catName-----$dropdwnVal");
      notifyListeners();
      return productList;

      /////////////// insert into local db /////////////////////
    } catch (e) {
      print(e);
      // return null;
      return [];
    }
  }

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
  editDeleteTransaction(
      String transId,
      String transaval,
      String osId,
      String item_id,
      String oldqty,
      String newqty,
      String msg,
      String event,
      BuildContext context,
      String frDate,
      String todate,
      int index) async {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          Uri url = Uri.parse("$urlgolabl/transaction_update.php");
          SharedPreferences prefs = await SharedPreferences.getInstance();
          branch_id = prefs.getString("branch_id");
          String? user_id = prefs.getString("user_id");

          Map body = {
            'os_id': osId,
            'trans_val': transaval,
            'item_id': item_id,
            'old_qty': oldqty,
            'qty': newqty,
            'msg': msg,
            'event': event,
            'branch_id': branch_id,
            'staff_id': user_id
          };
          print("editdelete body----------------------$body");

          isLoading = true;
          notifyListeners();
          http.Response response = await http.post(
            url,
            body: body,
          );
          var map = jsonDecode(response.body);

          print("edit delete -----$map");

          isLoading = false;
          notifyListeners();
          if (event == "2" && map["err_status"] == 0) {
            print("event----2---$event");
            historyData(context, transId, "", frDate, todate);
          }
          if (event == "1" && map["err_status"] == 0) {
            transinfohide[index] = true;
            print("event----2---$event");
            notifyListeners();

            getTransinfoList(context, osId, "delete");
          }
          // print("savedd");
          return showDialog(
              context: context,
              builder: (context) {
                Size size = MediaQuery.of(context).size;

                Future.delayed(Duration(seconds: 2), () {
                  // if (map["err_status"] == 0) {
                  //   getTransinfoList(context, osId, "delete");
                  // }
                  Navigator.of(context).pop(true);

                  // Navigator.of(context).push(
                  //   PageRouteBuilder(
                  //       opaque: false, // set to false
                  //       pageBuilder: (_, __, ___) => TransactionPage()
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
                        map["msg"].toString(),
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
        } catch (e) {
          print(e);
        }
      }
    });
  }

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
}
