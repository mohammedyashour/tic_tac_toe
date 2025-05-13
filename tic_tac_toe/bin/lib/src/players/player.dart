import '../board.dart';

abstract class Player {
  final String name;
  final String marker;

  Player(this.name, this.marker);

  void makeMove(Board board);
}