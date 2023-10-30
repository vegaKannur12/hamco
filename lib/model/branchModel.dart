class BranchModel {
  String? uID;
  String? branchName;

  BranchModel({this.uID, this.branchName});

  BranchModel.fromJson(Map<String, dynamic> json) {
    uID = json['UID'];
    branchName = json['BranchName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UID'] = this.uID;
    data['BranchName'] = this.branchName;
    return data;
  }
}