import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tcc/widgets/view_agenda.dart';
import 'firebase_services.dart';

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

  void navigateToDetail(DocumentSnapshot post) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ViewAgenda(
          post: post,
        ),
      ),
    );
  }

  _DocDetailState();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.post['nome']),
        actions: [
          IconButton(
              onPressed: () {
                navigateToDetail(widget.post);
                print(widget.post.id.toString());
              },
              icon: Icon(Icons.calendar_today_outlined)),
        ],
      ),
      body: ListView(
        children: [
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(children: [
                Text(widget.post['espec'],
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start),
                Text(
                  '${widget.post['instReg']}: ${widget.post['numInsc']}',
                  style: TextStyle(color: Colors.grey, fontSize: 20),
                  textAlign: TextAlign.justify,
                ),
                Text(
                  'Telefone de contato: ${widget.post['tel']}',
                  style: TextStyle(color: Colors.grey, fontSize: 20),
                  textAlign: TextAlign.justify,
                ),
                //add classificação e review
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
