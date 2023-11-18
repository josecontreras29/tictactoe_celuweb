import 'package:flutter/material.dart';

import '../../../-config/themes/title_themes.dart';
import '../../../login/domain/entities/data_usuario.dart';
import '../reusable_widgets.dart/background_login.dart';
import 'home_view.dart';

class Tablero extends StatelessWidget {
  const Tablero(
      {super.key,
      required this.dataUsuario,
      required this.player,
      required this.partidasJugadas});

  final DataUsuario dataUsuario;
  final Players player;
  final int partidasJugadas;

  @override
  Widget build(BuildContext context) {
    return BackgroundLogin(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 1,
                child: Column(
                  children: [
                    const Icon(Icons.person, size: 36),
                    Text(dataUsuario.nombre,
                        style: TitleThemes.titlesHome,
                        textAlign: TextAlign.center),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
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
                    const Icon(Icons.computer, size: 36),
                    Text("CPU",
                        style: TitleThemes.titlesHome,
                        textAlign: TextAlign.center),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
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
                    Text(player == Players.player ? dataUsuario.nombre : "CPU",
                        style: TitleThemes.valueDataHome)
                  ],
                ),
                Wrap(
                  children: [
                    Text("Partidas jugadas:  ",
                        style: TitleThemes.subTitlesHome),
                    Text(partidasJugadas.toString(),
                        style: TitleThemes.valueDataHome),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
