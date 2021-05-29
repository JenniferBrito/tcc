import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tcc/providers/auth_type_selector.dart';
import 'package:tcc/providers/search.dart';
import 'package:tcc/utils/app_routes.dart';
import 'package:tcc/views/cadastro_local.dart';
import 'package:tcc/views/edit_doc.dart';
import 'package:tcc/views/edit_user.dart';
import 'package:tcc/widgets/doc_card.dart';
import 'package:tcc/providers/doc_detail.dart';
import 'views/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tela inicial',
      theme: ThemeData.light(),
      home: ListDoc(),
      routes: {
        AppRoutes.EDIT_PACIENTE: (ctx) => EditUSer(),
        AppRoutes.EDIT_PROFISSIONAL: (ctx) => EditDoc(),
        AppRoutes.DOC_DETAIL: (ctx) => DocDetail(),
        AppRoutes.LIST_DOC: (ctx) => ListDoc(),
      },
    );
  }
}
