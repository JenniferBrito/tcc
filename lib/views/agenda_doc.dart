import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tcc/utils/app_routes.dart';
import 'package:tcc/widgets/agenda_widget.dart';

class AgendaDoc extends StatefulWidget {
  @override
  _AgendaDocState createState() => _AgendaDocState();
}

class _AgendaDocState extends State<AgendaDoc> {
  String uid = '';
  List<Map<dynamic, dynamic>> lists = [];
  var currentUser = FirebaseAuth.instance.currentUser;

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
          if (!snapshot.hasData) {
            Center(
              child: Center(
                child: Text('Não existem horários disponíveis'),
              ),
            );
          }
          return ListView(
            children: snapshot.data.docs.map((document) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GestureDetector(
                    onTap: () =>
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: const Text('funciona'),
                      duration: const Duration(seconds: 2),
                    )),
                    child: Column(
                      children: [
                        Text(
                          "Data: " + document['dia'],
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
                                onPressed: () => ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: const Text('edit'),
                                      duration: const Duration(seconds: 2),
                                    )),
                                icon: Icon(Icons.edit)),
                            IconButton(
                                color: Colors.redAccent,
                                alignment: Alignment.center,
                                onPressed: () => ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: const Text('delete'),
                                      duration: const Duration(seconds: 2),
                                    )),
                                icon: Icon(Icons.delete)),
                          ],
                        ),
                      ],
                    ),
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
