import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:tcc/providers/firebase_services.dart';

class EditUSer extends StatefulWidget {
  @override
  _EditUSerState createState() => _EditUSerState();
}

class _EditUSerState extends State<EditUSer> {
  final FirebaseService sendForm = FirebaseService();
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Perfil'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: FormBuilder(
          key: _formKey,
          child: ListView(
            children: [
              FormBuilderTextField(
                decoration: InputDecoration(labelText: 'Nome Completo'),
                attribute: "nome",
              ),
              FormBuilderTextField(
                attribute: "tel",
                validators: [
                  //FormBuilderValidators.max(13),
                  FormBuilderValidators.required(),
                ],
                decoration: InputDecoration(labelText: 'Telefone de Contato'),
              ),
              FormBuilderTextField(
                attribute: 'numInsc',
                validators: [
                  FormBuilderValidators.numeric(),
                  FormBuilderValidators.required(),
                ],
                decoration: InputDecoration(labelText: 'CPF/RG'),
              ),
              FormBuilderTextField(
                attribute: 'instReg',
                validators: [
                  FormBuilderValidators.max(3),
                  FormBuilderValidators.required(),
                ],
                decoration: InputDecoration(
                  labelText: 'Tipo documento',
                  hintText: 'CPF ou RG',
                ),
              ),
              TextButton(
                  autofocus: false,
                  clipBehavior: Clip.none,
                  child: Text('Salvar'),
                  onPressed: () => _submit()),
            ],
          ),
        ),
      ),
    );
  }

  void _submit() {
    if (_formKey.currentState.saveAndValidate()) {
      sendForm.updatePaciente(
        _formKey.currentState.value['nome'],
        _formKey.currentState.value['tel'],
        _formKey.currentState.value['instReg'],
        _formKey.currentState.value['numInsc'],
      );
    }
  }
}
