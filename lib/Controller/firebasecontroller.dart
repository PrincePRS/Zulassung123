import 'package:zulassung123/Model/dates.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zulassung123/Model/user.dart';
import 'package:zulassung123/Model/appoint.dart';

class FirebaseController {

  final usercollection = "usertb";
  final appointcollection = "appointtb";

  // create firebase instance
  Firestore _db = Firestore.instance;

  // insert  new user  when  register (business)
  Future<void>  insertUser(UserModel userdata){
    return _db.collection(usercollection).document()
        .setData({
      'companyname': userdata.companyname,
      'contactpartner':userdata.contactpartner,
      'streetname': userdata.streetname,
      'postcode':userdata.postcode,
      'place': userdata.place,
      'email':userdata.email,
      'telephone': userdata.telephone,
      'roleid':userdata.roleid
    });
  }

  // insert new appoint data  (from standard user and business user)
  Future<void>  insertAppoint(AppointModel appointdata) async{
    // if already booked
    CollectionReference  tb_instance = _db.collection(appointcollection);
    Query query = tb_instance.where("email", isEqualTo: appointdata.email).where("date", isEqualTo: appointdata.date);
    QuerySnapshot querySnapshot = await query.getDocuments();

  //  if(querySnapshot.documents.length < 1) {
      _db.collection(appointcollection).document()
          .setData({
        'name': appointdata.name,
        'email': appointdata.email,
        'date': appointdata.date,
        'telephone': appointdata.telephone,
        'annotation': appointdata.annotation,
      });
   // }
  }

  // get appoint datas (only bussiness)
  Stream<List<AppointModel>> GetAppointsData(String useremail) {
    CollectionReference  tb_instance = _db.collection(appointcollection);
    Query query = tb_instance.where("email", isEqualTo: useremail);

    return query.snapshots().map((snapshot) => snapshot.documents.map(
            (doc) => AppointModel.fromJson(doc.data, doc.documentID)
    ).toList());
  }

  // get all users appoints (only admin)
  Stream<List<AppointModel>> GetAllAppointsData() {
    CollectionReference  tb_instance = _db.collection(appointcollection).orderBy('date', descending: false);

    return tb_instance.snapshots().map((snapshot) => snapshot.documents.map(
            (doc) => AppointModel.fromJson(doc.data, doc.documentID)
    ).toList());
  }

  Future<QuerySnapshot> deleteCutomerAppoint(String phone) {
    this.getUserPin(phone).then((QuerySnapshot docs) {
      if(docs.documents.isNotEmpty) {
        return _db.collection(appointcollection).document(docs.documents[0].documentID).delete();
      } else {
        return null;
      }
    });
  }

  Future<void> deleteBusinessAppoint(String id) {
      _db.collection(appointcollection).document(id).delete();
  }

  Future<QuerySnapshot> getBuisnessPin(String phone, String email) {

    return _db.collection(appointcollection).
    where("telephone", isEqualTo: phone).
    where("email", isEqualTo: email).
    getDocuments();
  }

  Future<QuerySnapshot> getUserPin(String phone) {

    return _db.collection(appointcollection).
    where("telephone", isEqualTo: phone).
    where("email", isEqualTo: null).
    getDocuments();
  }

  // get user datas (for confirmation)
  Future<List<AppointModel>> GetAppointFutureData(String mth, String yrs) async{
    CollectionReference  tb_instance = _db.collection(appointcollection);

    QuerySnapshot querySnapshot = await tb_instance.getDocuments();
    List<AppointModel> appoints = List<AppointModel>();
    for(int i = 0; i < querySnapshot.documents.length; i ++){

      appoints.add(AppointModel.fromJson(querySnapshot.documents[i].data, querySnapshot.documents[i].documentID));
    }
    return appoints;
  }

  // get user datas (only admin click (i))
  Stream<List<UserModel>> GetUserData(String useremail) {
    CollectionReference  tb_instance = _db.collection(usercollection);
    Query query = tb_instance.where("email", isEqualTo: useremail);

    return query.snapshots().map((snapshot) => snapshot.documents.map(
            (doc) => UserModel.fromJson(doc.data, doc.documentID)
    ).toList());
  }

  // get user datas (for confirmation)
  Future<List<UserModel>> GetUserFutureData(String useremail) async{
    CollectionReference  tb_instance = _db.collection(usercollection);
    Query query = tb_instance.where("email", isEqualTo: useremail);

    QuerySnapshot querySnapshot = await query.getDocuments();
    List<UserModel> users = List<UserModel>();
    for(int i = 0; i < querySnapshot.documents.length; i ++){
      users.add(UserModel.fromJson(querySnapshot.documents[i].data, querySnapshot.documents[i].documentID));
    }
    return users;
  }

  Future<int> GetUserFromPhone(String phone) async{
    CollectionReference  tb_instance = _db.collection(usercollection);
    Query query = tb_instance.where("telephone", isEqualTo: phone);

    QuerySnapshot querySnapshot = await query.getDocuments();
    return querySnapshot.documents.length;

  }

  // get user datas (for confirmation)
  Future<List<UserModel>> GetAllUsers() async{
    CollectionReference  tb_instance = _db.collection(usercollection);

    QuerySnapshot querySnapshot = await tb_instance.getDocuments();
    List<UserModel> users = List<UserModel>();
    for(int i = 0; i < querySnapshot.documents.length; i ++){
      users.add(UserModel.fromJson(querySnapshot.documents[i].data, querySnapshot.documents[i].documentID));
    }
    return users;
  }

// get stream data each date
  // params. date string.

  // Stream<List<AppointModel>> EachDateAppointState(String datestring) {
  //   CollectionReference  tb_instance = _db.collection(appointcollection);
  //   Query query = tb_instance.where("date", isEqualTo: datestring);
  //
  //   return query.snapshots().map((snapshot) => snapshot.documents.map(
  //           (doc) => AppointModel.fromJson(doc.data, doc.documentID)
  //   ).toList());
  // }

  Stream<List<DateModel>> GetAppointDate() {
    CollectionReference  tb_instance = _db.collection("appointdatetb");
    //Query query = tb_instance.where("appoint", isEqualTo: "07.02.2020");

    return tb_instance.snapshots().map((snapshot) => snapshot.documents.map(
      (doc) {
        return DateModel.fromJson(doc.data, doc.documentID);
      }
    ).toList());
  }
//  Future<List<UserModel>> GetAllUsers() async{
//    CollectionReference  tb_instance = _db.collection(usercollection);
////    Query query = tb_instance.where("email", isEqualTo: useremail);
//
//    QuerySnapshot querySnapshot = await tb_instance.getDocuments();
//    List<UserModel> users = List<UserModel>();
//    for(int i = 0; i < querySnapshot.documents.length; i ++){
//      print("--------------------");
//      users.add(UserModel.fromJson(querySnapshot.documents[i].data, querySnapshot.documents[i].documentID));
//    }
//    return users;
//  }

  Future<List<AppointModel>> GetFutureAppointsDataFromDate (String dy, String mth, String yrs) async{
    CollectionReference  tb_instance = _db.collection(appointcollection);
    Query query = tb_instance.where("date", isEqualTo: dy+"."+mth+"." + yrs);
    QuerySnapshot querySnapshot = await query.getDocuments();
    List<AppointModel> appointList = List<AppointModel>();
    for(int i = 0; i < querySnapshot.documents.length; i ++){
      appointList.add(AppointModel.fromJson(querySnapshot.documents[i].data, querySnapshot.documents[i].documentID));
    }
    return appointList;
  }

  Stream<List<AppointModel>> GetAppointsDataFromDate(String dy, String mth, String yrs) {
    CollectionReference  tb_instance = _db.collection(appointcollection);
    Query query = tb_instance.where("date", isEqualTo: dy+"."+mth+"." + yrs);
    return query.snapshots().map((snapshot) => snapshot.documents.map(
            (doc) {
          return AppointModel.fromJson(doc.data, doc.documentID);
        }
    ).toList());
  }

  // get all users appoints (only admin)
  Stream<List<AppointModel>> GetMonthAppointsData(String mth, String yrs) {
    CollectionReference  tb_instance = _db.collection(appointcollection);

    return tb_instance.snapshots().map((snapshot) => snapshot.documents.map(
            (doc) {
          var datestr = doc.data['date'].toString().substring(3);
          if(datestr == mth + "." + yrs)
            return AppointModel.fromJson(doc.data, doc.documentID);
          return new AppointModel();
        }
    ).toList());
  }

  Stream<List<AppointModel>> GetMonthAppointsWithEmail(String mth, String yrs, String email) {
    CollectionReference  tb_instance = _db.collection(appointcollection);
    Query query = tb_instance.where("email", isEqualTo: email);

    return query.snapshots().map((snapshot) => snapshot.documents.map(
            (doc) {
          var datestr = doc.data['date'].toString().substring(3);
          if(datestr == mth + "." + yrs)
            return AppointModel.fromJson(doc.data, doc.documentID);
          return new AppointModel();
        }
    ).toList());
  }


}