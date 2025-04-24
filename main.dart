import 'package:flutter/material.dart';

void main() {
  runApp(const TicTacToeApp());
}

class TicTacToeApp extends StatelessWidget {
  const TicTacToeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const TicTacToeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TicTacToeScreen extends StatefulWidget {
  const TicTacToeScreen({super.key});

  @override
  State<TicTacToeScreen> createState() => _TicTacToeScreenState();
}

class _TicTacToeScreenState extends State<TicTacToeScreen> {
  late List<List<String>> board;
  String currentPlayer = 'X';
  String? winner;
  List<List<int>>? winningLine;

  @override
  void initState() {
    super.initState();
    _initializeBoard();
  }

  void _initializeBoard() {
    setState(() {
      board = List.generate(3, (_) => List.filled(3, ''));
      currentPlayer = 'X';
      winner = null;
      winningLine = null;
    });
  }

  void _makeMove(int row, int col) {
    if (board[row][col].isNotEmpty || winner != null) {
      return;
    }

    setState(() {
      board[row][col] = currentPlayer;
      _checkWinner(row, col);
      if (winner == null) {
        currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
      }
    });
  }

  void _checkWinner(int row, int col) {
    // Check row
    if (board[row][0] == currentPlayer &&
        board[row][1] == currentPlayer &&
        board[row][2] == currentPlayer) {
      winningLine = [[row, 0], [row, 1], [row, 2]];
      winner = currentPlayer;
      return;
    }

    // Check column
    if (board[0][col] == currentPlayer &&
        board[1][col] == currentPlayer &&
        board[2][col] == currentPlayer) {
      winningLine = [[0, col], [1, col], [2, col]];
      winner = currentPlayer;
      return;
    }

    // Check diagonals
    if (row == col &&
        board[0][0] == currentPlayer &&
        board[1][1] == currentPlayer &&
        board[2][2] == currentPlayer) {
      winningLine = [[0, 0], [1, 1], [2, 2]];
      winner = currentPlayer;
      return;
    }

    if (row + col == 2 &&
        board[0][2] == currentPlayer &&
        board[1][1] == currentPlayer &&
        board[2][0] == currentPlayer) {
      winningLine = [[0, 2], [1, 1], [2, 0]];
      winner = currentPlayer;
      return;
    }

    // Check for draw
    if (!board.any((row) => row.any((cell) => cell.isEmpty))) {
      winner = 'Draw';
    }
  }

  bool _isWinningCell(int row, int col) {
    if (winningLine == null) return false;
    return winningLine!.any((pos) => pos[0] == row && pos[1] == col);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tic Tac Toe',style: TextStyle(
          fontSize: 30,fontWeight: FontWeight.bold
        ),),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              winner == null
                  ? 'Current Player: $currentPlayer'
                  : winner == 'Draw'
                  ? 'Game Draw!'
                  : 'Player $winner Wins!',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 10),
              ),
              child: Column(
                children: List.generate(3, (row) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(3, (col) {
                      return GestureDetector(
                        onTap: () => _makeMove(row, col),
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 4),
                            color: _isWinningCell(row, col)
                                ? Colors.green.withOpacity(0.3)
                                : Colors.transparent,
                          ),
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            transitionBuilder: (child, animation) {
                              return ScaleTransition(
                                scale: animation,
                                child: child,
                              );
                            },
                            child: Center(
                              key: ValueKey(board[row][col]),
                              child: Text(
                                board[row][col],
                                style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: board[row][col] == 'X'
                                      ? Colors.blue
                                      : Colors.red,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  );
                }),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _initializeBoard,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              child: const Text(
                'Restart Game',
                style: TextStyle(fontSize: 18),
              ),
            ),
            Text( "Made by Charan",style: TextStyle(fontSize: 12),  ),

          ],
        ),
      ),
    );
  }
}