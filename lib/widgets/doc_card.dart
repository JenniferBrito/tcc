import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tcc/providers/doc_detail.dart';

class ListDoc extends StatefulWidget {
  @override
  _ListDocState createState() => _ListDocState();
}

class _ListDocState extends State<ListDoc> {
  Future _data;

  Future getProfissionais() async {
    var firestore = FirebaseFirestore.instance;

    QuerySnapshot qn = await firestore.collection("profissionais").get();

    return qn.docs;
  }

  navigateToDetail(DocumentSnapshot post) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DocDetail(
          post: post,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _data = getProfissionais();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: _data,
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Scaffold(
              appBar: AppBar(
                title: Text('Profissionais'),
              ),
              body: ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (_, index) {
                  return ListTile(
                    title: Text(snapshot.data[index].data()['nome']),
                    onTap: () => navigateToDetail(snapshot.data[index]),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
