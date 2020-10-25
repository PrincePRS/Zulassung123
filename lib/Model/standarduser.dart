class StandardUser {
  final int id; // primary key
  final String date; // appoint booking date
  final String name; // buyer name
  final String telephone; // buyer telephone
  final String annotation;

  StandardUser({this.id, this.name, this.date, this.annotation, this.telephone});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'date': date,
      'telephone': telephone,
      'annotation': annotation,
    };
  }
}