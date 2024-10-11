import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ola_mundo/features/autores_adm/domain/model/autores_adm_model.dart';
import 'package:ola_mundo/shared/endpoint.dart';

class AutoresAdmRepositoryImpl {
  final String baseUrl = 'http://10.0.2.2:3000';
  late final Endpoint endpoint;

  Future<List<AutoresAdmModel>> getAutores() async {
    final response =
        await http.get(Uri.parse('$baseUrl${Endpoint.listAutores}'));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((item) => AutoresAdmModel.fromJson(item))
          .toList();
    } else {
      throw Exception('Falha ao carregar autores');
    }
  }

  Future<AutoresAdmModel> postAutores(String nome) async {
    final response = await http.post(
      Uri.parse('$baseUrl${Endpoint.postAutores}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'nome': nome,
      }),
    );
    if (response.statusCode == 201) {
      return AutoresAdmModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Falha ao criar autor.');
    }
  }

  Future<void> deleteAutor(int id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl${Endpoint.deleteAutores}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, int>{
        'autor_id': id,
      }),
    );
    if (response.statusCode == 200) {
      print('Autor deletado com sucesso');
    } else {
      print(
          'Falha ao deletar o autor: ${response.statusCode} ${response.body}');
      throw Exception('Falha ao deletar o autor.');
    }
  }

  Future<AutoresAdmModel> putAutores(String id, String nome) async {
    final response = await http.put(
      Uri.parse('$baseUrl${Endpoint.editAutores}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'autor_id': id,
        'nome': nome,
      }),
    );
    if (response.statusCode == 200) {
      return AutoresAdmModel.fromJson(
        jsonDecode(response.body),
      );
    } else {
      print('Falha ao editar o autor: ${response.statusCode}');
      throw Exception('Falha ao editar o autor.');
    }
  }
}
