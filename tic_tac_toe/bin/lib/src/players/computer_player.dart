import 'dart:math';
import '../board.dart';
import 'player.dart';

class ComputerPlayer extends Player {
  final Random _random = Random();

  ComputerPlayer(String marker) : super('Computer', marker);

  @override
  void makeMove(Board board) {
    print('🤖 Computer is thinking...');

    final emptyCells = List.generate(9, (index) => index)
        .where((index) => board.isCellEmpty(index))
        .toList();

    if (emptyCells.isNotEmpty) {
      final randomIndex = emptyCells[_random.nextInt(emptyCells.length)];
      board.makeMove(randomIndex, marker);
    }
  }
}