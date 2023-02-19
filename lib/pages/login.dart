import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/appstate.dart';

///Clase con la vista del login de la app
class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController userController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AppState? state;

  @override
  Widget build(BuildContext context) {
    // Creo un state para llamar a los metodos de la base de datos
    state = Provider.of<AppState>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Login",
          style: TextStyle(
              fontSize: 25, fontFamily: 'Cabin', fontWeight: FontWeight.w600),
        ),
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
              height: 80,
            ),
            Container(
              height: 60,
              width: 270,
              decoration: BoxDecoration(
                  color: const Color(0xff007991),
                  borderRadius: BorderRadius.circular(20)),
              child: FutureBuilder(
                  future: state!.getUsers(),
                  builder:
                      (BuildContext context, AsyncSnapshot<List> snapshot) {
                    List users = snapshot.data ?? [];
                    return MaterialButton(
                      onPressed: () {
                        bool response = false;
                        if (_formKey.currentState!.validate()) {
                          for (var user in users) {
                            // Compruebo que el usuario coinciden con un usuario de la base de datos
                            if (user.user == userController.text &&
                                user.password == passwordController.text) {
                              response = true;
                            }
                          }

                          // Si esta correcto
                          if (response) {
                            Navigator.pushNamed(context, "/");
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text(
                                'Error credenciales incorrectas',
                                style: TextStyle(fontSize: 16),
                              ),
                              backgroundColor: Colors.red,
                            ));
                          }
                        }
                      },
                      child: const Text(
                        'Iniciar sesión',
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
              height: 30,
            ),
            SizedBox(
              width: 270,
              height: 60,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  side: const BorderSide(width: 1, color: Colors.black12),
                ),
                child: const Text(
                  "Registrarse",
                  style: TextStyle(
                      fontSize: 25,
                      color: Color(0xff007991),
                      fontFamily: 'FiraSans',
                      fontWeight: FontWeight.bold),
                ),
                onPressed: () => Navigator.pushNamed(context, 'register'),
              ),
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
        ],
      ),
    );
  }
}
