class TransactionTypeModel {
  String? transId;
  String? transType;
  String? transPrefix;
  String? transVal;
  String? branch_selection;

  TransactionTypeModel(
      {this.transId, this.transType, this.transPrefix, this.transVal,this.branch_selection});

  TransactionTypeModel.fromJson(Map<String, dynamic> json) {
    transId = json['trans_id'];
    transType = json['trans_type'];
    transPrefix = json['trans_prefix'];
    transVal = json['trans_val'];
    branch_selection = json['branch_selection'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['trans_id'] = this.transId;
    data['trans_type'] = this.transType;
    data['trans_prefix'] = this.transPrefix;
    data['trans_val'] = this.transVal;
    data['branch_selection'] = this.branch_selection;

    return data;
  }
}