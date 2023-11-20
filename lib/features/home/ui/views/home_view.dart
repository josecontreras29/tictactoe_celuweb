import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../login/domain/entities/data_usuario.dart';
import '../../../login/ui/bloc/imports_login_bloc.dart';
import '../../../login/ui/views/login_view.dart';
import '../bloc/imports_home_bloc.dart';
import '../reusable_widgets.dart/background_login.dart';
import '../reusable_widgets.dart/celda_matriz_juego.dart';
import '../reusable_widgets.dart/ok_button_dialog.dart';
import 'tablero.dart';

enum Player { player, cpu, none }

class HomeView extends StatelessWidget {
  HomeView({super.key});

  List<CeldaMatriz> listaCeldas = [];
  int counterTurn = 0;
  Player turn = Player.player;
  late DataUsuario dataUsuario;

  void _resetGame() {
    for (var celda in listaCeldas) {
      celda.actualValue = Player.none;
      celda.color = Colors.transparent;
      celda.enabled = true;
      celda.update();
    }
  }

  void _changeColorWinnerCells(List<int> winnerCells) {
    for (var celda in listaCeldas) {
      if (winnerCells.contains(listaCeldas.indexOf(celda))) {
        celda.color = Colors.green;
        celda.update();
      }
      celda.enabled = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    HomeBloc homeBloc = context.read<HomeBloc>();
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
                      buildWhen: (previous, current) {
                        return current is! HomeGameCompletedState &&
                            current is! HomeUpdateDataUsuarioState;
                      },
                      listener: (context, state) {},
                      builder: (context, state) {
                        if (state is HomeInitialDataState) {
                          dataUsuario = state.dataUsuario;

                          return Tablero(
                              dataUsuario: state.dataUsuario, turn: turn);
                        } else if (state is HomeUpdatedTableroState) {
                          dataUsuario = state.dataUsuario;
                          return Tablero(
                              dataUsuario: state.dataUsuario, turn: turn);
                        } else if (state is HomeChangeTurnState) {
                          turn = state.player;
                          return Tablero(
                              dataUsuario: dataUsuario, turn: state.player);
                        } else {
                          return const SizedBox();
                        }
                      },
                    ),
                    BlocConsumer<HomeBloc, HomeState>(
                      buildWhen: (previous, current) {
                        return current is HomeGameCompletedState;
                      },
                      listener: (context, state) async {
                        if (state is HomeGameCompletedState) {
                          _changeColorWinnerCells(state.listWinnersIndex);
                          homeBloc.add(HomeUpdateDataUsuarioEvent(
                              winner: state.winner,
                              actualDataUsuario: dataUsuario));
                          homeBloc.add(HomeUpdateDataTableroEvent(
                              codigo: dataUsuario.codigo));
                          okButton(context,
                              "Good game, ${state.winner == Player.player ? 'You' : 'CPU'} win");
                        }
                      },
                      builder: (context, state) {
                        return BackgroundLogin(
                          child: SizedBox(
                            width: 300,
                            height: 300,
                            child: GridView.count(
                              crossAxisCount: 3,
                              children: List.generate(9, (index) {
                                listaCeldas.add(CeldaMatriz(
                                  update: () {},
                                  enabled: true,
                                  color: Colors.transparent,
                                  actualValue: Player.none,
                                  action: () async {
                                    listaCeldas[index].actualValue = turn;
                                    turn = turn == Player.player
                                        ? Player.cpu
                                        : Player.player;

                                    homeBloc.add(HomeCheckGameIsCompletedEvent(
                                        listaCeldas: listaCeldas));
                                    homeBloc
                                        .add(HomeChangeTurnEvent(player: turn));
                                  },
                                ));
                                return listaCeldas[index];
                              }),
                            ),
                          ),
                        );
                      },
                    ),
                    ElevatedButton(
                        onPressed: () => _resetGame(),
                        child: const Text("Play again")),
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
