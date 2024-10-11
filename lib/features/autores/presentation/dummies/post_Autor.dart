import 'package:flutter/material.dart';
import 'package:ola_mundo/features/autores/data/repositories_impl/autores_repository_impl.dart';
import 'package:ola_mundo/features/pag_inicial/presentation/theme/colors.dart';

class PostAutor extends StatefulWidget {
  const PostAutor({super.key});

  @override
  State<PostAutor> createState() => _PostAutorState();
}

class _PostAutorState extends State<PostAutor> {
  final TextEditingController controller_Nome = TextEditingController();
  late AutoresRepositoryImpl useCaseAutores;

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
          'Cadastrar Autores',
          style: TextStyle(color: colors_variables.primarytextcolor),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(
                context); // Volta sem criar uma nova instância da página
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
                  padding: EdgeInsets.only(top: 120, bottom: 30),
                  child: Text(
                    'Digite o nome do autor que deseja criar.',
                    style: TextStyle(
                        fontSize: 40, color: colors_variables.primarytextcolor),
                  ),
                ),
                TextField(
                  controller: controller_Nome,
                  keyboardType: TextInputType.text,
                  maxLength: 30,
                  decoration: InputDecoration(
                    hintText: 'Digite o Nome do Autor',
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
                      useCaseAutores
                          .postAutores(controller_Nome.text)
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
                      'Criar Autor',
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
