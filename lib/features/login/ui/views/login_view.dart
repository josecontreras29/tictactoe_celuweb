import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tictactoe_celuweb/features/home/ui/views/home_view.dart';
import 'package:tictactoe_celuweb/features/login/ui/bloc/imports_login_bloc.dart';

import '../../../-config/constants/images.dart';
import '../../../home/ui/bloc/imports_home_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Container(
                decoration: BoxDecoration(color: Colors.grey[300]!),
                child: BlocConsumer<LoginBloc, LoginState>(
                  builder: (context, state) {
                    if (state is LoginInitialState) {
                      return const LoginView();
                    } else if (state is LoginLoadingState) {
                      return const Center(
                          child: CircularProgressIndicator(
                              color: Colors.black, strokeWidth: 6));
                    } else if (state is LoginLoggedState) {
                      context.read<HomeBloc>().add(
                          HomeInitialDataEvent(dataUsuario: state.dataUsuario));
                      return HomeView();
                    } else {
                      return const LoginView();
                    }
                  },
                  listener: (context, state) {},
                ))));
  }
}

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final controllerNombre = TextEditingController();
  final controllerCodigo = TextEditingController();
  final _formField = GlobalKey<FormState>();
  late LoginBloc loginBloc;

  @override
  void dispose() {
    controllerNombre.dispose();
    controllerCodigo.dispose();
    super.dispose();
  }

  @override
  void initState() {
    loginBloc = context.read<LoginBloc>();
    loginBloc.add(LoginInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formField,
      child: Center(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 400),
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                      width: 150,
                      child: Image.asset(ImagesLogin.iconLogin,
                          fit: BoxFit.cover)),
                  Container(
                      margin: const EdgeInsets.only(top: 60),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        style: const TextStyle(fontSize: 14),
                        controller: controllerCodigo,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[200]!,
                            labelText: "Codigo"),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Por favor ingresa un codigo (números)";
                          }
                          return null;
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(10),
                        ],
                      )),
                  Container(
                      margin: const EdgeInsets.only(top: 30),
                      child: TextFormField(
                        keyboardType: TextInputType.name,
                        style: const TextStyle(fontSize: 14),
                        controller: controllerNombre,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[200]!,
                            labelText: "Nombre"),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Por favor ingresa un nombre";
                          }
                          return null;
                        },
                      )),
                  Container(
                      constraints: const BoxConstraints(minWidth: 200),
                      margin: const EdgeInsets.only(top: 30),
                      child: ElevatedButton(
                          onPressed: () {
                            if (_formField.currentState!.validate()) {
                              loginBloc.add(LoginSignInEvent(
                                  codigo: int.parse(controllerCodigo.text),
                                  nombre: controllerNombre.text));
                            }
                          },
                          child: const Text("Jugar")))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
