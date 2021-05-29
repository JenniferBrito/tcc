import 'package:cloud_firestore/cloud_firestore.dart';

class Usuario {
  final String nome;
  final String tel;
  final String espec;
  final String instReg;
  final String numInsc;
  final double avgRating;
  final int numRatings;

  Usuario({
    this.nome,
    this.tel,
    this.espec,
    this.instReg,
    this.numInsc,
    this.avgRating,
    this.numRatings,
  });

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'tel': tel,
      'espec': espec,
      'instReg': instReg,
      'numInsc': numInsc,
    };
  }

  Usuario.fromSnapshot(DocumentSnapshot snapshot)
      : nome = snapshot.data()['nome'],
        tel = snapshot.data()['tel'],
        espec = snapshot.data()['espec'],
        instReg = snapshot.data()['instReg'],
        numInsc = snapshot.data()['numInsc'],
        avgRating = snapshot.data()['avgRating'].toDouble(),
        numRatings = snapshot.data()['numRatings'];

  Usuario.fromJson(Map<String, dynamic> json)
      : nome = json['nome'],
        tel = json['tel'],
        espec = json['espec'],
        instReg = json['instReg'],
        numInsc = json['numInsc'],
        avgRating = json['avgRating'],
        numRatings = json['numRatings'];
}
