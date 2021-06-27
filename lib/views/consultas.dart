import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Consultas extends StatefulWidget {
  @override
  _ConsultasState createState() => _ConsultasState();
}

class _ConsultasState extends State<Consultas> {
  var currentUser = FirebaseAuth.instance.currentUser;

  editConsulta(String id, String docId, String idConsulta) {
    bool agendado = false;
    try {
      FirebaseFirestore.instance
          .collection('profissionais')
          .doc(docId)
          .collection('agenda')
          .doc(idConsulta)
          .update({'isAgendado': agendado});

      FirebaseFirestore.instance
          .collection('profissionais')
          .doc(docId)
          .collection('agenda')
          .doc(idConsulta)
          .collection('paciente')
          .get()
          .then((snapshot) {
        for (DocumentSnapshot ds in snapshot.docs) {
          ds.reference.delete();
        }
      });

      FirebaseFirestore.instance
          .collection('pacientes')
          .doc(currentUser.uid)
          .collection('consultas')
          .doc(id)
          .delete();
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Erro, não foi possível atender sua solicitação')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final dbRef = FirebaseFirestore.instance
        .collection('pacientes')
        .doc(currentUser.uid)
        .collection('consultas')
        .orderBy("dia")
        .snapshots();

    return Scaffold(
      appBar: AppBar(
        title: Text('Minhas consultas'),
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
                      Text("Profissional: " + document['nomeDoc'],
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          )),
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
                          ElevatedButton(
                            child: Text('Desmarcar'),
                            onPressed: () => showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: const Text('Desmarcar consulta'),
                                content: const Text(
                                    'Deseja desmarcar esta consulta?'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'Cancel'),
                                    child: const Text('Cancelar'),
                                  ),
                                  TextButton(
                                    child: const Text('OK'),
                                    onPressed: () => Navigator.of(context).pop(
                                        editConsulta(
                                            document.id,
                                            document['idDoc'],
                                            document['idConsulta'])),
                                  ),
                                ],
                              ),
                            ),
                          ),
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
