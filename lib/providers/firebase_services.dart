import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  final String uid;
  final FirebaseAuth auth;

  FirebaseService({
    this.uid,
    this.auth,
  });

  final CollectionReference pacienteCollection =
      FirebaseFirestore.instance.collection('pacientes');

  final CollectionReference profissionaisCollection =
      FirebaseFirestore.instance.collection('profissionais');

  final CollectionReference locaisCollection =
      FirebaseFirestore.instance.collection('locais');

  Future<void> cadastroLocal(
    String nome,
    String rua,
    String numero,
    String bairro,
    String cidade,
    String tel,
  ) async {
    return await locaisCollection.doc(uid).set({
      'nome': nome,
      'rua': rua,
      'numero': numero,
      'bairro': bairro,
      'cidade': cidade,
      'tel': tel,
    });
  }

  Future<void> updatePaciente(
    String nome,
    String tel,
    String numInsc,
    String instReg,
  ) async {
    return await pacienteCollection.doc(uid).set({
      'nome': nome,
      'tel': tel,
      'numInsc': numInsc,
      'instReg': instReg,
    });
  }

  Future<void> updateProfissional(
    String nome,
    String tel,
    String espec,
    String numInsc,
    String instReg,
  ) async {
    return await profissionaisCollection.doc(uid).set({
      'nome': nome,
      'tel': tel,
      'espec': espec,
      'numInsc': numInsc,
      'instReg': instReg,
    });
  }
}
