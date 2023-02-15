import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import '../services/appstate.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);
  final TextEditingController userController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AppState? state;

  @override
  Widget build(BuildContext context) {
    state = Provider.of<AppState>(context, listen: true);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Login"),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
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
                    /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                    child: Image.asset('assets/images/login.jpg')),
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            credenciales(),
            const SizedBox(
              height: 100,
            ),
            Container(
              height: 60,
              width: 270,
              decoration: BoxDecoration(
                  color: Colors.lightBlue,
                  borderRadius: BorderRadius.circular(20)),
              child: FutureBuilder(
                  future: state!.getUsers(),
                  builder:
                      (BuildContext context, AsyncSnapshot<List> snapshot) {
                    List users = snapshot.data ?? [];
                    return MaterialButton(
                      onPressed: () {
                        bool response = false;
                        // final navigator = Navigator.pushNamed(context, "/");
                        if (_formKey.currentState!.validate()) {
                          for (var user in users) {
                            print("${user.user}-----${user.password}");
                            if (user.user == userController.text &&
                                user.password ==
                                    passwordController.text) {
                              response = true;
                            }
                          }
                          if (response) {
                            Navigator.pushNamed(context, "/");
                          }
                        }
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(color: Colors.white, fontSize: 25),
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

  Column credenciales() {
    return Column(
      children: [
        Padding(
          //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
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
          //padding: EdgeInsets.symmetric(horizontal: 15),
          child: Form(
            key: _formKey,
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
        ),
      ],
    );
  }
}
