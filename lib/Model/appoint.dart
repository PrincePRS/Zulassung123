class AppointModel{ // This model is only for business customer
  String id = '';
  String email = '';
  String date = '';
  String telephone='';
  String annotation = '';
  String name = '';

  AppointModel({this.id, this.email, this.telephone, this.date, this.annotation, this.name});

  AppointModel.fromJson(Map<String, dynamic> json, String idx) {
    id = idx;
    email = json['email'] == null ? '' : json['email'];
    telephone = json['telephone'] == null ? '' : json['telephone'];
    date = json['date'] == null ? '' : json['date'];
    annotation = json['annotation'] == null ? '' : json['annotation'];
    name = json['name'] == null ? '' : json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['telephone'] = this.telephone;
    data['date'] = this.date;
    data['annotation'] = this.annotation;
    data['name'] = this.name;
    return data;
  }

  Map<String, dynamic> toJsonWithoutID() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['telephone'] = this.telephone;
    data['date'] = this.date;
    data['annotation'] = this.annotation;
    data['name'] = this.name;
    return data;
  }
}