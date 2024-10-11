import 'dart:convert';
import 'package:flutter/src/widgets/editable_text.dart';
import 'package:http/http.dart' as http;
import 'package:ola_mundo/features/funcionarios/data/repositories_impl/funcionarios_repository_impl.dart';
import 'package:ola_mundo/features/funcionarios/domain/model/funcionarios_model.dart';
import 'package:ola_mundo/shared/endpoint.dart';

class FuncionariosRepositoryImpl {
  final String baseUrl = 'http://10.0.2.2:3000';
  late final Endpoint endpoint;

  Future<List<FuncionariosModel>> getFuncionarios() async {
    final response =
        await http.get(Uri.parse('$baseUrl${Endpoint.listFuncionarios}'));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((item) => FuncionariosModel.fromJson(item))
          .toList();
    } else {
      throw Exception('Falha ao carregar os(as) Funcionarios(a)');
    }
  }

  Future<FuncionariosModel> postFuncionarios(String nome, String senha) async {
    final response = await http.post(
      Uri.parse('$baseUrl${Endpoint.postFuncionarios}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'nome': nome,
        'senha': senha,
      }),
    );
    if (response.statusCode == 201) {
      return FuncionariosModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Falha ao criar o(a) Funcionarios(a).');
    }
  }

  Future<void> deleteFuncionarios(int id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl${Endpoint.deleteFuncionarios}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, int>{
        'matricula': id,
      }),
    );
    if (response.statusCode == 200) {
      print('Funcionario(a) deletado(a) com sucesso');
    } else {
      throw Exception(
          'Falha ao deletar o(a) Funcionario(a): ${response.statusCode} ${response.body}');
    }
  }

  Future<FuncionariosModel> putFuncionarios(String id, String nome) async {
    final response = await http.put(
      Uri.parse('$baseUrl${Endpoint.editFuncionarios}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'matricula': id,
        'nome': nome,
      }),
    );
    if (response.statusCode == 200) {
      return FuncionariosModel.fromJson(
        jsonDecode(response.body),
      );
    } else {
      print('Falha ao editar o()a Funcinario(a): ${response.statusCode}');
      throw Exception('Falha ao editar o(a) FUncioanria(a).');
    }
  }
}
