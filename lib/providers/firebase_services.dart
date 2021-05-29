import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tcc/models/user.dart';
import 'package:tcc/providers/review_doc.dart';

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

  Future<void> addReview({String profissionalId, Review review}) {
    final profissional = FirebaseFirestore.instance
        .collection('profissionais')
        .doc(profissionalId);
    final newReview = profissional.collection('ratings').doc();

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
