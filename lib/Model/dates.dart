class DateModel{
  String id = '';
  String dates = '';

  DateModel({this.id, this.dates});

  DateModel.fromJson(Map<String, dynamic> json, String idx) {
    print(idx);
    id = idx;
    dates = json['dates'] == null ? '' : json['dates'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['dates'] = this.dates;

    return data;
  }

  Map<String, dynamic> toJsonWithoutID() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dates'] = this.dates;
    return data;
  }
}