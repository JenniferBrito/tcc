
import 'package:flutter/material.dart';
import 'package:tcc/utils/app_routes.dart';
import 'package:tcc/widgets/app_drawer.dart';

class HomeDoc extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bem Vindo!'),
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
                onTap: () => Navigator.of(context)
                    .pushNamed(AppRoutes.EDIT_PROFISSIONAL),
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
                    Navigator.of(context).pushNamed(AppRoutes.DOC_AGENDA),
                child: Icon(Icons.medical_services, size: 36),
              ),
              footer: GridTileBar(
                backgroundColor: Colors.blueAccent,
                title: Text('Minha agenda'),
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: GridTile(
              child: GestureDetector(
                onTap: () => // adicionar página com consultas marcadas
                    Navigator.of(context).pushNamed(AppRoutes.DOC_AGENDA),
                child: Icon(
                  Icons.schedule,
                  size: 36,
                ),
              ),
              footer: GridTileBar(
                backgroundColor: Colors.blueAccent,
                title: Text('Minhas avaliações'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}