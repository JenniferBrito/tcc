import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:tcc/providers/firebase_services.dart';

class DeleteAgenda extends StatefulWidget {
  final String post;

  const DeleteAgenda({Key key, this.post});

  @override
  _DeleteAgendaState createState() => _DeleteAgendaState();
}

class _DeleteAgendaState extends State<DeleteAgenda> {
  FirebaseService fireService;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Deletar horário?'),
      content: Container(
        width: math.min(MediaQuery.of(context).size.width, 16),
        height: math.min(MediaQuery.of(context).size.height, 18),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Cancelar'),
          onPressed: () => Navigator.pop(context, null),
        ),
        ElevatedButton(
          child: Text('Deletar'),
          onPressed: () => Navigator.pop(
            context,
            fireService.deleteAgenda(widget.post),
          ),
        ),
      ],
    );
  }
}
