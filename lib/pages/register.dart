import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/services.dart';

///Clase con la vista del registro de la app
class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController userController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordRepeatController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AppState? state;

  @override
  Widget build(BuildContext context) {
    state = Provider.of<AppState>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register",
            style: TextStyle(
                fontSize: 25,
                fontFamily: 'Cabin',
                fontWeight: FontWeight.w600)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                child: SizedBox(
                    width: 200,
                    height: 150,
                    child: Image.asset('assets/images/login.jpg')),
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            _credentials(),
            const SizedBox(
              height: 70,
            ),
            Container(
              height: 60,
              width: 270,
              decoration: BoxDecoration(
                  color: const Color(0xff007991),
                  borderRadius: BorderRadius.circular(20)),
              child: FutureBuilder(builder:
                  (BuildContext context, AsyncSnapshot<List> snapshot) {
                return MaterialButton(
                  onPressed: () {
                    bool response = false;
                    // Compruebo si todos los campos estan rellenos
                    if (_formKey.currentState!.validate()) {
                      // Si esta correcto cre el nuevo usuario
                      if (passwordController.text ==
                          passwordRepeatController.text) {
                        state!.saveUser(
                            userController.text, passwordController.text);
                        response = true;
                      }

                      // Si esta correcto me dirigo a la vista del login
                      if (response) {
                        Navigator.pushNamed(context, "login");
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text(
                            'Error las contraseñas no coinciden',
                            style: TextStyle(fontSize: 16),
                          ),
                          backgroundColor: Colors.red,
                        ));
                      }
                    }
                  },
                  child: const Text(
                    'Registrarse',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontFamily: 'FiraSans',
                        fontWeight: FontWeight.bold),
                  ),
                );
              }),
            ),
            const SizedBox(
              height: 130,
            ),
          ],
        ),
      ),
    );
  }

  /// Metodo con los widgets para rellenar el usuario
  Form _credentials() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: TextFormField(
              controller: userController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Usuario',
                  hintText: 'Introduce tu usuario'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Este campo es requerido';
                }
                return null;
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 15.0, right: 15.0, top: 15, bottom: 0),
            child: TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Contraseña',
                  hintText: 'Introduce la contraseña'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Este campo es requerido';
                }
                return null;
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 15.0, right: 15.0, top: 15, bottom: 0),
            child: TextFormField(
              controller: passwordRepeatController,
              obscureText: true,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Repetir contraseña',
                  hintText: 'Introduce la contraseña'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Este campo es requerido';
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }
}
