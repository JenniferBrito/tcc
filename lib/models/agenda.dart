import 'package:cloud_firestore/cloud_firestore.dart';

class Agenda {
  final String uid;
  final String local;
  final String cidade;
  final DateTime dia;
  final String valor;

  Agenda({
    this.uid,
    this.local,
    this.cidade,
    this.dia,
    this.valor,
  });

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'local': local,
      'cidade': cidade,
      'dia': dia,
      'valor': valor,
    };
  }

  Agenda.fromSnapshot(DocumentSnapshot snapshot)
      : uid = snapshot.data()['uid'],
        local = snapshot.data()['local'],
        cidade = snapshot.data()['cidade'],
        dia = snapshot.data()['dia'],
        valor = snapshot.data()['valor'];

  Agenda.fromJson(Map<String, dynamic> json)
      : uid = json['uid'],
        local = json['local'],
        cidade = json['cidade'],
        dia = json['dia'],
        valor = json['valor'];
}
