import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ConsultasDoc extends StatefulWidget {
  @override
  _ConsultasDocState createState() => _ConsultasDocState();
}

class _ConsultasDocState extends State<ConsultasDoc> {
  var currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    var dbRef = FirebaseFirestore.instance
        .collection('profissionais')
        .doc(currentUser.uid)
        .collection('agenda')
        .doc()
        .collection('paciente')
        .orderBy('dia')
        .snapshots();
    // .map((event) => null);
    print(dbRef);
    return Scaffold(
      appBar: AppBar(
        title: Text('Consutas agendadas'),
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
              child: Container(child: Text('Não existem horários agendados')),
            );
          }

          return !snapshot.hasData
              ? Center(
                  child:
                      Container(child: Text('Não existem horários agendados')),
                )
              : ListView(
                  children: snapshot.data.docs.map((document) {
                    print(snapshot.data.docs);
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
                            Text("Paciente: " + document['nomePac'],
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                )),
                            Text("Telefone de contato: " + document['telPac'],
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                )),
                            Text("Local: " + document['local'],
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                )),
                            Text("Valor a pagar: " + document['valor'],
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                )),
                            Text("Cidade: " + document['cidade'],
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                )),
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
