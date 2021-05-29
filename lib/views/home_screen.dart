import 'package:flutter/material.dart';
import 'package:tcc/utils/app_routes.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Card(
        child: Scaffold(
          appBar: AppBar(
            title: Text('Home'),
          ),
          body: Row(
            children: [
              ListTile(
                
                title: Text('Editar Perfl'),
                onTap: () {
                  Navigator.of(context).pushNamed(AppRoutes.EDIT_PACIENTE);
                },
              ),
              ListTile(
                title: Text('Profissionais'),
                onTap: () {
                  Navigator.of(context).pushNamed(AppRoutes.LIST_DOC);
                },
              ),
              ListTile(
                title: Text('Histórico'),
                onTap: () {
                  Navigator.of(context).pushNamed(AppRoutes.HISTORICO);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
