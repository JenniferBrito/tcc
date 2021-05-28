import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DocDetail extends StatefulWidget {
  final DocumentSnapshot post;

  const DocDetail({this.post});

  @override
  _DocDetailState createState() => _DocDetailState();
}

class _DocDetailState extends State<DocDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.post.data()['nome'],
      ),
      body: Container(
        child: Card(
          child: ListTile(
            title: Text(
              widget.post.data()['nome'],
            ),
            subtitle: Text(
              widget.post.data()['espec'],
            ),
          ),
        ),
      ),
    );
  }
}
