import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../-config/constants/images.dart';
import '../../../login/domain/entities/data_usuario.dart';
import '../bloc/imports_home_bloc.dart';
import '../reusable_widgets.dart/background_login.dart';
import '../reusable_widgets.dart/celda_matriz_juego.dart';
import '../reusable_widgets.dart/ok_button_dialog.dart';
import 'tablero.dart';

enum Player { player, cpu, none }

// ignore: must_be_immutable
class HomeView extends StatelessWidget {
  HomeView({super.key});
  List<CeldaMatriz> listaCeldas = [];
  Player actualTurn = Player.player;
  late DataUsuario dataUsuario;

  void _changeColorWinnerCells(
      List<int> winnerCells ) {
    for (CeldaMatriz celda in listaCeldas) {
      if (winnerCells.contains(listaCeldas.indexOf(celda))) {
        celda.color = Colors.green;
        celda.update();
      } else {
        celda.enabled = false;
        celda.update();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    HomeBloc homeBloc = context.read<HomeBloc>();
    return SafeArea(
      child: Scaffold(
        body: Container(
          alignment: Alignment.center,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(ImagesApp.backgroundLogin),
                  fit: BoxFit.cover)),
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(10),
              constraints: const BoxConstraints(maxWidth: 600),
              child: Column(
                children: [
                  BlocBuilder<HomeBloc, HomeState>(
                    buildWhen: (previous, current) {
                      return current is! HomeGameCompletedState &&
                          current is! HomeSaveDataUsuarioState &&
                          current is! HomeClearListCellsState;
                    },
                    builder: (context, state) {
                      if (state is HomeInitialDataState) {
                        dataUsuario = state.dataUsuario;
                        return Tablero(
                            dataUsuario: state.dataUsuario, turn: actualTurn);
                      } else if (state is HomeUpdatedTableroState) {
                        dataUsuario = state.dataUsuario;
                        return Tablero(
                            dataUsuario: state.dataUsuario, turn: actualTurn);
                      } else if (state is HomeChangeTurnState) {
                        actualTurn = state.player;
                        return Tablero(
                            dataUsuario: dataUsuario, turn: state.player);
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                  BlocConsumer<HomeBloc, HomeState>(
                    buildWhen: (previous, current) {
                      return current is HomeClearListCellsState;
                    },
                    listener: (context, state) async {
                      if (state is HomeGameCompletedState) {
                        _changeColorWinnerCells(state.listWinnersIndex);
                        homeBloc.add(HomeSaveDataUsuarioEvent(
                            winner: state.winner,
                            actualDataUsuario: dataUsuario));
                        homeBloc.add(HomeUpdateDataTableroEvent(
                            codigo: dataUsuario.codigo));
                        okButton(context,
                            "Good game, ${state.winner == Player.player ? 'You' : 'CPU'} win ");
                      } else if (state is HomeEmpateState) {
                        homeBloc.add(HomeSaveDataUsuarioEvent(
                            winner: state.winner,
                            actualDataUsuario: dataUsuario));
                        homeBloc.add(HomeUpdateDataTableroEvent(
                            codigo: dataUsuario.codigo));
                        okButton(context, "Tie game, try again");
                      }
                    },
                    builder: (context, state) {
                      return BackgroundTablero(
                        child: Container(
                          constraints: const BoxConstraints(maxHeight: 300),
                          width: 300,
                          child: GridView.count(
                            crossAxisCount: 3,
                            children: List<CeldaMatriz>.generate(9, (index) {
                              listaCeldas.add(CeldaMatriz(
                                update: () {},
                                enabled: true,
                                color: Colors.deepPurple[500]!,
                                actualValue: Player.none,
                                action: () async {
                                  listaCeldas[index].actualValue = actualTurn;
                                  listaCeldas[index].enabled = false;
                                  actualTurn = actualTurn == Player.player
                                      ? Player.cpu
                                      : Player.player;
                                  homeBloc.add(HomeCheckGameIsCompletedEvent(
                                      listaCeldas: listaCeldas));
                                  homeBloc.add(
                                      HomeChangeTurnEvent(player: actualTurn));
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
                      onPressed: () {
                        listaCeldas.clear();
                        homeBloc.add(HomeClearListCellsEvent());
                      },
                      child: const Text("Play again")),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
