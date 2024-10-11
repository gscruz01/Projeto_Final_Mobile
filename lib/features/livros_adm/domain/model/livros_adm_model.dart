class LivrosAdmModel {
  final int autor_id;
  final int editoras_id;
  final String titulo;
  final String ano_publicacao;
  final int livro_id;

  const LivrosAdmModel(
      {required this.titulo,
      required this.autor_id,
      required this.editoras_id,
      required this.ano_publicacao,
      required this.livro_id});

  factory LivrosAdmModel.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('titulo') &&
        json.containsKey('autor_id') &&
        json.containsKey('editoras_id') &&
        json.containsKey('ano_publicacao') &&
        json.containsKey('livro_id')) {
      return LivrosAdmModel(
          titulo: json['titulo'],
          autor_id: json['autor_id'],
          editoras_id: json['editoras_id'],
          ano_publicacao: json['ano_publicacao'],
          livro_id: json['livro_id']);
    } else {
      throw const FormatException('Falhou ao buscar os Livros');
    }
  }
}

class postLivros {
  final String titulo;
  final String ano_publicacao;
  final int autor_id;
  final int editoras_id;

  const postLivros({
    required this.titulo,
    required this.ano_publicacao,
    required this.autor_id,
    required this.editoras_id,
  });

  factory postLivros.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'titulo': String titulo,
        'ano_publicacao': String ano_publicacao,
        'autor_id': int autor_id,
        'editoras_id': int editoras_id,
      } =>
        postLivros(
          titulo: titulo,
          ano_publicacao: ano_publicacao,
          autor_id: autor_id,
          editoras_id: editoras_id,
        ),
      _ => throw const FormatException('Falha ao postar o Livro.'),
    };
  }
}

class putLivros {
  final String titulo;

  const putLivros({required this.titulo});

  factory putLivros.fromJson(Map<String, dynamic> json) {
    return putLivros(
      titulo: json['titulo'],
    );
  }
  Map<String, dynamic> toJson() {
    return {'titulo': titulo};
  }
}
