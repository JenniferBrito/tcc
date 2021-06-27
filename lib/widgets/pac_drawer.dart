import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tcc/utils/app_routes.dart';

class PacDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<void> signOut() async {
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).popAndPushNamed(AppRoutes.AUTH_HOME);
    }

    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text('Bem Vindo!'),
            automaticallyImplyLeading: false,
          ),
          Divider(
            thickness: 1,
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(AppRoutes.HOME);
            },
          ),
          Divider(
            thickness: 1,
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Editar perfil'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(AppRoutes.EDIT_PACIENTE);
            },
          ),
          Divider(
            thickness: 1,
          ),
          ListTile(
            leading: Icon(Icons.medical_services),
            title: Text('Profissionais'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(AppRoutes.LIST_DOC);
            },
          ),
          Divider(
            thickness: 1,
          ),
          ListTile(
            leading: Icon(Icons.schedule),
            title: Text('Minhas Consultas'),
            onTap: () {
              // adicionar página de histórico
              Navigator.of(context).pushReplacementNamed(AppRoutes.LIST_DOC);
            },
          ),
          Divider(
            thickness: 1,
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Sair'),
            onTap: () => signOut(),
          ),
        ],
      ),
    );
  }
}
