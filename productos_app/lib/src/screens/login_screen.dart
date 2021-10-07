import 'package:flutter/material.dart';
import 'package:productos_app/src/providers/login_form_provider.dart';
import 'package:productos_app/src/services/services.dart';
import 'package:productos_app/src/ui/input_decorations.dart';
import 'package:productos_app/src/widgets/widgets.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
          child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 200),
            CardContainer(
              child: Column(
                children: [
                  Text("Login", style: Theme.of(context).textTheme.headline4),
                  SizedBox(height: 30),
                  ChangeNotifierProvider(
                      create: (_) => LoginFormProvider(), child: _LoginForm())
                ],
              ),
            ),
            SizedBox(height: 30),
            TextButton(
              style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(Colors.black),
                  overlayColor: MaterialStateProperty.all(Colors.indigo[200])),
              onPressed: () =>
                  Navigator.pushReplacementNamed(context, "register"),
              child: Text(
                "Crear nueva cuenta",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      )),
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);

    return Container(
      child: Form(
        key: loginForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) => loginForm.mail = value,
              decoration: InputDecorations.authInputDecoration(
                hintText: "john@example.com",
                labelText: "Correo electronico",
                prefixIcon: Icons.alternate_email_outlined,
              ),
              validator: (value) {
                String pattern =
                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regExp = new RegExp(pattern);

                return regExp.hasMatch(value ?? '')
                    ? null
                    : 'El valor ingresado no es un correo';
              },
            ),
            SizedBox(height: 30),
            TextFormField(
              autocorrect: false,
              obscureText: true,
              onChanged: (value) => loginForm.password = value,
              decoration: InputDecorations.authInputDecoration(
                hintText: "********",
                labelText: "Password",
                prefixIcon: Icons.lock_outline,
              ),
              validator: (value) {
                if (value != null && value.length >= 6) return null;
                return 'La contraseña debe de ser de 6 caracteres.';
              },
            ),
            SizedBox(height: 30),
            MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 10,
                color: Colors.deepPurple,
                disabledColor: Colors.grey,
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    child: Text(
                      loginForm.isLoading ? 'Espere' : "Ingresar",
                      style: TextStyle(color: Colors.white),
                    )),
                onPressed: loginForm.isLoading
                    ? null
                    : () async {
                        FocusScope.of(context).unfocus();

                        final authService =
                            Provider.of<AuthService>(context, listen: false);

                        if (!loginForm.isValidForm()) {
                          NotificationsService.showSnackBar(
                              "Email y/o contraseña no validos");
                          return;
                        }
                        loginForm.isLoading = true;

                        final String? errorMessage = await authService
                            .loginUser(loginForm.mail, loginForm.password);

                        loginForm.isLoading = false;

                        if (errorMessage != null) {
                          NotificationsService.showSnackBar(
                              "Email y/o contraseña incorrectos");
                          return;
                        }
                        Navigator.pushNamed(context, 'home');
                      })
          ],
        ),
      ),
    );
  }
}
