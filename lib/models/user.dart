class User {
  final email = String;
  final nome = String;
  final senha = String;
  final tel = String;
}

class UserPaciente extends User {
  final dataNasc = DateTime;
  final cpf = String;
}

class UserProfissional extends User {
  final espec = String;
  final instReg = String;
  final numInscricao = String;
}
