import 'package:flutter/material.dart';
import 'package:ola_mundo/features/home_adm/presentation/dummies/options_page_adm.dart';
import 'package:ola_mundo/features/livros_adm/presentation/dummies/edit_Livros_adm.dart';
import 'package:ola_mundo/features/livros_adm/presentation/dummies/post_Livros_adm.dart';
import 'package:ola_mundo/features/pag_inicial/presentation/theme/colors.dart';
import 'package:ola_mundo/features/livros/data/repositories_impl/livros_repository_impl.dart';
import 'package:ola_mundo/features/livros/domain/model/livros_model.dart';

class LivrosPage_adm extends StatefulWidget {
  const LivrosPage_adm({super.key});

  @override
  State<LivrosPage_adm> createState() => _LivrosState();
}

class _LivrosState extends State<LivrosPage_adm> {
  late Future<List<LivrosAdmModel>> listaLivros;
  late LivrosRepositoryImpl useCaseLivros;
  final LivrosRepositoryImpl livrosRepository = LivrosRepositoryImpl();

  @override
  void initState() {
    super.initState();
    useCaseLivros = LivrosRepositoryImpl();
    listaLivros = useCaseLivros.getLivros();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Livros admin',
          style: TextStyle(color: colors_variables.primarytextcolor),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const options_page_adm(),
              ),
            );
          },
        ),
        iconTheme:
            const IconThemeData(color: colors_variables.primarytextcolor),
        backgroundColor: colors_variables.secundarybackground,
      ),
      body: Container(
        color: colors_variables.primarybackground,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Lista de Livros',
                        style: TextStyle(
                          color: colors_variables.primarytextcolor,
                          fontSize: 24,
                        ),
                      ),
                      SizedBox(
                        height: 50.0,
                        child: ElevatedButton(
                          onPressed: () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const PostLivros_adm(),
                              ),
                            );
                            if (result == true) {
                              setState(() {
                                listaLivros = useCaseLivros.getLivros();
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colors_variables.iconscolor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: const Text(
                            "Cadastrar",
                            style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontSize: 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Container(
                    height: 700,
                    decoration: BoxDecoration(
                      color: colors_variables.primarytextcolor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.all(9),
                    child: FutureBuilder<List<LivrosAdmModel>>(
                      future: listaLivros,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Erro: ${snapshot.error}');
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return const Text('Nenhum Livro encontrado');
                        } else {
                          return SizedBox(
                            child: ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                final livro = snapshot.data![index];
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            left: 10,
                                            right: 10,
                                          ),
                                          child:
                                              Text(livro.livro_id.toString()),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10,
                                              right: 10,
                                              top: 2,
                                              bottom: 2),
                                          child: SizedBox(
                                            width: 70,
                                            child: Text(livro.titulo),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            left: 10,
                                            right: 10,
                                          ),
                                          child: SizedBox(
                                            width: 70,
                                            child: Text(livro.ano_publicacao),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            left: 10,
                                            right: 10,
                                          ),
                                          child: IconButton(
                                            icon: const Icon(Icons.edit),
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      editLivros_adm(
                                                          livroId:
                                                              livro.livro_id),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        Center(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                              left: 10,
                                              right: 10,
                                            ),
                                            child: IconButton(
                                              icon: const Icon(Icons.delete),
                                              onPressed: () {
                                                setState(() {
                                                  deleteLivros(livro.livro_id);
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              },
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> deleteLivros(int id) async {
    try {
      await livrosRepository.deleteLivros(id);
      setState(() {
        listaLivros = useCaseLivros.getLivros();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Livro deletado com sucesso'),
        ),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao deletar Livro: $error'),
        ),
      );
    }
  }
}
