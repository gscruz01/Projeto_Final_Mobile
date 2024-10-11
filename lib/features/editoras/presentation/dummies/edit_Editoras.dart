import 'package:flutter/material.dart';
import 'package:ola_mundo/features/editoras/data/repositories_impl/editoras_repository_impl.dart';
import 'package:ola_mundo/features/editoras/domain/model/editoras_model.dart';
import 'package:ola_mundo/features/editoras/presentation/dummies/editores_Page.dart';
import 'package:ola_mundo/features/pag_inicial/presentation/theme/colors.dart';

class editEditoras extends StatefulWidget {
  final int editorasId;
  const editEditoras({super.key, required int this.editorasId});

  @override
  State<editEditoras> createState() => _editEditorasState();
}

class _editEditorasState extends State<editEditoras> {
  late EditorasRepositoryImpl useCaseEditoras;
  final TextEditingController controller_Novo_Nome = TextEditingController();
  final TextEditingController controller_Localizacao = TextEditingController();

  @override
  void initState() {
    super.initState();
    useCaseEditoras = EditorasRepositoryImpl();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colors_variables.secundarybackground,
        title: const Text(
          'Editar Editoras',
          style: TextStyle(color: colors_variables.primarytextcolor),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const EditorasPage(),
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
                  padding: EdgeInsets.only(top: 10, bottom: 30),
                  child: Text(
                    'Digite o novo nome da editora.',
                    style: TextStyle(
                        fontSize: 40, color: colors_variables.primarytextcolor),
                  ),
                ),
                TextField(
                  controller: controller_Novo_Nome,
                  keyboardType: TextInputType.text,
                  maxLength: 30,
                  decoration: InputDecoration(
                    hintText: 'Digite o novo Nome da editora.',
                    filled: true,
                    fillColor: colors_variables.primarytextcolor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const Text(
                  'Digite o novo endereco da editora.',
                  style: TextStyle(
                      fontSize: 40, color: colors_variables.primarytextcolor),
                ),
                TextField(
                  controller: controller_Localizacao,
                  keyboardType: TextInputType.text,
                  maxLength: 30,
                  decoration: InputDecoration(
                    hintText: 'Digite o novo endereco da editora.',
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
                      await useCaseEditoras.putEditoras(
                          widget.editorasId.toString(),
                          controller_Novo_Nome.text,
                          controller_Localizacao.text);

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EditorasPage(),
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
                      'Atualizar editora',
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
