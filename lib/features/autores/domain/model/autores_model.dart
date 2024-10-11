class AutoresModel {
  final int id;
  final String nome;

  const AutoresModel({required this.id, required this.nome});

  factory AutoresModel.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('autor_id') && json.containsKey('nome')) {
      return AutoresModel(
        id: json['autor_id'],
        nome: json['nome'],
      );
    } else {
      throw const FormatException('Falhou ao buscar os autores.');
    }
  }
}

class postAutores {
  final int id;
  final String nome;

  const postAutores({required this.id, required this.nome});

  factory postAutores.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'nome': String nome,
      } =>
        postAutores(id: id, nome: nome),
      _ => throw const FormatException('Falha ao postar o autor.'),
    };
  }
}

class deleteAutores {
  int autor_id;

  deleteAutores({required this.autor_id});

  factory deleteAutores.fromJson(Map<String, dynamic> json) {
    return deleteAutores(
      autor_id: json['autor_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'autor_id': autor_id,
    };
  }
}

class putAutores {
  final String nome;

  const putAutores({required this.nome});

  factory putAutores.fromJson(Map<String, dynamic> json) {
    return putAutores(
      nome: json['nome'],
    );
  }
  Map<String, dynamic> toJson() {
    return {'nome': nome};
  }
}
