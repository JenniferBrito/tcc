import 'package:flutter/material.dart';

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
      actions: <Widget>[
        TextButton(
          child: Text('Cancelar'),
          onPressed: () => Navigator.pop(context, null),
        ),
        TextButton(
          child: Text('Deletar'),
          onPressed: () => Navigator.of(context).pop(
            fireService.deleteAgenda(widget.post),
          ),
        ),
      ],
    );
  }
}
