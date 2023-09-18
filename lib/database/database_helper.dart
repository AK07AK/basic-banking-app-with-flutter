import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:untitled/models/transaction_details.dart';

import '../models/user_data.dart';
class DatabaseHelper{

  static Database? db;

    Future<Database> database() async {
      return openDatabase(
        join(await getDatabasesPath(), 'bankingsystem.db'),
        onCreate: _createTables,
        version: 1,
      );
    }

    Future<void> _createTables(Database db,int version) async{
      await db.execute(
          "CREATE TABLE userdetails(id INTEGER PRIMARY KEY, userName TEXT,cardNumber VARCHAR,cardExpiry TEXT,totalAmount DOUBLE)");

      await db.execute(
          "CREATE TABLE transectionsData(id INTEGER PRIMARY KEY,transectionId INTEGER,userName TEXT,senderName TEXT,transectionAmount DOUBLE)");
    }
    Future<void> insert(UserData userData) async{
      final Database db = await database();
      await db.insert('userdetails',userData.toMap(),conflictAlgorithm: ConflictAlgorithm.replace);
    }
    Future<void> updateTotalAmount(int id,double totalAmount) async
    {
      final Database db = await database();
      await db.rawUpdate("UPDATE userdetails SET totalAmount = '$totalAmount' where id =$id");
    }
  Future<List<UserData>> getUserDetails() async {
    final Database _db = await database();
    final List<Map<String, dynamic>> userMap = await _db.query('userdetails');
    return List.generate(
      userMap.length,
          (index) {
        return UserData(
          id: userMap[index]['id'],
          userName: userMap[index]['userName'],
          cardNumber: userMap[index]['cardNumber'],
          cardExpiry: userMap[index]['cardExpiry'],
          totalAmount: userMap[index]['totalAmount'],
        );
      },
    );
  }

    Future<List<UserData>> getUserDetail(int? userId) async{
      final Database db = await database();


      List<Map<String,dynamic>> details = await db.rawQuery("SELECT * FROM userdetails WHERE id!=$userId");
      return List.generate(details.length, (index){
        return UserData(
            id: details[index]['id'],
            totalAmount:details[index]['userName'],
            cardNumber: details[index]['cardNumber'],
            cardExpiry: details[index]['cardExpiry'],
            userName: details[index]['totalAmount']);
      });
    }
  Future<void> insertTransectionHistroy(
      TransactionDetails transectionDetails) async {
    Database _db = await database();
    await _db.insert('transectionsData', transectionDetails.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

    Future<List<TransactionDetails>> getTransactionDetails() async{
      Database db = await database();
      final List<Map<String,dynamic>> trasectionMap =
          await db.rawQuery("SELECT * FROM transectionsData");
      return List.generate(trasectionMap.length, (index) {
        return TransactionDetails(
          id: trasectionMap[index]['id'],
          userName: trasectionMap[index]['userName'],
          senderName: trasectionMap[index]['senderName'],
          tansactionId: trasectionMap[index]['transectionId'], amount:trasectionMap[index]["transectionAmount"] ,
        );
      });
    }

}