import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tictactoe_celuweb/features/home/ui/reusable_widgets.dart/ok_button_dialog.dart';

import '../../../login/domain/entities/data_usuario.dart';
import '../bloc/imports_home_bloc.dart';
import '../reusable_widgets.dart/background_login.dart';
import '../reusable_widgets.dart/celda_matriz_juego.dart';
import 'tablero.dart';

enum Players { player, cpu }

class HomeView extends StatefulWidget {
  const HomeView({super.key, required this.dataUsuario});

  final DataUsuario dataUsuario;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<CeldaMatriz> listaCeldas = [];
  int counter = 0;
  late HomeBloc homeBloc = context.read<HomeBloc>();

  bool _validateFreeCells() {
    for (var element in listaCeldas) {
      if (element.valueCell == "") {
        return true;
      }
    }
    return false;
  }

  _resetGame() {
    for (var element in listaCeldas) {
      element.valueCell = "";
      element.update();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[300]!,
        body: Center(
          child: SingleChildScrollView(
            child: Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 600),
                child: Column(
                  children: [
                    BlocConsumer<HomeBloc, HomeState>(
                      builder: (context, state) {
                        if (state is UpdatedTablero) {
                          return Tablero(
                              dataUsuario: widget.dataUsuario,
                              player: state.player,
                              partidasJugadas: state.partidasJugadas);
                        } else {
                          return Tablero(
                              dataUsuario: widget.dataUsuario,
                              player: Players.player,
                              partidasJugadas: 0);
                        }
                      },
                      listener: (context, state) {},
                    ),
                    BackgroundLogin(
                      child: SizedBox(
                        width: 300,
                        height: 300,
                        child: GridView.count(
                          crossAxisCount: 3,
                          children: List.generate(9, (index) {
                            listaCeldas.add(CeldaMatriz(
                              update: () {},
                              valueCell: "",
                              action: () async {
                                listaCeldas[index].valueCell =
                                    counter.isEven ? "X" : "O";
                                bool stillPlaying = _validateFreeCells();
                                homeBloc.add(UpdateDataTablero(
                                    player: counter.isEven
                                        ? Players.cpu
                                        : Players.player,
                                    partidasJugadas: stillPlaying
                                        ? widget.dataUsuario.partidasJugadas
                                        : widget.dataUsuario.partidasJugadas +
                                            1));

                                counter++;
                                !stillPlaying
                                    ? await okButton(context,
                                        "Bien jugado, intenta otra vez")
                                    : null;
                                !stillPlaying ? _resetGame() : null;
                              },
                            ));
                            return listaCeldas[index];
                          }),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
