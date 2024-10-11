import 'package:flutter/material.dart';
import 'package:ola_mundo/features/funcionarios/domain/model/funcionarios_model.dart';
import 'package:ola_mundo/features/funcionarios/presentation/dummies/funcionarios_Page.dart';
import 'package:ola_mundo/features/home/presentation/dummies/options_page.dart';
import 'package:ola_mundo/features/home_adm/presentation/dummies/options_page_adm.dart';
import 'package:ola_mundo/features/pag_inicial/presentation/dummies/home_Page.dart';
import 'package:ola_mundo/features/pag_inicial/presentation/theme/colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController controller_login = TextEditingController();
  late TextEditingController controller_Senha = TextEditingController();
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
        child: Padding(
          padding: const EdgeInsets.all(35),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 115),
                child: Text(
                  'Biblioteca',
                  style: TextStyle(
                      fontSize: 55, color: colors_variables.primarytextcolor),
                ),
              ),
              TextField(
                controller: controller_login,
                keyboardType: TextInputType.text,
                maxLength: 50,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'Digite o Login',
                  filled: true,
                  fillColor: colors_variables.primarytextcolor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: TextField(
                  controller: controller_Senha,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  maxLength: 16,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: 'Digite sua senha',
                    filled: true,
                    fillColor: colors_variables.primarytextcolor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 120),
                child: SizedBox(
                  height: 60,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colors_variables.iconscolor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    onPressed: () async {
                      if (controller_login.text == 'Senha Certa' &&
                          controller_Senha.text == 'gui123') {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => const Pagina_Inicial(),
                          ),
                          (Route<dynamic> route) => false,
                        );
                      } else if (controller_login.text.isEmpty ||
                          controller_Senha.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Por favor preencha todos dados.'),
                          ),
                        );
                      } else if (controller_login.text == 'adm' &&
                          controller_Senha.text == '123') {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const options_page_adm(),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content:
                                Text('Matricula ou Senha estao incorretos.'),
                          ),
                        );
                      }
                    },
                    child: const Text(
                      'Logar',
                      style: TextStyle(
                          fontSize: 15,
                          color: colors_variables.primarytextcolor),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
