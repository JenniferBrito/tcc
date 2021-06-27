import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:tcc/providers/firebase_services.dart';
import 'package:tcc/utils/app_routes.dart';

class AddDoc extends StatefulWidget {
  @override
  _AddDocState createState() => _AddDocState();
}

class _AddDocState extends State<AddDoc> {
  final FirebaseService sendForm = FirebaseService();
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  bool _success;

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
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 16),
                child: TextButton(
                  autofocus: false,
                  clipBehavior: Clip.none,
                  child: Text('Salvar'),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      _submit();
                      if (_success) {
                        Navigator.of(context).pushNamed(AppRoutes.HOME_DOC);
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submit() {
    if (_formKey.currentState.saveAndValidate()) {
      sendForm.setProfissional(
        _formKey.currentState.value['nome'],
        _formKey.currentState.value['tel'],
        _formKey.currentState.value['espec'],
        _formKey.currentState.value['numInsc'],
        _formKey.currentState.value['instReg'],
      );
      setState(() {
        return _success = true;
      });
    } else {
      _success = false;
    }
  }
}
