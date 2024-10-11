import 'package:flutter/material.dart';
import 'package:ola_mundo/features/pag_inicial/presentation/theme/colors.dart';
import '../../../home/presentation/dummies/options_page.dart';

class Pagina_Inicial extends StatefulWidget {
  const Pagina_Inicial({super.key});

  @override
  State<Pagina_Inicial> createState() => _Pagina_InicialState();
}

class _Pagina_InicialState extends State<Pagina_Inicial> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/livros.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Container(
            height: 450,
            decoration: BoxDecoration(
                color: const Color.fromARGB(185, 0, 0, 0),
                borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.only(bottom: 60),
                    child: Text(
                      'Bem-vindo à Biblioteca!',
                      style: TextStyle(
                          color: colors_variables.tittlecolor,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 60),
                    child: Text(
                      'Aqui você poderá realizar diversas consultas, como visualizar os autores, livros e editoras disponíveis em nosso app.',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: colors_variables.primarytextcolor),
                    ),
                  ),
                  SizedBox(
                    height: 60.0,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => const options_page()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colors_variables.iconscolor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: const Text(
                        "Avançar",
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
