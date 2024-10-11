import 'dart:convert';
import 'dart:ffi';
import 'package:ola_mundo/features/livros/domain/model/livros_model.dart';
import 'package:ola_mundo/features/autores/domain/model/autores_model.dart';
import 'package:ola_mundo/features/editoras/domain/model/editoras_model.dart';
import 'package:http/http.dart' as http;
import 'package:ola_mundo/shared/endpoint.dart';

class LivrosRepositoryImpl {
  final String baseUrl = 'http://10.0.2.2:3000';
  late final Endpoint endpoint;

  Future<List<LivrosAdmModel>> getLivros() async {
    final response =
        await http.get(Uri.parse('$baseUrl${Endpoint.listLivros}'));
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((item) => LivrosAdmModel.fromJson(item)).toList();
    } else {
      throw Exception('Falha ao carregar livros');
    }
  }

  Future<LivrosAdmModel> postLivros(String titulo, String ano_publicacao,
      int autor_id, int editoras_id) async {
    print(
        'Enviando dados: titulo=$titulo, ano_publicacao= $ano_publicacao, autor_id= $autor_id, editoras_id= $editoras_id');
    final response = await http.post(
      Uri.parse('$baseUrl${Endpoint.postLivros}'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'titulo': titulo,
        'ano_publicacao': ano_publicacao,
        'autor_id': autor_id,
        'editoras_id': editoras_id,
      }),
    );
    print('Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');
    if (response.statusCode == 201) {
      return LivrosAdmModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Falha ao criar Livro.');
    }
  }

  Future<LivrosAdmModel> putLivros(String id, String titulo) async {
    final response = await http.put(
      Uri.parse('$baseUrl${Endpoint.editLivros}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'livro_id': id,
        'titulo': titulo,
      }),
    );
    if (response.statusCode == 200) {
      return LivrosAdmModel.fromJson(
        jsonDecode(response.body),
      );
    } else {
      print('Falha ao editar o livro: ${response.statusCode}');
      throw Exception('Falha ao editar o livro');
    }
  }

  Future<void> deleteLivros(int id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl${Endpoint.deleteLivros}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, int>{
        'livro_id': id,
      }),
    );
    if (response.statusCode == 200) {
      print('Livro deletado com sucesso');
    } else {
      print('Falha ao deletar Livro ${response.statusCode} ${response.body}');
      throw Exception('Falha ao deletar Livro.');
    }
  }

  Future<bool> autorExiste(int autor_Id) async {
    final response =
        await http.get(Uri.parse('$baseUrl${Endpoint.listAutores}'));
    print('Status Code: ${response.statusCode}');
    print('Response Body Editora: ${response.body}');
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.any((autor) => autor['autor_id'] == autor_Id);
    } else {
      throw Exception('Erro ao verificar se o autor existe.');
    }
  }

  Future<bool> editoraExiste(int editoras_id) async {
    final response =
        await http.get(Uri.parse('$baseUrl${Endpoint.listEditoras}'));
    print('Status Code: ${response.statusCode}');

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      print('Editoras: $jsonResponse');
      print('Editora ID para verificação: $editoras_id');
      return jsonResponse
          .any((editora) => editora['editoras_id'] == editoras_id);
    } else {
      throw Exception('Erro ao verificar se a editora existe.');
    }
  }

  Future<List<AutoresModel>> listAutoresIds() async {
    final response = await http.get(
      Uri.parse('$baseUrl ${Endpoint.listAutores}'),
    );
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);

      return data
          .map<AutoresModel>((autor) => AutoresModel.fromJson(autor))
          .toList();
    } else {
      throw Exception('Falha ao listar autores:');
    }
  }

  Future<List<EditorasModel>> listEditoraIds() async {
    final response = await http.get(
      Uri.parse('$baseUrl ${Endpoint.listEditoras}'),
    );
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data
          .map<EditorasModel>((editoras) => EditorasModel.fromJson(editoras))
          .toList();
    } else {
      throw Exception('Falha ao listar Editoras');
    }
  }
}
