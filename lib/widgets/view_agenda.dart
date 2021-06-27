import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ViewAgenda extends StatefulWidget {
  final DocumentSnapshot post;
  const ViewAgenda({this.post});

  @override
  _ViewAgendaState createState() => _ViewAgendaState();
}

class _ViewAgendaState extends State<ViewAgenda> {
  String userId = '';
  String nomePac;
  String telPac;
  var currentUser = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    super.initState();
    getPaciente();
  }

  getPaciente() {
    FirebaseFirestore.instance
        .collection('pacientes')
        .doc(currentUser.uid)
        .snapshots()
        .listen((document) {
      setState(() {
        nomePac = document.data()['nome'];
        telPac = document.data()['tel'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    String uid = widget.post.id;
    String nomeDoc = widget.post['nome'].toString();
    final dbRef = FirebaseFirestore.instance
        .collection('profissionais')
        .doc(uid)
        .collection('agenda')
        .orderBy("dia", descending: false)
        .snapshots();

    agendado(String id, String local, String cidade, String dia, String valor,
        String nomeDoc, String idDoc) {
      bool agendado = true;

      try {
        FirebaseFirestore.instance
            .collection('profissionais')
            .doc(uid)
            .collection('agenda')
            .doc(id)
            .update({'isAgendado': agendado});

        FirebaseFirestore.instance
            .collection('profissionais')
            .doc(uid)
            .collection('agenda')
            .doc(id)
            .collection('paciente')
            .doc()
            .set({
          'nomePac': nomePac,
          'telPac': telPac,
          'local': local,
          'cidade': cidade,
          'dia': dia,
          'valor': valor,
          'isAgendado': agendado
        });

        FirebaseFirestore.instance
            .collection('pacientes')
            .doc(currentUser.uid)
            .collection('consultas')
            .doc()
            .set({
          'idConsulta': id,
          'local': local,
          'cidade': cidade,
          'dia': dia,
          'valor': valor,
          'nomeDoc': nomeDoc,
          'idDoc': idDoc
        });

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Consulta marcada com sucesso'),
          duration: Duration(seconds: 5),
        ));
      } catch (e) {
        print(e);
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Ocorreu um erro, tente novamente')));
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Agenda'),
      ),
      body: StreamBuilder(
        stream: dbRef,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                          style: TextStyle(color: Colors.black, fontSize: 15)),
                      Text("Valor: " + document['valor'],
                          style: TextStyle(color: Colors.black, fontSize: 15)),
                      Text("Cidade: " + document['cidade'],
                          style: TextStyle(color: Colors.black, fontSize: 15)),
                      ElevatedButton(
                        child: Text('Marcar consulta'),
                        onPressed: document['isAgendado'] == false
                            ? () => showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    title: const Text('Marcar Consulta'),
                                    content: const Text(
                                        'Deseja marcar consulta neste horário?'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, 'Cancel'),
                                        child: const Text('Cancelar'),
                                      ),
                                      TextButton(
                                        child: const Text('OK'),
                                        onPressed: () =>
                                            Navigator.of(context).pop(agendado(
                                          document.id,
                                          document['local'].toString(),
                                          document['cidade'].toString(),
                                          document['dia'].toString(),
                                          document['valor'].toString(),
                                          nomeDoc,
                                          uid,
                                        )),
                                      ),
                                    ],
                                  ),
                                )
                            : () => showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    title: const Text('Horário não disponível'),
                                    content: const Text(
                                        'Esse horário não está disponível, tente novamente'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, 'OK'),
                                        child: const Text('Ok'),
                                      ),
                                    ],
                                  ),
                                ),
                      )
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
