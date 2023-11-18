import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tictactoe_celuweb/features/home/ui/bloc/imports_home_bloc.dart';
import 'package:tictactoe_celuweb/features/login/ui/bloc/imports_login_bloc.dart';

import 'features/-config/themes/app_themes.dart';
import 'features/login/ui/views/login_view.dart';
import 'injection_container.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() async {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  await initDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
            create: (context) => sl()..add(InitialEventLogin())),
        BlocProvider<HomeBloc>(
            create: (context) => sl()..add(InitialEventHome())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'TicTacToe Demo',
        theme: theme(),
        home: const LoginPage(),
      ),
    );
  }
}