import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:tcc/providers/firebase_services.dart';

class EditDoc extends StatefulWidget {
  @override
  _EditDocState createState() => _EditDocState();
}

class _EditDocState extends State<EditDoc> {
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
              // get nome
              FormBuilderTextField(
                decoration: InputDecoration(labelText: 'Nome Completo'),
                attribute: "nome",
              ),
              // get telefone
              FormBuilderTextField(
                attribute: "tel",
                validators: [
                  //FormBuilderValidators.max(13),
                  FormBuilderValidators.required(),
                ],
                decoration: InputDecoration(labelText: 'Telefone de Contato'),
              ),
              // get especialização
              FormBuilderTextField(
                attribute: "espec",
                validators: [
                  FormBuilderValidators.required(),
                ],
                decoration: InputDecoration(labelText: 'Especialização'),
              ),
              // get número de inscrição
              FormBuilderTextField(
                attribute: "numInsc",
                validators: [
                  FormBuilderValidators.numeric(),
                  FormBuilderValidators.required(),
                ],
                decoration: InputDecoration(labelText: 'CRM/CRP'),
              ),
              // get instituição reguladora
              FormBuilderTextField(
                attribute: "instReg",
                validators: [
                  FormBuilderValidators.max(3),
                  FormBuilderValidators.required(),
                ],
                decoration: InputDecoration(
                  labelText: 'Tipo documento',
                  hintText: 'CRM ou CRP',
                ),
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
    if (_formKey.currentState.saveAndValidate()) {
      sendForm.updateProfissional(
        _formKey.currentState.value['nome'],
        _formKey.currentState.value['tel'],
        _formKey.currentState.value['espec'],
        _formKey.currentState.value['numInsc'],
        _formKey.currentState.value['instReg'],
      );
    }
  }


}
