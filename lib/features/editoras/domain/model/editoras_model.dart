import 'package:ola_mundo/features/autores/presentation/dummies/edit_Autores.dart';

class EditorasModel {
  final int id;
  final String nome;
  final String localizacao;

  const EditorasModel(
      {required this.id, required this.nome, required this.localizacao});

  factory EditorasModel.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('editoras_id') &&
        json.containsKey('nome') &&
        json.containsKey('localizacao')) {
      return EditorasModel(
          id: json['editoras_id'],
          nome: json['nome'],
          localizacao: json['localizacao']);
    } else {
      throw const FormatException('Falhou ao buscar os autores.');
    }
  }
}

class postEditoras {
  final int id;
  final String nome;
  final String localizacao;

  const postEditoras(
      {required this.id, required this.nome, required this.localizacao});

  factory postEditoras.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'nome': String nome,
        'localizacao': String localizacao,
      } =>
        postEditoras(id: id, nome: nome, localizacao: localizacao),
      _ => throw const FormatException('Falha ao postar a Editora.'),
    };
  }
}

class putEditoras {
  final String nome;
  final String localizacao;

  const putEditoras({required this.localizacao, required this.nome});

  factory putEditoras.fromJson(Map<String, dynamic> json) {
    return putEditoras(
      nome: json['nome'],
      localizacao: json['localizacao'],
    );
  }
  Map<String, dynamic> toJson() {
    return {'nome': nome, 'localizacao': localizacao};
  }
}
