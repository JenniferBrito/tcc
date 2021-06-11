import 'package:flutter/material.dart';
import 'package:tcc/utils/app_routes.dart';
import 'package:tcc/widgets/app_drawer.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      drawer: AppDrawer(),
      body: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
        ),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: GridTile(
              child: GestureDetector(
                onTap: () =>
                    Navigator.of(context).pushNamed(AppRoutes.EDIT_PACIENTE),
                child: Icon(
                  Icons.person,
                  size: 36,
                ),
              ),
              footer: GridTileBar(
                backgroundColor: Colors.blueAccent,
                title: Text('Editar perfil'),
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: GridTile(
              child: GestureDetector(
                onTap: () =>
                    Navigator.of(context).pushNamed(AppRoutes.LIST_DOC),
                child: Icon(Icons.medical_services, size: 36),
              ),
              footer: GridTileBar(
                backgroundColor: Colors.blueAccent,
                title: Text('Profissionais'),
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: GridTile(
              child: GestureDetector(
                onTap: () => // adicionar página com consultas marcadas
                    Navigator.of(context).pushNamed(AppRoutes.LIST_DOC),
                child: Icon(
                  Icons.schedule,
                  size: 36,
                ),
              ),
              footer: GridTileBar(
                backgroundColor: Colors.blueAccent,
                title: Text('Minhas consultas'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
