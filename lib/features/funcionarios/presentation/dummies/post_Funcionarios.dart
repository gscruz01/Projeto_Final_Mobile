import 'package:flutter/material.dart';
import 'package:ola_mundo/features/funcionarios/data/repositories_impl/funcionarios_repository_impl.dart';
import 'package:ola_mundo/features/funcionarios/presentation/dummies/funcionarios_Page.dart';
import 'package:ola_mundo/features/pag_inicial/presentation/theme/colors.dart';

class PostFuncionarios extends StatefulWidget {
  const PostFuncionarios({super.key});

  @override
  State<PostFuncionarios> createState() => _PostFuncionariosState();
}

class _PostFuncionariosState extends State<PostFuncionarios> {
  final TextEditingController controller_nome = TextEditingController();
  final TextEditingController controller_Senha = TextEditingController();
  late FuncionariosRepositoryImpl useCaseFuncionarios;

  @override
  void initState() {
    super.initState();
    useCaseFuncionarios = FuncionariosRepositoryImpl();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colors_variables.secundarybackground,
        title: const Text(
          'Cadastrar Funcionario',
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
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 115, bottom: 20),
                  child: Text(
                    'Novo Funcionario',
                    style: TextStyle(
                        fontSize: 40, color: colors_variables.primarytextcolor),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 15),
                  child: Text(
                    'Nome',
                    style: TextStyle(
                        fontSize: 24, color: colors_variables.primarytextcolor),
                  ),
                ),
                TextField(
                  controller: controller_nome,
                  keyboardType: TextInputType.text,
                  maxLength: 30,
                  decoration: InputDecoration(
                    hintText: 'Digite o Nome do Funcionario',
                    filled: true,
                    fillColor: const Color.fromARGB(255, 255, 241, 241),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 15),
                  child: Text(
                    'Senha',
                    style: TextStyle(
                        fontSize: 24, color: colors_variables.primarytextcolor),
                  ),
                ),
                TextField(
                  controller: controller_Senha,
                  keyboardType: TextInputType.text,
                  maxLength: 30,
                  decoration: InputDecoration(
                    hintText: 'Crie uma senha para seu funcionario',
                    filled: true,
                    fillColor: const Color.fromARGB(255, 255, 241, 241),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      useCaseFuncionarios
                          .postFuncionarios(
                              controller_nome.text, controller_Senha.text)
                          .then((_) {
                        Navigator.pop(context, true);
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colors_variables.iconscolor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: const Text(
                      'Criar Funcionario',
                      style:
                          TextStyle(color: colors_variables.primarytextcolor),
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
}
