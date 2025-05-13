import 'dart:io';
import '../board.dart';
import 'player.dart';

class HumanPlayer extends Player {
  HumanPlayer(String name, String marker) : super(name, marker);

  @override
  void makeMove(Board board) {
    while (true) {
      stdout.write('$name ($marker), enter move (1-9): ');
      final input = stdin.readLineSync();
      final index = int.tryParse(input ?? '');

      if (index == null || index < 1 || index > 9) {
        print('Invalid input. Please enter a number 1-9');
        continue;
      }

      try {
        board.makeMove(index - 1, marker);
        break;
      } catch (e) {
        print(e);
      }
    }
  }
}