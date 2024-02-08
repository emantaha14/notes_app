import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/home_screen.dart';
import 'package:notes_app/sqlDp.dart';

class EditNotesScreen extends StatefulWidget {
  final String  ?note;
  final String ?color;
  final int ?id;
  const EditNotesScreen({super.key, this.note, this.color, this.id});

  @override
  State<EditNotesScreen> createState() => _EditNotesScreenState();
}

class _EditNotesScreenState extends State<EditNotesScreen> {
  GlobalKey<FormState> formState = GlobalKey();
  TextEditingController noteController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  SqlDb sqlDb =  SqlDb();

  @override
  void initState() {
    noteController.text = widget.note?? '';
    colorController.text = widget.color?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(title: const Text('Edit Notes')),
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
                  int response = await sqlDb.updateData('UPDATE Notes SET note = "${noteController.text}", color = "${colorController.text}" WHERE id = ${widget.id}');
                  print('response =========================');
                  print(response);
                  if(response > 0){
                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => HomeScreen(),), (route) => false);
                  }
                },
                color: Colors.blue,
                textColor: Colors.white,
                child: const Text('Edit Notes'),
              )
            ],
          ),
        ),
      ),

    );
  }
}
