import 'dart:convert';
import 'dart:ffi';
import 'package:ola_mundo/features/editoras/domain/model/editoras_model.dart';
import 'package:http/http.dart' as http;
import 'package:ola_mundo/features/editoras/presentation/dummies/edit_Editoras.dart';
import 'package:ola_mundo/shared/endpoint.dart';

class EditorasRepositoryImpl {
  final String baseUrl = 'http://10.0.2.2:3000';
  late final Endpoint endpoint;

  Future<List<EditorasModel>> getEditoras() async {
    final response =
        await http.get(Uri.parse('$baseUrl${Endpoint.listEditoras}'));
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((item) => EditorasModel.fromJson(item)).toList();
    } else {
      throw Exception('Falha ao carregar editoras');
    }
  }

  Future<EditorasModel> postEditoras(String nome, String localizacao) async {
    final response = await http.post(
      Uri.parse('$baseUrl${Endpoint.postEditoras}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'nome': nome,
        'localizacao': localizacao,
      }),
    );
    if (response.statusCode == 201) {
      return EditorasModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Falha ao criar Editora.');
    }
  }

  Future<void> deleteEditoras(int id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl${Endpoint.deleteEditoras}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, int>{
        'editoras_id': id,
      }),
    );
    if (response.statusCode == 200) {
      print('Editora deletado com sucesso');
    } else {
      print(
          'Falha ao deletar o Editora: ${response.statusCode} ${response.body}');
      throw Exception('Falha ao deletar o Editora.');
    }
  }

  Future<EditorasModel> putEditoras(
      String id, String nome, String localizacao) async {
    final response = await http.put(
      Uri.parse('$baseUrl ${Endpoint.editEditoras}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'editoras_id': id,
        'nome': nome,
        'localizacao': localizacao
      }),
    );
    if (response.statusCode == 200) {
      return EditorasModel.fromJson(jsonDecode(response.body));
    } else {
      print('Falha ao editar a Editora: ${response.statusCode}');
      throw Exception('Falha ao editar a Editora.');
    }
  }
}
