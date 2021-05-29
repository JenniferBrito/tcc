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
        body: SingleChildScrollView(
          child: Column(
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
            ],
          ),
        ));
  }
}
/*
Container(
        child: Card(

          child: ListTile(
            title: Text(
              widget.post['nome'],
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              widget.post['espec'],
              style: TextStyle(fontSize: 20, color: Colors.grey),
            ),
            
          ),
        ),
      ),

*/
