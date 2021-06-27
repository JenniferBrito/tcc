import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_builder.dart';
import 'package:tcc/providers/cadastroUser.dart';
import 'package:tcc/providers/login_prof.dart';
import 'package:tcc/providers/login_user.dart';

class AuthTypeSelector extends StatelessWidget {
  void _pushPage(BuildContext context, Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          //  title: const Text('Firebase Example App'),
          ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(16),
            alignment: Alignment.center,
            child: SignInButtonBuilder(
              icon: Icons.person_add,
              backgroundColor: Colors.indigo,
              text: 'Cadastro',
              onPressed: () => _pushPage(context, CadastroUser()),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            alignment: Alignment.center,
            child: SignInButtonBuilder(
              icon: Icons.verified_user,
              backgroundColor: Colors.orange,
              text: 'Login Paciente',
              onPressed: () => _pushPage(context, Login()),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            alignment: Alignment.center,
            child: SignInButtonBuilder(
              icon: Icons.verified_user,
              backgroundColor: Colors.orange,
              text: 'Login Profissional',
              onPressed: () => _pushPage(context, LoginProf()),
            ),
          ),
        ],
      ),
    );
  }
}
