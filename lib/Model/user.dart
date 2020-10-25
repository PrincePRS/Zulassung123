class UserModel{
  String id = '';
  String companyname = '';
  String contactpartner = '';
  String streetname = '';
  String postcode = '';
  String place = '';
  String email = '';
  String telephone = '';
  String roleid = '';

  UserModel({this.id, this.companyname, this.contactpartner, this.streetname, this.postcode, this.place, this.email, this.telephone, this.roleid});

  UserModel.fromJson(Map<String, dynamic> json, String idx) {
    id = idx;
    companyname = json['companyname'] == null ? '' : json['companyname'];
    contactpartner = json['contactpartner'] == null ? '' : json['contactpartner'];
    streetname = json['streetname'] == null ? '' : json['streetname'];
    postcode = json['postcode'] == null ? '' : json['postcode'];
    place = json['place'] == null ? '' : json["place"];
    email = json['email'] == null ? '' : json["email"];
    telephone = json['telephone'] == null ? '' : json["telephone"];
    roleid = json['roleid'] == null ? '' : json["roleid"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['companyname'] = this.companyname;
    data['contactpartner'] = this.contactpartner;
    data['streetname'] = this.streetname;
    data['postcode'] = this.postcode;
    data['place'] = this.place;
    data['email'] = this.email;
    data['telephone'] = this.telephone;
    data['roleid'] = this.roleid;
    return data;
  }

  Map<String, dynamic> toJsonWithoutID() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['companyname'] = this.companyname;
    data['contactpartner'] = this.contactpartner;
    data['streetname'] = this.streetname;
    data['postcode'] = this.postcode;
    data['place'] = this.place;
    data['email'] = this.email;
    data['telephone'] = this.telephone;
    data['roleid'] = this.roleid;
    return data;
  }
}