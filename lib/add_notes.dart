
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/home_screen.dart';
import 'package:notes_app/sqlDp.dart';

class AddNotesScreen extends StatefulWidget {
  const AddNotesScreen({super.key});

  @override
  State<AddNotesScreen> createState() => _AddNotesScreenState();
}

class _AddNotesScreenState extends State<AddNotesScreen> {
  GlobalKey<FormState> formState = GlobalKey();
  TextEditingController noteController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  SqlDb sqlDb =  SqlDb();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(title: Text('Add Notes')),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: formState,
          child: Column(
            children: [
              TextFormField(
                controller: noteController,
                decoration: const InputDecoration(
                  hintText: 'note'
                ),
              ),
              TextFormField(
                controller: colorController,
                decoration: const InputDecoration(
                  hintText: 'color'
                ),
              ),
              const SizedBox(height: 20,),
              MaterialButton(
              onPressed: () async {
                print('response =========================');
                int response = await sqlDb.insertData('INSERT INTO Notes(note, color) VALUES("${noteController.text}", "${colorController.text}")');
                print(response);
                if(response > 0){
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => HomeScreen(),), (route) => false);
                }
              },
              color: Colors.blue,
              textColor: Colors.white,
              child: const Text('Add Notes'),
              )
            ],
          ),
        ),
      ),

    );
  }
}
