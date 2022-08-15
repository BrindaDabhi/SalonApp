class SPModel {
  String? shopName;
  String? subtitleName;
  String? address;
  Map<String, dynamic>? serviceMap;
  String? uid;
  String? image;

  SPModel.fromJson(Map<String, dynamic> data) {
    shopName = data['Shop Name'];
    subtitleName = data['Subtitle Name'];
    address = data['Address'];
    serviceMap = data['Services'];
    uid = data['Uid'];
    image = data['Image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();

    data["Shop Name"] = this.shopName;
    data["Subtitle Name"] = this.subtitleName;
    data["Address"] = this.address;
    data["Services"] = this.serviceMap;
    data["Uid"] = this.uid;
    data["Image"] = this.image;

    return data;
  }
}
