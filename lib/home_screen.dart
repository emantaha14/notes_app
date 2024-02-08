
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/edit_notes.dart';
import 'package:notes_app/sqlDp.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  SqlDb sqlDb = SqlDb();
  bool isLoading = true;
  List notes = [];

  Future readData() async {
    List<Map> response = await sqlDb.readData("SELECT * FROM notes");
    notes.addAll(response);
    isLoading = false;
    if(this.mounted){
      setState(() {

      });
    }
  }

  @override
  void initState() {
    readData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.pushNamed(context, "addNotes");
      },child: const Icon(Icons.add),),
      appBar: AppBar(
        title:const Text('Notes App')
      ),
      body: isLoading? const Center(child: Text('Loading...'))
          :Column(
        children: [
               Expanded(
                child: ListView.builder(
                  itemCount: notes.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text('${notes[index]['note']}'),
                        subtitle: Text("${notes[index]['color']}"),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(onPressed: () async {
                              int response = await sqlDb.deleteData("DELETE FROM Notes WHERE id = ${notes[index]['id']} ");
                              print(response);
                              if(response > 0){
                                setState(() {
                                  notes.removeWhere((element) => element['id'] == notes[index]['id']);
                                });
                              }
                            }, icon: const Icon(Icons.delete,color: Colors.red,),),
                            IconButton(onPressed: (){
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => EditNotesScreen(color: notes[index]['color'],id: notes[index]['id'],note: notes[index]['note'],)));
                            }, icon: const Icon(Icons.edit,color: Colors.green,))
                          ],
                        )
                      ),
                    );
                },),
              ),
        ],
      ),
    );
  }
}
