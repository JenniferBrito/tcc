import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tcc/dialog/review_dialog.dart';
import 'package:tcc/models/user.dart';
import 'package:tcc/widgets/review.dart';
import 'firebase_services.dart';
import 'review_doc.dart';

class DocDetail extends StatefulWidget {
  final DocumentSnapshot post;

  DocDetail({
    this.post,
  });

  @override
  _DocDetailState createState() => _DocDetailState();
}

class _DocDetailState extends State<DocDetail> {
  FirebaseService data;
  Usuario _doc;
  StreamSubscription<QuerySnapshot> _currentReviewSubscription;

  _DocDetailState() {
    var firestore =
        FirebaseFirestore.instance.collection('users').doc(widget.post['uid']);
    _currentReviewSubscription = firestore
        .collection('ratings')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .listen((QuerySnapshot reviewSnap) {
      setState(() {
        _reviews = reviewSnap.docs.map((DocumentSnapshot doc) {
          return Review.fromSnapshot(doc);
        }).toList();
      });
    });
  }
  @override
  void dispose() {
    _currentReviewSubscription?.cancel();
    super.dispose();
  }

  void _onCreateReviewPressed(BuildContext context) async {
    final newReview = await showDialog<Review>(
      context: context,
      builder: (_) => ReviewCreateDialog(),
    );
    if (newReview != null) {
      // Save the review

      return data.addReview(
        profissionalId: _doc.uid,
        review: newReview,
      );
    }
  }

  List<Review> _reviews = <Review>[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.post['nome']),
        actions: [
          IconButton(
              onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: const Text('Agenda'),
                        duration: const Duration(seconds: 2)),
                  ),
              icon: Icon(Icons.calendar_today_outlined)),
        ],
      ),
      body: Column(
        children: [
          Text(widget.post['espec'],
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.start),
          Text(
            '${widget.post['instReg']}: ${widget.post['numInsc']}',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 20,
            ),
            textAlign: TextAlign.justify,
          ),
          //add classificação e review
          _reviews.isNotEmpty
              ? _reviews
                  .map((Review review) => DocReview(review: review))
                  .toList()
              : Text('${widget.post['nome']} não possui reviews.')
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _onCreateReviewPressed(context),
      ),
    );
  }
}
