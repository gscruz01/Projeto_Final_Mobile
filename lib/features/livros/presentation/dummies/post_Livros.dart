import 'package:flutter/material.dart';
import 'package:ola_mundo/features/autores/domain/model/autores_model.dart';
import 'package:ola_mundo/features/editoras/domain/model/editoras_model.dart';
import 'package:ola_mundo/features/livros/data/repositories_impl/livros_repository_impl.dart';
import 'package:ola_mundo/features/livros/presentation/dummies/livros_Page.dart';
import 'package:ola_mundo/features/pag_inicial/presentation/theme/colors.dart';

class PostLivros extends StatefulWidget {
  const PostLivros({super.key});

  @override
  State<PostLivros> createState() => _PostLivrosState();
}

class _PostLivrosState extends State<PostLivros> {
  late Future<List<AutoresModel>> autoresIds;
  late Future<List<EditorasModel>> editorasIds;
  final TextEditingController controller_Titulo = TextEditingController();
  final TextEditingController controller_ano_publicacao =
      TextEditingController();
  late LivrosRepositoryImpl useCaseLivros;
  int? selectedAutor_Id;
  int? selectedEditora_Id;

  Future<List<AutoresModel>> getAutoresIds() async {
    return await useCaseLivros.listAutoresIds();
  }

  Future<List<EditorasModel>> getEditorasIds() async {
    return await useCaseLivros.listEditoraIds();
  }

  @override
  void initState() {
    super.initState();
    useCaseLivros = LivrosRepositoryImpl();
    autoresIds = getAutoresIds();
    editorasIds = getEditorasIds();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colors_variables.secundarybackground,
        title: const Text(
          'Cadastrar Livro',
          style: TextStyle(color: colors_variables.primarytextcolor),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(
                context); // Volta para a página anterior sem recriar a lista
          },
        ),
        iconTheme:
            const IconThemeData(color: colors_variables.primarytextcolor),
      ),
      body: Container(
        color: colors_variables.primarybackground,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 5, bottom: 15),
                child: Text(
                  'Titulo',
                  style: TextStyle(
                      fontSize: 24, color: colors_variables.primarytextcolor),
                  textAlign: TextAlign.left,
                ),
              ),
              TextField(
                controller: controller_Titulo,
                keyboardType: TextInputType.text,
                maxLength: 30,
                decoration: InputDecoration(
                  hintText: 'Digite o Titulo do Livro',
                  filled: true,
                  fillColor: colors_variables.primarytextcolor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 10, bottom: 15),
                child: Text(
                  'Ano de lançamento',
                  style: TextStyle(
                      fontSize: 24, color: colors_variables.primarytextcolor),
                ),
              ),
              TextField(
                controller: controller_ano_publicacao,
                keyboardType: TextInputType.number,
                maxLength: 4,
                decoration: InputDecoration(
                  hintText: 'Digite o Ano de Lançamento do Livro',
                  filled: true,
                  fillColor: colors_variables.primarytextcolor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Column(
                  children: [
                    const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Text(
                            'Editoras',
                            style: TextStyle(
                                color: colors_variables.primarytextcolor,
                                fontSize: 24),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 10, left: 150),
                          child: Text(
                            'Autores',
                            style: TextStyle(
                                color: colors_variables.primarytextcolor,
                                fontSize: 24),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        FutureBuilder<List<EditorasModel>>(
                          future: editorasIds,
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Text(
                                  'Erro ao carregar editoras: ${snapshot.error}');
                            } else if (snapshot.hasData) {
                              return Container(
                                  padding: const EdgeInsets.only(left: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      width: 2,
                                      color: Colors.white,
                                    ),
                                  ),
                                  child: DropdownButton<int>(
                                    value: selectedEditora_Id,
                                    hint: const Text(
                                      'Selecione uma Editora',
                                      style: TextStyle(
                                          color: Color.fromARGB(255, 0, 0, 0)),
                                    ),
                                    style: const TextStyle(
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        fontSize: 15),
                                    onChanged: (int? newValue) {
                                      setState(() {
                                        selectedEditora_Id = newValue;
                                      });
                                    },
                                    items: snapshot.data!
                                        .map<DropdownMenuItem<int>>(
                                            (EditorasModel editora) {
                                      return DropdownMenuItem<int>(
                                        value: editora.id,
                                        child: Text(editora.nome),
                                      );
                                    }).toList(),
                                  ));
                            } else {
                              return const CircularProgressIndicator();
                            }
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 45),
                          child: FutureBuilder<List<AutoresModel>>(
                            future: autoresIds,
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return Text(
                                    'Erro ao carregar autores: ${snapshot.error}');
                              } else if (snapshot.hasData) {
                                return Container(
                                    padding: const EdgeInsets.only(left: 10),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        width: 2,
                                        color: Colors.white,
                                      ),
                                    ),
                                    child: DropdownButton<int>(
                                      value: selectedAutor_Id,
                                      hint: const Text(
                                        'Selecione um Autor',
                                        style: TextStyle(
                                            color: Color.fromARGB(255, 0, 0, 0),
                                            fontSize: 15),
                                      ),
                                      style:
                                          const TextStyle(color: Colors.black),
                                      onChanged: (int? newValue) {
                                        setState(() {
                                          selectedAutor_Id = newValue;
                                        });
                                      },
                                      items: snapshot.data!
                                          .map<DropdownMenuItem<int>>(
                                              (AutoresModel autor) {
                                        return DropdownMenuItem<int>(
                                          value: autor.id,
                                          child: Text(autor.nome),
                                        );
                                      }).toList(),
                                    ));
                              } else {
                                return const CircularProgressIndicator();
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colors_variables.iconscolor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onPressed: () async {
                    if (controller_Titulo.text.isEmpty ||
                        controller_ano_publicacao.text.isEmpty ||
                        selectedAutor_Id == null ||
                        selectedEditora_Id == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Por favor preencha todos dados.'),
                        ),
                      );
                    } else {
                      try {
                        await useCaseLivros.postLivros(
                          controller_Titulo.text,
                          controller_ano_publicacao.text,
                          selectedAutor_Id!,
                          selectedEditora_Id!,
                        );
                        Navigator.pop(context, true);
                      } catch (error) {
                        print('Erro: $error');
                      }
                    }
                  },
                  child: const Text(
                    'Cadastrar',
                    style: TextStyle(
                        fontSize: 15, color: colors_variables.primarytextcolor),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
