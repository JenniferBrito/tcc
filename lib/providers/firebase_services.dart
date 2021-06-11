import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tcc/models/user.dart';
import 'package:tcc/providers/review_doc.dart';

class FirebaseService {
  FirebaseAuth auth = FirebaseAuth.instance;
  String uid;
  String id;
  FirebaseFirestore agenda = FirebaseFirestore.instance;
  Usuario profissional;

  final CollectionReference pacienteCollection =
      FirebaseFirestore.instance.collection('pacientes');

  final CollectionReference profissionaisCollection =
      FirebaseFirestore.instance.collection('profissionais');

  final CollectionReference profissionaisAgenda = FirebaseFirestore.instance
      .collection('profissionais')
      .doc()
      .collection('agenda');

  getId() {
    docId = auth.currentUser.uid.toString();
    return docId;
  }

  final CollectionReference locaisCollection =
      FirebaseFirestore.instance.collection('locais');

  String docId;

  Future<void> cadastroLocal(
    String nome,
    String rua,
    String numero,
    String bairro,
    String cidade,
    String tel,
  ) async {
    return await locaisCollection.doc().set({
      'nome': nome,
      'rua': rua,
      'numero': numero,
      'bairro': bairro,
      'cidade': cidade,
      'tel': tel,
    });
  }

  Future<void> addAgenda(
    String local,
    String cidade,
    DateTime dia,
    String valor,
  ) async {
    try {
      return await FirebaseFirestore.instance
          .collection('profissionais')
          .doc(auth.currentUser.uid)
          .collection('agenda')
          .doc()
          .set({
        'uid': FirebaseFirestore.instance
            .collection('profissionais')
            .doc(auth.currentUser.uid)
            .collection('agenda')
            .doc()
            .id
            .toString(),
        'local': local,
        'cidade': cidade,
        'dia': dia.toString(),
        'valor': valor,
      });
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<void> setPaciente(
    String nome,
    String tel,
    String numInsc,
    String instReg,
  ) async {
    String uid = auth.currentUser.uid.toString();
    return await pacienteCollection.doc(uid).set({
      'nome': nome,
      'tel': tel,
      'numInsc': numInsc,
      'instReg': instReg,
      'uid': uid,
    });
  }

  Future<void> updatePaciente(
    String nome,
    String tel,
    String numInsc,
    String instReg,
  ) async {
    return await pacienteCollection.doc(uid).update({
      'nome': nome,
      'tel': tel,
      'numInsc': numInsc,
      'instReg': instReg,
    });
  }

  Future<void> setProfissional(
    String nome,
    String tel,
    String espec,
    String numInsc,
    String instReg,
  ) async {
    String uid = auth.currentUser.uid.toString();
    return await profissionaisCollection.doc(uid).set({
      'nome': nome,
      'tel': tel,
      'espec': espec,
      'numInsc': numInsc,
      'instReg': instReg,
      'uid': uid,
      'avgRatings': null,
      'numRatings': null
    });
  }

  Future<void> updateProfissional(
    String nome,
    String tel,
    String espec,
    String numInsc,
    String instReg,
  ) async {
    return await profissionaisCollection.doc(uid).update({
      'nome': nome,
      'tel': tel,
      'espec': espec,
      'numInsc': numInsc,
      'instReg': instReg,
    });
  }

  Future<void> addReview({String profissionalId, Review review, id}) {
    final profissional = FirebaseFirestore.instance
        .collection('profissionais')
        .doc(profissionalId);
    final newReview = FirebaseFirestore.instance.collection('ratings').doc();

    return FirebaseFirestore.instance.runTransaction((Transaction transaction) {
      return transaction
          .get(profissional)
          .then((DocumentSnapshot doc) => Usuario.fromSnapshot(doc))
          .then((Usuario fresh) {
        final newRatings = fresh.numRatings + 1;
        final newAverage =
            ((fresh.numRatings * fresh.avgRating) + review.rating) / newRatings;

        transaction.update(profissional, {
          'numRatings': newRatings,
          'avgRating': newAverage,
        });

        transaction.set(newReview, {
          'rating': review.rating,
          'text': review.text,
          'timestamp': review.timestamp ?? FieldValue.serverTimestamp(),
        });
      });
    });
  }
}
