import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ola_mundo/features/funcionarios/data/repositories_impl/funcionarios_repository_impl.dart';
import 'package:ola_mundo/features/funcionarios/domain/model/funcionarios_model.dart';
import 'package:ola_mundo/features/funcionarios/presentation/dummies/funcionarios_Page.dart';
import 'package:ola_mundo/features/pag_inicial/presentation/theme/colors.dart';

class editFuncionario extends StatefulWidget {
  final int FuncionarioId;
  const editFuncionario({super.key, required int this.FuncionarioId});

  @override
  State<editFuncionario> createState() => _editFuncionarioState();
}

class _editFuncionarioState extends State<editFuncionario> {
  late FuncionariosRepositoryImpl useCaseFuncionarios;
  final TextEditingController controller_Novo_Nome = TextEditingController();

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
          'Editar Funcionarios',
          style: TextStyle(color: colors_variables.primarytextcolor),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const FuncionariosPage(),
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
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.only(top: 120, bottom: 30),
                  child: Text(
                    'Digite o novo nome do Funcionario.',
                    style: TextStyle(
                        fontSize: 40, color: colors_variables.primarytextcolor),
                  ),
                ),
                TextField(
                  controller: controller_Novo_Nome,
                  keyboardType: TextInputType.text,
                  maxLength: 30,
                  decoration: InputDecoration(
                    hintText: 'Digite o novo Nome do Funcionario',
                    filled: true,
                    fillColor: colors_variables.primarytextcolor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      await useCaseFuncionarios.putFuncionarios(
                          widget.FuncionarioId.toString(),
                          controller_Novo_Nome.text);

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FuncionariosPage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colors_variables.iconscolor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: const Text(
                      'Atualizar Funcionario',
                      style: TextStyle(
                          color: colors_variables.primarytextcolor,
                          fontSize: 17),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
