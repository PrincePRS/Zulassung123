import 'package:zulassung123/Model/authinfo.dart';
import 'package:zulassung123/Model/standarduser.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// id, annotation, date, name, telephone
class SqliteController {
// define tables name
  final String standardtb = 'standardtb';
  final String authtb = 'authtb';
  var _db;
  Future<Database> get database async {
    if(_db != null) return _db;
    _db = openDatabase(
      join(await getDatabasesPath(), 'zulassung.db'),
      onCreate: (db, version)  async {
        db.execute(
          "CREATE TABLE $standardtb(id INTEGER PRIMARY KEY, annotation TEXT, date TEXT, name TEXT, telephone TEXT)",
        );
        db.execute(
          "CREATE TABLE $authtb(id INTEGER PRIMARY KEY, role INTEGER, email TEXT, telephone TEXT, isRegister INTEGER)",
        );
        await db.rawInsert("INSERT INTO $authtb (role, email, telephone, isRegister) VALUES ('-1', '', '', 0)");
        return db;
      },
      version: 1,
    );
    return _db;
  }

  Future<AuthInfo> getAuthInfo() async {
    final Database db = await database;

    final List<Map<String, dynamic>> maps = await db.query('$authtb');

      return AuthInfo(
        id: maps[0]['id'],
        role: maps[0]['role'],
        email: maps[0]['email'],
        telephone: maps[0]['telephone'],
        isRegister: maps[0]['isRegister']
      );
  }


  Future<int> updateAuthInfo(AuthInfo authInfo) async {
    final db = await database;
    await db.update(
      '$authtb',
      authInfo.toMap(),
      where: "id = ?",
      whereArgs: [authInfo.id],
    );
    return 1;
  }

  Future<int> insertData(StandardUser unit) async {
    // Get a reference to the database.
    final Database db = await database;

    // Insert the Categori into the correct table. Also specify the
    return await db.insert(
      '$standardtb',
      unit.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<StandardUser>> getLists() async {
    final Database db = await database;

    final List<Map<String, dynamic>> maps = await db.query('$standardtb');

    return List.generate(maps.length, (i) {
      return StandardUser(
        id: maps[i]['id'],
        annotation: maps[i]['annotation'],
        date: maps[i]['date'],
        name: maps[i]['name'],
        telephone: maps[i]['telephone'],
      );
    });
  }


  Future<List<StandardUser>> getMonthdatas(String mth, String yrs) async {
    final Database db = await database;

    final List<Map<String, dynamic>> maps = await db.query(
        '$standardtb',
        where: "date LIKE ?",
        whereArgs: ['%$mth.$yrs']
    ); //rawDelete();

    return List.generate(maps.length, (i) {
      return StandardUser(
        id: maps[i]['id'],
        annotation: maps[i]['annotation'],
        date: maps[i]['date'],
        name: maps[i]['name'],
        telephone: maps[i]['telephone'],
      );
    });
  }

  Future<void> deleteData(String phone) async{
    final db = await database;
    await db.delete(
      '$standardtb',
      where: "telephone = ?",
      whereArgs: [phone],
    );
  }
}