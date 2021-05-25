class User {
  final String nome;
  final String tel;
  final String espec;
  final String instReg;
  final String numInscricao;

  User({
    this.nome,
    this.tel,
    this.espec,
    this.instReg,
    this.numInscricao,
  });

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'tel': tel,
      'espec': espec,
      'instReg': instReg,
      'numInsc': numInscricao,
    };
  }
}
