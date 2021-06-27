import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tcc/dialog/delete_agenda_dialog.dart';
import 'package:tcc/providers/firebase_services.dart';
import 'package:tcc/utils/app_routes.dart';
import 'package:tcc/views/edit_agenda.dart';

class AgendaDoc extends StatefulWidget {
  @override
  _AgendaDocState createState() => _AgendaDocState();
}

class _AgendaDocState extends State<AgendaDoc> {
  String uid = '';
  var currentUser = FirebaseAuth.instance.currentUser;
  FirebaseService fireService;

  navigateToDetail(String post) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditAgenda(
          post: post,
        ),
      ),
    );
  }

  deleteAgenda(String agendaId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DeleteAgenda(
          post: agendaId,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    if (currentUser != null) {
      print(currentUser.email);

      return;
    }
    setState(() {
      uid = currentUser.uid;
      print(currentUser.uid);
    });
  }

  @override
  Widget build(BuildContext context) {
    final dbRef = FirebaseFirestore.instance
        .collection('profissionais')
        .doc(currentUser.uid)
        .collection('agenda')
        .orderBy('dia')
        .snapshots();

    return Scaffold(
      appBar: AppBar(
        title: Text('Minha Agenda'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed(AppRoutes.ADD_AGENDA),
        child: Icon(Icons.add),
      ),
      body: StreamBuilder(
        stream: dbRef,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!snapshot.hasData) {
            Center(
              child: Text('Não existem horários disponíveis'),
            );
          }
          return ListView(
            children: snapshot.data.docs.map((document) {
              return Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        "Data: " + document['dia'].toString(),
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      Text("Local: " + document['local'],
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          )),
                      Text("Valor: " + document['valor'],
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          )),
                      Text("Cidade: " + document['cidade'],
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                              alignment: Alignment.centerLeft,
                              onPressed: () => navigateToDetail(document.id),
                              icon: Icon(Icons.edit)),
                          IconButton(
                              color: Colors.red[500],
                              alignment: Alignment.center,
                              onPressed: () => deleteAgenda(document.id),
                              icon: Icon(Icons.delete)),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
