import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:ola_mundo/features/funcionarios/data/repositories_impl/funcionarios_repository_impl.dart';
import 'package:ola_mundo/features/funcionarios/domain/model/funcionarios_model.dart';
import 'package:ola_mundo/features/funcionarios/presentation/dummies/edit_Funcionarios.dart';
import 'package:ola_mundo/features/funcionarios/presentation/dummies/post_Funcionarios.dart';
import 'package:ola_mundo/features/home_adm/presentation/dummies/options_page_adm.dart';
import 'package:ola_mundo/features/pag_inicial/presentation/theme/colors.dart';

class FuncionariosPage extends StatefulWidget {
  const FuncionariosPage({super.key});

  @override
  State<FuncionariosPage> createState() => _FuncionariosState();
}

class _FuncionariosState extends State<FuncionariosPage> {
  late Future<List<FuncionariosModel>> listaFuncionarios;
  late FuncionariosRepositoryImpl useCaseFuncionarios =
      FuncionariosRepositoryImpl();
  final TextEditingController controller_matricula = TextEditingController();
  final FuncionariosRepositoryImpl funcionariosRepository =
      FuncionariosRepositoryImpl();

  @override
  void initState() {
    super.initState();
    listaFuncionarios = useCaseFuncionarios.getFuncionarios();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colors_variables.secundarybackground,
        title: const Text(
          'Funcionarios',
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
                        'Lista de Funcionarios',
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
                                builder: (context) => const PostFuncionarios(),
                              ),
                            );
                            if (result == true) {
                              setState(() {
                                listaFuncionarios =
                                    useCaseFuncionarios.getFuncionarios();
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
                    child: FutureBuilder<List<FuncionariosModel>>(
                      future: listaFuncionarios,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Erro: ${snapshot.error}');
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return const Text(
                              'Nenhum funcionario ou funcionaria encontrado(a)');
                        } else {
                          return SizedBox(
                            child: ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                final funcionario = snapshot.data![index];
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
                                      child: Text(funcionario.id.toString()),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 10,
                                        right: 10,
                                      ),
                                      child: SizedBox(
                                        width: 70,
                                        child: Text(funcionario.nome),
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
                                              builder: (context) =>
                                                  editFuncionario(
                                                      FuncionarioId:
                                                          funcionario.id),
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
                                            deleteFuncionario(funcionario.id);
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

  Future<void> deleteFuncionario(int id) async {
    try {
      await funcionariosRepository.deleteFuncionarios(id);
      setState(() {
        listaFuncionarios = useCaseFuncionarios.getFuncionarios();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Funcionario deletado com sucesso')),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao deletar funcionario: $error')),
      );
    }
  }
}
