import 'package:flutter/material.dart';

class StockReportListModel {
  String? itemId;
  String? itemName;
  String? itemCode;
  String? rate;
  String? stock;

  StockReportListModel(
      {this.itemId, this.itemName, this.itemCode, this.rate, this.stock});

  StockReportListModel.fromJson(Map<String, dynamic> json) {
    itemId = json['item_id'];
    itemName = json['item_name'];
    itemCode = json['item_code'];
    rate = json['rate'];
    stock = json['stock'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['item_id'] = this.itemId;
    data['item_name'] = this.itemName;
    data['item_code'] = this.itemCode;
    data['rate'] = this.rate;
    data['stock'] = this.stock;
    return data;
  }
}
