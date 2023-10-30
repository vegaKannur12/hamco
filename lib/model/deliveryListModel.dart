class DeliveryListModel {
  String? osId;
  String? series;
  String? entryDate;
  String? branchName;
  String? branchId;


  DeliveryListModel({this.osId, this.series, this.entryDate, this.branchName,this.branchId});

  DeliveryListModel.fromJson(Map<String, dynamic> json) {
    osId = json['os_id'];
    series = json['series'];
    entryDate = json['entry_date'];
    branchName = json['BranchName'];
    branchId = json['branchId'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['os_id'] = this.osId;
    data['series'] = this.series;
    data['entry_date'] = this.entryDate;
    data['BranchName'] = this.branchName;
    data['branchId'] = this.branchId;

    return data;
  }
}