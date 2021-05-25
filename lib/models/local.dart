class Local {
  final String nome;
  final String rua;
  final String numero;
  final String bairro;
  final String cidade;
  final String tel;

  Local({
    this.nome,
    this.rua,
    this.numero,
    this.bairro,
    this.cidade,
    this.tel,
  });

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'rua': rua,
      'numero': numero,
      'bairro': bairro,
      'cidade': cidade,
      'tel': tel,
    };
  }
}
