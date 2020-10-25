class AuthInfo{
  int id;
  int role;
  String email;
  String telephone;
  int isRegister;


  AuthInfo({this.id, this.role, this.email, this.telephone, this.isRegister});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'role': role,
      'email': email,
      'telephone':telephone,
      'isRegister':isRegister
    };
  }


  @override
  String toString() {
    return 'AuthInfo{id: $id, role : $role, email : $email, telephone : $telephone, isRegister : $isRegister}';
  }
}