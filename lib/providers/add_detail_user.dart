import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:tcc/providers/firebase_services.dart';
import 'package:tcc/utils/app_routes.dart';

class RegisterUser extends StatefulWidget {
  @override
  _RegisterUserState createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {
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
                        Navigator.of(context).pushNamed(AppRoutes.HOME);
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
      sendForm.setPaciente(
        _formKey.currentState.value['nome'],
        _formKey.currentState.value['tel'],
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
