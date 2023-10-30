class DeliveryListInfoModel {
  String? osdId;
  String? osId;
  String? item_name;
  String? qty;
  String? s_rate_1;
  String? s_rate_2;
  String? item_remark;

  DeliveryListInfoModel(
      {this.osdId,
      this.osId,
      this.item_name,
      this.qty,
      this.s_rate_1,
      this.s_rate_2,
      this.item_remark});

  DeliveryListInfoModel.fromJson(Map<String, dynamic> json) {
    osdId = json['os_d_id'];
    osId = json['os_id'];

    item_name = json['item_name'];
    qty = json['qty'];
    s_rate_1 = json['s_rate_1'];
    s_rate_2 = json['s_rate_2'];
    item_remark = json['item_remark'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["os_d_id"] = this.osdId;
    data['os_id'] = this.osId;
    data['item_name'] = this.item_name;
    data['qty'] = this.qty;
    data['s_rate_1'] = this.s_rate_1;
    data['s_rate_2'] = this.s_rate_2;
    data['item_remark'] = this.item_remark;

    return data;
  }
}
