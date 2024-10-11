import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ola_mundo/features/autores/data/repositories_impl/autores_repository_impl.dart';
import 'package:ola_mundo/features/autores/domain/model/autores_model.dart';
import 'package:ola_mundo/features/autores/presentation/dummies/autores_Page.dart';
import 'package:ola_mundo/features/pag_inicial/presentation/theme/colors.dart';

class editAutores extends StatefulWidget {
  final int autorId;
  const editAutores({super.key, required int this.autorId});

  @override
  State<editAutores> createState() => _editAutoresState();
}

class _editAutoresState extends State<editAutores> {
  late AutoresRepositoryImpl useCaseAutores;
  final TextEditingController controller_Novo_Nome = TextEditingController();

  @override
  void initState() {
    super.initState();
    useCaseAutores = AutoresRepositoryImpl();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colors_variables.secundarybackground,
        title: const Text(
          'Editar Autores',
          style: TextStyle(color: colors_variables.primarytextcolor),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const AutoresPage(),
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
          padding: EdgeInsets.all(20),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.only(top: 120, bottom: 30),
                  child: Text(
                    'Digite o novo nome do autor.',
                    style: TextStyle(
                        fontSize: 40, color: colors_variables.primarytextcolor),
                  ),
                ),
                TextField(
                  controller: controller_Novo_Nome,
                  keyboardType: TextInputType.text,
                  maxLength: 30,
                  decoration: InputDecoration(
                    hintText: 'Digite o novo Nome do Autor',
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
                    onPressed: () {
                      useCaseAutores.putAutores(
                          widget.autorId.toString(), controller_Novo_Nome.text);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AutoresPage(),
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
                      'Atualizar Autor',
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
