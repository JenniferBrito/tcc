import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:tcc/providers/firebase_services.dart';

class EditAgenda extends StatefulWidget {
  final String post;
  const EditAgenda({this.post});

  @override
  _EditAgendaState createState() => _EditAgendaState();
}

class _EditAgendaState extends State<EditAgenda> {
  FirebaseAuth auth = FirebaseAuth.instance;

  final FirebaseService sendForm = FirebaseService();
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Agenda'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: FormBuilder(
          key: _formKey,
          child: ListView(
            children: [
              // get nome
              FormBuilderTextField(
                decoration: InputDecoration(labelText: 'Local de atendimento'),
                attribute: "local",
              ),
              // get telefone
              FormBuilderTextField(
                attribute: "cidade",
                validators: [
                  //FormBuilderValidators.max(13),
                  FormBuilderValidators.required(),
                ],
                decoration: InputDecoration(labelText: 'Cidade'),
              ),
              FormBuilderDateTimePicker(
                decoration: InputDecoration(labelText: 'Data'),
                attribute: "dia",
                validators: [
                  FormBuilderValidators.required(),
                ],
              ),
              // get especialização
              FormBuilderTextField(
                attribute: "valor",
                validators: [
                  FormBuilderValidators.required(),
                ],
                decoration: InputDecoration(labelText: 'Valor da consulta'),
              ),

              // set dados
              TextButton(
                autofocus: false,
                clipBehavior: Clip.none,
                child: Text('Salvar'),
                onPressed: () => _submit(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submit() {
    try {
      if (_formKey.currentState.saveAndValidate()) {
        sendForm.updateAgenda(
          widget.post,
          _formKey.currentState.value['local'],
          _formKey.currentState.value['cidade'],
          _formKey.currentState.value['dia'],
          _formKey.currentState.value['valor'],
          
        );
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Sucesso!'),
        ));
        Navigator.of(context).pop();
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Inválido'),
        ),
      );
    }
  }
}
