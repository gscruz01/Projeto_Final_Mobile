import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:ola_mundo/features/autores_adm/domain/model/autores_adm_model.dart';
import 'package:ola_mundo/features/autores_adm/presentation/dummies/edit_Autores_adm.dart';
import 'package:ola_mundo/features/autores_adm/presentation/dummies/post_Autor_adm.dart';
import 'package:ola_mundo/features/home_adm/presentation/dummies/options_page_adm.dart';
import 'package:ola_mundo/features/pag_inicial/presentation/theme/colors.dart';
import 'package:ola_mundo/features/autores_adm/data/repositories_impl/autores_adm_repository_impl.dart';

class AutoresPage_adm extends StatefulWidget {
  const AutoresPage_adm({super.key});

  @override
  State<AutoresPage_adm> createState() => _AutoresState();
}

class _AutoresState extends State<AutoresPage_adm> {
  late Future<List<AutoresAdmModel>> listaAutores;
  late AutoresAdmRepositoryImpl useCaseAutores = AutoresAdmRepositoryImpl();
  final TextEditingController controller_ID = TextEditingController();
  final AutoresAdmRepositoryImpl autoresRepository = AutoresAdmRepositoryImpl();

  @override
  void initState() {
    super.initState();
    listaAutores = useCaseAutores.getAutores();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colors_variables.secundarybackground,
        title: const Text(
          'Autores Admin',
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
      ),
      body: Container(
        color: const Color.fromARGB(255, 65, 46, 41),
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
                        'Lista de Autores',
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
                                builder: (context) => const PostAutor(),
                              ),
                            );
                            if (result == true) {
                              setState(() {
                                listaAutores = useCaseAutores.getAutores();
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
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: colors_variables.primarytextcolor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: FutureBuilder<List<AutoresAdmModel>>(
                      future: listaAutores,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Erro: ${snapshot.error}');
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return const Text('Nenhum autor encontrado');
                        } else {
                          return SizedBox(
                            child: ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                final autor = snapshot.data![index];
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                          top: 2,
                                          bottom: 2),
                                      child: Text(autor.id.toString()),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 10,
                                        right: 10,
                                      ),
                                      child: SizedBox(
                                        width: 70,
                                        child: Text(autor.nome),
                                      ),
                                    ),
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
                                              builder: (context) => editAutores(
                                                  autorId: autor.id),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 10,
                                        right: 10,
                                      ),
                                      child: IconButton(
                                        icon: const Icon(Icons.delete),
                                        onPressed: () {
                                          setState(() {
                                            deleteAutor(autor.id);
                                          });
                                        },
                                      ),
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

  Future<void> deleteAutor(int id) async {
    try {
      await autoresRepository.deleteAutor(id);
      setState(() {
        listaAutores = useCaseAutores.getAutores();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Autor deletado com sucesso')),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao deletar autor: $error')),
      );
    }
  }
}
