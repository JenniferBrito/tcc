import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tcc/dialog/review_dialog.dart';
import 'package:tcc/providers/add_detail_doc.dart';
import 'package:tcc/providers/add_detail_user.dart';
import 'package:tcc/providers/auth_type_selector.dart';
import 'package:tcc/providers/cadastroUser.dart';
import 'package:tcc/providers/login_user.dart';
import 'package:tcc/providers/nova_agenda.dart';
import 'package:tcc/providers/review_doc.dart';
import 'package:tcc/providers/search.dart';
import 'package:tcc/utils/app_routes.dart';
import 'package:tcc/views/agenda_doc.dart';
import 'package:tcc/views/cadastro_local.dart';
import 'package:tcc/views/edit_doc.dart';
import 'package:tcc/views/edit_user.dart';
import 'package:tcc/widgets/doc_card.dart';
import 'package:tcc/providers/doc_detail.dart';

import 'dialog/delete_agenda_dialog.dart';
import 'views/edit_agenda.dart';
import 'views/home.dart';
import 'views/home_doc.dart';

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
      home: Login(),
      routes: {
        AppRoutes.EDIT_PACIENTE: (ctx) => EditUSer(),
        AppRoutes.EDIT_PROFISSIONAL: (ctx) => EditDoc(),
        AppRoutes.DOC_DETAIL: (ctx) => DocDetail(),
        AppRoutes.LIST_DOC: (ctx) => ListDoc(),
        AppRoutes.REVIEW: (ctx) => ReviewCreateDialog(),
        AppRoutes.ADD_DETAIL: (ctx) => RegisterUser(),
        AppRoutes.ADD_DOC_DETAIL: (ctx) => AddDoc(),
        AppRoutes.HOME: (ctx) => Home(),
        AppRoutes.HOME_DOC: (ctx) => HomeDoc(),
        AppRoutes.ADD_AGENDA: (ctx) => NovaAgenda(),
        AppRoutes.DOC_AGENDA: (ctx) => AgendaDoc(),
        AppRoutes.EDIT_AGENDA: (ctx) => EditAgenda(),
        AppRoutes.DELETE_AGENDA: (ctx) => DeleteAgenda(),
      },
    );
  }
}
