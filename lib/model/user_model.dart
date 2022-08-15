class UserModel {
  String? name;
  String? email;
  String? password;
  String? uid;

  UserModel.fromJson(Map<String, dynamic> data) {
    name = data['Name'];
    email = data['Email'];
    password = data['Password'];
    uid = data['Uid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();

    data["Name"] = this.name;
    data["Email"] = this.email;
    data["Password"] = this.password;
    data["Uid"] = this.uid;

    return data;
  }
}
