import '../../home/ui/reusable_widgets.dart/celda_matriz_juego.dart';
import '../../home/ui/views/home_view.dart';

class CheckStatusGame {
  final List<CeldaMatriz> listaCeldas;

  CheckStatusGame({required this.listaCeldas});

  DatosGanador verifyHorizontals() {
    for (int i = 0; i < 9; i++) {
      if (i % 3 == 0) {
        if (listaCeldas[i].actualValue == Player.player &&
            listaCeldas[i + 1].actualValue == Player.player &&
            listaCeldas[i + 2].actualValue == Player.player) {
          return DatosGanador(
              celdasGanadoras: [i, i + 1, i + 2], winner: Player.player);
        } else if (listaCeldas[i].actualValue == Player.cpu &&
            listaCeldas[i + 1].actualValue == Player.cpu &&
            listaCeldas[i + 2].actualValue == Player.cpu) {
          return DatosGanador(
              celdasGanadoras: [i, i + 1, i + 2], winner: Player.cpu);
        }
      }
    }
    return DatosGanador(celdasGanadoras: [], winner: Player.none);
  }

  DatosGanador verifyVerticals() {
    for (int i = 0; i < 3; i++) {
      if (listaCeldas[i].actualValue == Player.player &&
          listaCeldas[i + 3].actualValue == Player.player &&
          listaCeldas[i + 6].actualValue == Player.player) {
        return DatosGanador(
            celdasGanadoras: [i, i + 3, i + 6], winner: Player.player);
      } else if (listaCeldas[i].actualValue == Player.cpu &&
          listaCeldas[i + 3].actualValue == Player.cpu &&
          listaCeldas[i + 6].actualValue == Player.cpu) {
        return DatosGanador(
            celdasGanadoras: [i, i + 3, i + 6], winner: Player.cpu);
      }
    }
    return DatosGanador(celdasGanadoras: [], winner: Player.none);
  }

  DatosGanador verifyDiagonals() {
    if (listaCeldas[0].actualValue == Player.player &&
        listaCeldas[4].actualValue == Player.player &&
        listaCeldas[8].actualValue == Player.player) {
      return DatosGanador(celdasGanadoras: [0, 4, 8], winner: Player.player);
    } else if (listaCeldas[0].actualValue == Player.cpu &&
        listaCeldas[4].actualValue == Player.cpu &&
        listaCeldas[8].actualValue == Player.cpu) {
      return DatosGanador(celdasGanadoras: [0, 4, 8], winner: Player.cpu);
    }
    if ((listaCeldas[2].actualValue == Player.player &&
        listaCeldas[4].actualValue == Player.player &&
        listaCeldas[6].actualValue == Player.player)) {
      return DatosGanador(celdasGanadoras: [2, 4, 6], winner: Player.player);
    } else if (listaCeldas[2].actualValue == Player.cpu &&
        listaCeldas[4].actualValue == Player.cpu &&
        listaCeldas[6].actualValue == Player.cpu) {
      return DatosGanador(celdasGanadoras: [2, 4, 6], winner: Player.cpu);
    }
    return DatosGanador(celdasGanadoras: [], winner: Player.none);
  }

  bool verifyEmpate() {
    for (var celda in listaCeldas) {
      if (celda.actualValue == Player.none) {
        return false;
      }
    }
    return true;
  }
}

class DatosGanador {
  final List<int> celdasGanadoras;
  final Player winner;

  DatosGanador({required this.celdasGanadoras, required this.winner});
}
