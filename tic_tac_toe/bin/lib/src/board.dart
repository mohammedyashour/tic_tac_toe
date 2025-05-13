class Board {
  static const size = 9;
  late final List<String> cells;
  void reset() {
    cells = List.filled(size, ' ');
  }
  Board() : cells = List.filled(size, ' ');

  bool get isFull => !cells.contains(' ');

  bool isCellEmpty(int index) => cells[index] == ' ';

  void makeMove(int index, String marker) {
    if (index < 0 || index >= size) throw RangeError.range(index, 0, size - 1);
    if (!isCellEmpty(index)) throw StateError('Cell already occupied');
    cells[index] = marker;
  }

  bool checkWin(String marker) {
    const winPatterns = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8], // rows
      [0, 3, 6], [1, 4, 7], [2, 5, 8], // columns
      [0, 4, 8], [2, 4, 6]              // diagonals
    ];

    return winPatterns.any((pattern) =>
        pattern.every((index) => cells[index] == marker));
  }

  void display() {
    print('''
     ${cells[0]} | ${cells[1]} | ${cells[2]} 
    ---+---+---
     ${cells[3]} | ${cells[4]} | ${cells[5]} 
    ---+---+---
     ${cells[6]} | ${cells[7]} | ${cells[8]} 
    ''');
  }
}