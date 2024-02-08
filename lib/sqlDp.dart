import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
class SqlDb{

  static Database? _dp;

  Future<Database?> get dp async{
    if(_dp == null){
      _dp = await initialDb();
      return _dp;
    }
    else {
      return _dp;
    }
  }

  initialDb() async {
    String databasePath = await getDatabasesPath();
    String pathName = join(databasePath, 'eman.dp');
    Database myDp = await openDatabase(pathName,onCreate: _onCreate, version: 3, onUpgrade: _onUpgrade);
    return myDp;
  }

  _onUpgrade(Database dp, int oldVersion, int newVersion) async {
    await dp.execute("ALTER TABLE notes ADD COLUMN color TEXT ");
    print('onUpgrade ==============================');
  }

  _onCreate(Database dp, int version)async{
    await dp.execute('CREATE TABLE Notes (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, note TEXT NOT NULL)');

    print('create database and table=========');
  }

  Future<List<Map>> readData(String sql) async {
    Database? myDp = await dp;
    List<Map> response = await myDp!.rawQuery(sql);
    return response;
  }

  Future<int> insertData(String sql) async {
    Database? myDp = await dp;
    int response = await myDp!.rawInsert(sql);
    return response;
  }

  Future<int> updateData(String sql) async {
    Database? myDp = await dp;
    int response = await myDp!.rawUpdate(sql);
    return response;
  }

  Future<int> deleteData(String sql) async {
    Database? myDp = await dp;
    int response = await myDp!.rawDelete(sql);
    return response;
  }

  onDeleteDataBase() async {
    String databasePath = await getDatabasesPath();
    String pathName = join(databasePath, 'eman.dp');
    await deleteDatabase(pathName);
  }
}