import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_signin_button/button_builder.dart';
import 'package:tcc/utils/app_routes.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class CadastroUser extends StatefulWidget {
  final String title = 'Cadastrar';

  @override
  State<StatefulWidget> createState() => _CadastroUserState();
}

class _CadastroUserState extends State<CadastroUser> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _success = true;
  String _userEmail = '';
  String dropdownValue = 'Paciente';
  String newValue = '';
  String value = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Form(
        key: _formKey,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Insira email válido';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: 'Senha'),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Insira uma senha';
                    }
                    return null;
                  },
                  obscureText: true,
                ),
                DropdownButton<String>(
                  value: dropdownValue,
                  icon: const Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (newValue) => dropdownValue = newValue,
                  items: <String>['Paciente', 'Profissional de saúde']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  alignment: Alignment.center,
                  child: SignInButtonBuilder(
                    icon: Icons.person_add,
                    backgroundColor: Colors.blueGrey,
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        await _register();
                        if (_success) {
                          if (dropdownValue == 'Paciente') {
                            Navigator.of(context)
                                .popAndPushNamed(AppRoutes.ADD_DETAIL);
                          }
                          if (dropdownValue == 'Profissional de saúde') {
                            Navigator.of(context)
                                .popAndPushNamed(AppRoutes.ADD_DOC_DETAIL);
                          }
                        }
                      }
                    },
                    text: 'Cadastrar',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    final User user = (await _auth.createUserWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    ))
        .user;

    if (user != null) {
      setState(() {
        _success = true;
        _userEmail = user.email;
      });
    } else {
      _success = false;
    }
  }
}
