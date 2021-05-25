import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:tcc/providers/firebase_services.dart';

class CadastroLocal extends StatefulWidget {
  @override
  _CadastroLocalState createState() => _CadastroLocalState();
}

class _CadastroLocalState extends State<CadastroLocal> {
  final FirebaseService sendForm = FirebaseService();
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastrar Local de Trabalho'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: FormBuilder(
          key: _formKey,
          child: ListView(
            children: [
              FormBuilderTextField(
                decoration: InputDecoration(labelText: 'Nome da Instituição'),
                attribute: "nome",
              ),
              FormBuilderTextField(
                attribute: "rua",
                validators: [
                  FormBuilderValidators.required(),
                ],
                decoration: InputDecoration(labelText: 'Rua'),
              ),
              FormBuilderTextField(
                attribute: "numero",
                validators: [
                  FormBuilderValidators.required(),
                ],
                decoration: InputDecoration(labelText: 'Número'),
              ),
              FormBuilderTextField(
                attribute: "bairro",
                validators: [
                  FormBuilderValidators.required(),
                ],
                decoration: InputDecoration(labelText: 'Bairro'),
              ),
              FormBuilderTextField(
                attribute: "cidade",
                validators: [
                  FormBuilderValidators.required(),
                ],
                decoration: InputDecoration(labelText: 'Cidade'),
              ),
              FormBuilderTextField(
                attribute: "tel",
                validators: [
                  //FormBuilderValidators.max(13),
                  FormBuilderValidators.required(),
                ],
                decoration: InputDecoration(labelText: 'Telefone de Contato'),
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
      sendForm.cadastroLocal(
        _formKey.currentState.value['nome'],
        _formKey.currentState.value['rua'],
        _formKey.currentState.value['numero'],
        _formKey.currentState.value['bairro'],
        _formKey.currentState.value['cidade'],
        _formKey.currentState.value['tel'],
      );
    }
  }
}
