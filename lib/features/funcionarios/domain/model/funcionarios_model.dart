class FuncionariosModel {
  final int id;
  final String nome;

  const FuncionariosModel({required this.id, required this.nome});

  factory FuncionariosModel.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('matricula') && json.containsKey('nome')) {
      return FuncionariosModel(
        id: json['matricula'],
        nome: json['nome'],
      );
    } else {
      throw const FormatException('Falhou ao buscar os funcionarios.');
    }
  }
}

class postFuncionarios {
  final int id;
  final String nome;

  const postFuncionarios({required this.id, required this.nome});

  factory postFuncionarios.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'matricula': int id,
        'nome': String nome,
      } =>
        postFuncionarios(id: id, nome: nome),
      _ =>
        throw const FormatException('Falha ao cadratrar o(a) funcionario(a).'),
    };
  }
}

class deleteFuncionarios {
  int matricula;

  deleteFuncionarios({required this.matricula});

  factory deleteFuncionarios.fromJson(Map<String, dynamic> json) {
    return deleteFuncionarios(
      matricula: json['matricula'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'matricula': matricula,
    };
  }
}

class putFuncionarios {
  final String nome;

  const putFuncionarios({required this.nome});

  factory putFuncionarios.fromJson(Map<String, dynamic> json) {
    return putFuncionarios(
      nome: json['nome'],
    );
  }
  Map<String, dynamic> toJson() {
    return {'nome': nome};
  }
}
