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
      child: GridTile(
        
        child: GestureDetector(
          onTap: () => Navigator.of(context).pushNamed(AppRoutes.EDIT_PACIENTE),
        ),
      ),
    );
  }
}
