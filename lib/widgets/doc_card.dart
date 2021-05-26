import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tcc/models/user.dart';

Widget buildDocCard(
  BuildContext context,
  DocumentSnapshot document,
) {
  final user = User.fromSnapshot(document);

  return new Container(
    child: Card(
      child: InkWell(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                child: Row(children: <Widget>[
                  Text(
                    user.nome,
                  ),
                  Spacer(),
                ]),
              ),
            ],
          ),
        ),
        onTap: () => {},
      ),
    ),
  );
}
