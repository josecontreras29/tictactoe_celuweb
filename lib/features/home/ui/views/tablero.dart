import 'package:flutter/material.dart';

import '../../../-config/themes/title_themes.dart';
import '../../../login/domain/entities/data_usuario.dart';
import 'home_view.dart';

class Tablero extends StatelessWidget {
  const Tablero({super.key, required this.dataUsuario, required this.turn});

  final DataUsuario dataUsuario;
  final Player turn;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.deepPurple[100]!,
            borderRadius: BorderRadius.circular(5),
            boxShadow: const [
              BoxShadow(color: Colors.black, spreadRadius: 1, blurRadius: 3)
            ]),
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                  flex: 1,
                  child: Column(
                    children: [
                      Icon(Icons.person,
                          size: 36,
                          color: turn == Player.player
                              ? Colors.red
                              : Colors.black),
                      Text(dataUsuario.nombre,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: turn == Player.player
                                  ? Colors.red
                                  : Colors.black),
                          textAlign: TextAlign.center),
                      Wrap(
                        alignment: WrapAlignment.center,
                        children: [
                          Text("Score:  ", style: TitleThemes.subTitlesHome),
                          Text(dataUsuario.victorias.toString(),
                              style: TitleThemes.valueDataHome),
                        ],
                      ),
                    ],
                  ),
                ),
                Flexible(child: Text("VS", style: TitleThemes.subTitlesHome)),
                Flexible(
                  flex: 1,
                  child: Column(
                    children: [
                      Icon(
                        Icons.computer,
                        size: 36,
                        color:
                            turn == Player.cpu ? Colors.yellow : Colors.black,
                      ),
                      Text("CPU",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: turn == Player.cpu
                                  ? Colors.yellow
                                  : Colors.black),
                          textAlign: TextAlign.center),
                      Wrap(
                        alignment: WrapAlignment.center,
                        children: [
                          Text("Score: ", style: TitleThemes.subTitlesHome),
                          Text(dataUsuario.derrotas.toString(),
                              style: TitleThemes.valueDataHome),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: Wrap(
                spacing: 20,
                children: [
                  Wrap(
                    children: [
                      Text("Turno:  ", style: TitleThemes.subTitlesHome),
                      Text(
                        turn == Player.player ? dataUsuario.nombre : "CPU",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: turn == Player.player
                                ? Colors.red
                                : Colors.yellow),
                      )
                    ],
                  ),
                  Wrap(
                    children: [
                      Text("Partidas jugadas:  ",
                          style: TitleThemes.subTitlesHome),
                      Text(dataUsuario.partidasJugadas.toString(),
                          style: TitleThemes.valueDataHome),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
