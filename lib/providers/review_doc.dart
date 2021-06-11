import 'package:cloud_firestore/cloud_firestore.dart';

// This is called "ratings" in the backend.
class Review {
  final String id;
  final double rating;
  final String text;
  final Timestamp timestamp;

  final DocumentReference reference;

  Review.fromSnapshot(DocumentSnapshot snapshot)
      : assert(snapshot != null),
        id = snapshot.id,
        rating = snapshot.data()['rating'].toDouble(),
        text = snapshot.data()['text'],
        timestamp = snapshot.data()['timestamp'],
        reference = snapshot.reference;

  Review.fromUserInput({
    this.rating,
    this.text,
  })  : id = null,
        timestamp = null,
        reference = null;
}
