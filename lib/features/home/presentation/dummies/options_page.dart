import 'package:flutter/material.dart';
import 'package:ola_mundo/features/autores/presentation/dummies/autores_Page.dart';
import 'package:ola_mundo/features/editoras/presentation/dummies/editores_Page.dart';
import 'package:ola_mundo/features/livros/presentation/dummies/livros_Page.dart';
import 'package:ola_mundo/features/login/presentation/dummies/login_page.dart';
import 'package:ola_mundo/features/pag_inicial/presentation/theme/colors.dart';

class options_page extends StatefulWidget {
  const options_page({super.key});

  @override
  State<options_page> createState() => _options_pageState();
}

class _options_pageState extends State<options_page> {
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
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.only(left: 20, top: 160),
                  child: Text(
                    'Modulos',
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
                              builder: (context) => const AutoresPage()),
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
                              builder: (context) => const EditorasPage()),
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
                              builder: (context) => const LivrosPage()),
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
