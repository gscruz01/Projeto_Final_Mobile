import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ola_mundo/features/editoras/data/repositories_impl/editoras_repository_impl.dart';
import 'package:ola_mundo/features/pag_inicial/presentation/theme/colors.dart';

class PostEditoras_adm extends StatefulWidget {
  const PostEditoras_adm({super.key});

  @override
  State<PostEditoras_adm> createState() => _PostEditoras_admState();
}

class _PostEditoras_admState extends State<PostEditoras_adm> {
  final TextEditingController controller_Nome = TextEditingController();
  final TextEditingController controller_Localizacao = TextEditingController();

  late EditorasRepositoryImpl useCaseEditoras;

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
          'Cadastrar Editoras',
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
                padding: EdgeInsets.only(top: 50, bottom: 30),
                child: Text(
                  'Digite o nome da editora que deseja criar.',
                  style: TextStyle(
                      fontSize: 30, color: colors_variables.primarytextcolor),
                ),
              ),
              TextField(
                controller: controller_Nome,
                keyboardType: TextInputType.text,
                maxLength: 30,
                decoration: InputDecoration(
                  hintText: 'Digite o nome da Editora',
                  filled: true,
                  fillColor: colors_variables.primarytextcolor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 10, bottom: 30),
                child: Text(
                  'Digite a localização da editora que deseja criar.',
                  style: TextStyle(
                      fontSize: 30, color: colors_variables.primarytextcolor),
                ),
              ),
              TextField(
                controller: controller_Localizacao,
                keyboardType: TextInputType.text,
                maxLength: 30,
                decoration: InputDecoration(
                  hintText: 'Digite o endereço da Editora',
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
                    useCaseEditoras
                        .postEditoras(
                            controller_Nome.text, controller_Localizacao.text)
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
                    'Criar Editora',
                    style: TextStyle(color: colors_variables.primarytextcolor),
                  ),
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
