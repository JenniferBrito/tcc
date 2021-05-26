import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String nome;
  final String tel;
  final String espec;
  final String instReg;
  final String numInsc;

  User({
    this.nome,
    this.tel,
    this.espec,
    this.instReg,
    this.numInsc,
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

  User.fromSnapshot(DocumentSnapshot snapshot)
      : nome = snapshot.data()['nome'],
        tel = snapshot.data()['tel'],
        espec = snapshot.data()['espec'],
        instReg = snapshot.data()['instReg'],
        numInsc = snapshot.data()['numInsc'];
}
