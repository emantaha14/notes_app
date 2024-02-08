import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/sqlDp.dart';


class HomeScreen extends StatelessWidget {

  SqlDb sqlDb = SqlDb();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Center(
            child: ElevatedButton(onPressed: ()async{
              List<Map> response = await sqlDb.readData("SELECT * FROM 'notes' ");
              print('$response');
            },
                child:  Text('read data',style: TextStyle(fontSize: 25),)),
          ),
          Center(
            child: ElevatedButton(onPressed: () async {
              int response = await sqlDb.insertData("INSERT INTO 'notes' ('note') VALUES ('note six') ");
              print(response);
            },
                child:  Text('insert data',style: TextStyle(fontSize: 25),)),
          ),
          Center(
            child: ElevatedButton(onPressed: ()async{
              int response = await sqlDb.updateData("UPDATE 'notes' SET 'note' = 'not three' WHERE id = 3 ");
              print(response);
            },
                child:  Text('update data',style: TextStyle(fontSize: 25),)),
          ),
          Center(
            child: ElevatedButton(onPressed: ()async{
              int response = await sqlDb.deleteData("DELETE FROM 'notes' WHERE id = 4");
              print(response);
            },
                child:  Text('delete data',style: TextStyle(fontSize: 25),)),
          ),
        ],
      ),
    );
  }
}
