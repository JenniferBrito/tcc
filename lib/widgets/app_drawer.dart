import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tcc/providers/login_user.dart';
import 'package:tcc/utils/app_routes.dart';

class AppDrawer extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
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
            title: Text('Profissionais'),
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
            title: Text('Minhas consultas'),
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
            onTap: () {
              Provider.of<Login>(context, listen: false).signOut();
            },
          ),
        ],
      ),
    );
  }
}
