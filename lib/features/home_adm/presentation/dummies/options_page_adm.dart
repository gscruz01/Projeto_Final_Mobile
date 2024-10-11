import 'package:flutter/material.dart';
import 'package:ola_mundo/features/autores_adm/presentation/dummies/autores_Page_adm.dart';
import 'package:ola_mundo/features/editoras_adm/presentation/dummies/editores_Page_adm.dart';
import 'package:ola_mundo/features/funcionarios/presentation/dummies/funcionarios_Page.dart';
import 'package:ola_mundo/features/livros_adm/presentation/dummies/livros_Page_adm.dart';
import 'package:ola_mundo/features/login/presentation/dummies/login_page.dart';
import 'package:ola_mundo/features/pag_inicial/presentation/theme/colors.dart';

class options_page_adm extends StatefulWidget {
  const options_page_adm({super.key});

  @override
  State<options_page_adm> createState() => _options_page_admState();
}

class _options_page_admState extends State<options_page_adm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Biblioteca',
          style: TextStyle(color: colors_variables.primarytextcolor),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const LoginPage(),
              ),
            );
          },
        ),
        iconTheme:
            const IconThemeData(color: colors_variables.primarytextcolor),
        backgroundColor: colors_variables.secundarybackground,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background_Pag_Opcoes1.jpg'),
            colorFilter: ColorFilter.mode(
                colors_variables.ocupacyBackground, BlendMode.luminosity),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.only(left: 20, top: 120),
                  child: Text(
                    'Bem-vindo, Administrador!',
                    style: TextStyle(
                        fontSize: 40, color: colors_variables.primarytextcolor),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: SizedBox(
                    height: 80.0,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => const FuncionariosPage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colors_variables.iconscolor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: const Text(
                        "Funcionarios",
                        style: TextStyle(
                            color: colors_variables.primarytextcolor,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: SizedBox(
                    height: 80.0,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => const AutoresPage_adm()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colors_variables.iconscolor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: const Text(
                        "Autores",
                        style: TextStyle(
                            color: colors_variables.primarytextcolor,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: SizedBox(
                    height: 80.0,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => const EditorasPage_adm()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colors_variables.iconscolor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: const Text(
                        "Editoras",
                        style: TextStyle(
                            color: colors_variables.primarytextcolor,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: SizedBox(
                    height: 80.0,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => const LivrosPage_adm()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colors_variables.iconscolor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: const Text(
                        "Livros",
                        style: TextStyle(
                            color: colors_variables.primarytextcolor,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
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
