import 'package:flutter/material.dart';
import 'package:ola_mundo/features/editoras_adm/presentation/dummies/edit_Editoras_adm.dart';
import 'package:ola_mundo/features/editoras_adm/presentation/dummies/post_Editoras_adm.dart';
import 'package:ola_mundo/features/home_adm/presentation/dummies/options_page_adm.dart';
import 'package:ola_mundo/features/pag_inicial/presentation/theme/colors.dart';
import 'package:ola_mundo/features/editoras/domain/model/editoras_model.dart';
import 'package:ola_mundo/features/editoras/data/repositories_impl/editoras_repository_impl.dart';

class EditorasPage_adm extends StatefulWidget {
  const EditorasPage_adm({super.key});

  @override
  State<EditorasPage_adm> createState() => _EditorasState();
}

class _EditorasState extends State<EditorasPage_adm> {
  late Future<List<EditorasModel>> listaEditoras;
  late EditorasRepositoryImpl useCaseEditoras;
  final TextEditingController controller_ID = TextEditingController();
  final EditorasRepositoryImpl editoraRepository = EditorasRepositoryImpl();

  @override
  void initState() {
    super.initState();
    useCaseEditoras = EditorasRepositoryImpl();
    listaEditoras = useCaseEditoras.getEditoras();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colors_variables.secundarybackground,
        title: const Text(
          'Editoras Admin',
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
                        'Lista de Editoras',
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
                                  builder: (context) =>
                                      const PostEditoras_adm()),
                            );
                            if (result == true) {
                              setState(() {
                                listaEditoras = useCaseEditoras.getEditoras();
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
                    child: FutureBuilder<List<EditorasModel>>(
                      future: listaEditoras,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Erro: ${snapshot.error}');
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return const Text('Nenhuma editora encontrada');
                        } else {
                          return SizedBox(
                            child: ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                final editoras = snapshot.data![index];
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
                                          child: Text(editoras.id.toString()),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10,
                                              right: 10,
                                              top: 2,
                                              bottom: 2),
                                          child: SizedBox(
                                            width: 70,
                                            child: Text(editoras.nome),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            left: 10,
                                            right: 10,
                                          ),
                                          child: SizedBox(
                                            width: 70,
                                            child: Text(editoras.localizacao),
                                          ),
                                        )
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
                                                      editEditoras_adm(
                                                          editorasId:
                                                              editoras.id),
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
                                                deleteEditoras(editoras.id);
                                              });
                                            },
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

  Future<void> deleteEditoras(int id) async {
    try {
      await editoraRepository.deleteEditoras(id);
      setState(() {
        listaEditoras = useCaseEditoras.getEditoras();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Editora deletada com sucesso'),
        ),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao deletar Editora: $error'),
        ),
      );
    }
  }
}
