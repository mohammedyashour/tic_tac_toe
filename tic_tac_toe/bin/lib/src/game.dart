
import 'dart:io';
import 'board.dart';
import 'players/player.dart';
import 'players/human_player.dart';
import 'players/computer_player.dart';

class Game {
  final Board _board = Board();
  late Player _currentPlayer;
  late Player _player1;
  late Player _player2;

  void start() {
    print('🎮 Welcome to Tic-Tac-Toe!');

    while (true) {
      _setupGame();
      _playGame();

      if (!_askToPlayAgain()) {
        print('\nThanks for playing! 👋');
        break;
      }
    }
  }

  bool _askToPlayAgain() {
    while (true) {
      stdout.write('\nPlay again? (y/n): ');
      final input = stdin.readLineSync()?.toLowerCase();

      if (input == 'n') return false;
      if (input == 'y') {
        _board.reset();
        return true;
      }
      print('Please enter "y" or "n"');
    }
  }

  void _setupGame() {
    final vsComputer = _chooseGameMode();
    _createPlayers(vsComputer);
    _currentPlayer = _player1;
    print('\n${_player1.name} vs ${_player2.name}');
  }

  bool _chooseGameMode() {
    print('\nGame Modes:');
    print('1. Player vs Player');
    print('2. Player vs Computer');

    while (true) {
      stdout.write('Choose mode (1/2): ');
      final input = stdin.readLineSync();
      if (input == '1') return false;
      if (input == '2') return true;
      print('Invalid choice. Please enter 1 or 2');
    }
  }

  void _createPlayers(bool vsComputer) {
    stdout.write('Enter your name: ');
    final name = stdin.readLineSync()?.trim() ?? 'Player 1';

    String marker;
    while (true) {
      stdout.write('Choose your marker (X/O): ');
      marker = stdin.readLineSync()?.toUpperCase() ?? 'X';
      if (marker == 'X' || marker == 'O') break;
      print('Invalid marker. Please choose X or O');
    }

    _player1 = HumanPlayer(name, marker);
    _player2 = vsComputer
        ? ComputerPlayer(marker == 'X' ? 'O' : 'X')
        : HumanPlayer(_getPlayer2Name(), marker == 'X' ? 'O' : 'X');
  }

  String _getPlayer2Name() {
    stdout.write('Enter second player name: ');
    return stdin.readLineSync()?.trim() ?? 'Player 2';
  }

  void _playGame() {
    while (true) {
      _board.display();
      _currentPlayer.makeMove(_board);

      if (_board.checkWin(_currentPlayer.marker)) {
        _board.display();
        print('🏆 ${_currentPlayer.name} wins!');
        break;
      }

      if (_board.isFull) {
        _board.display();
        print('🤝 It\'s a draw!');
        break;
      }

      _switchPlayer();
    }
  }

  void _switchPlayer() {
    _currentPlayer = _currentPlayer == _player1 ? _player2 : _player1;
  }
}