import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ola_mundo/features/livros/data/repositories_impl/livros_repository_impl.dart';
import 'package:ola_mundo/features/livros/domain/model/livros_model.dart';
import 'package:ola_mundo/features/livros/presentation/dummies/livros_Page.dart';
import 'package:ola_mundo/features/pag_inicial/presentation/theme/colors.dart';

class editLivros extends StatefulWidget {
  final int livroId;
  const editLivros({super.key, required int this.livroId});

  @override
  State<editLivros> createState() => _editLivrosState();
}

class _editLivrosState extends State<editLivros> {
  late LivrosRepositoryImpl useCaseLivros;
  final TextEditingController controller_Novo_Titulo = TextEditingController();

  @override
  void initState() {
    super.initState();
    useCaseLivros = LivrosRepositoryImpl();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colors_variables.secundarybackground,
        title: const Text(
          'Editar Livros',
          style: TextStyle(color: colors_variables.primarytextcolor),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const LivrosPage(),
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
                    'Digite o novo titulo do livro.',
                    style: TextStyle(
                        fontSize: 40, color: colors_variables.primarytextcolor),
                  ),
                ),
                TextField(
                  controller: controller_Novo_Titulo,
                  keyboardType: TextInputType.text,
                  maxLength: 30,
                  decoration: InputDecoration(
                    hintText: 'Digite o novo titulo do livro',
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
                      await useCaseLivros.putLivros(widget.livroId.toString(),
                          controller_Novo_Titulo.text);

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LivrosPage(),
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
                      'Atualizar Livro',
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
