
class SiteModel {
  String? branch;
  String? uID;

  SiteModel({this.branch, this.uID});

  SiteModel.fromJson(Map<String, dynamic> json) {
    branch = json['branch'];
    uID = json['UID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['branch'] = this.branch;
    data['UID'] = this.uID;
    return data;
  }
}