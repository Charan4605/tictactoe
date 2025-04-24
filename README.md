Tic-Tac-Toe Flutter App
 
A simple two-player Tic-Tac-Toe game built with Flutter that runs on both iOS and Android devices.

Features
🎮 Two-player game on the same device (alternating between X and O)

🟦 Clean 3×3 grid UI with visual feedback

🔍 Win detection for all possible combinations

🤝 Draw detection when the board is full

🔄 "Restart Game" button to reset the board

✨ Animations for moves and winning combinations

📱 Responsive design that works on mobile devices

Getting Started
Prerequisites
Flutter SDK (latest stable version)

Dart SDK

Android Studio/Xcode (for emulators/simulators)

Installation
Clone the repository:

bash
git clone (https://github.com/Charan4605/tictactoe/tree/main)
cd flutter-tic-tac-toe
Install dependencies:

bash
flutter pub get
Run the app:

bash
flutter run
How to Play
The game starts with Player X's turn

Tap any empty cell to place your symbol

Players alternate turns between X and O

The first player to get 3 in a row (horizontally, vertically, or diagonally) wins

If all cells are filled without a winner, the game ends in a draw

Press the "Restart Game" button to start a new game

Technical Details
State Management: Uses Flutter's built-in setState for simplicity

Animations:

Scale animation when symbols appear

Green highlight for winning combinations

Win Detection: Checks all 8 possible winning combinations

Widgets: Built with core Flutter widgets (GestureDetector, AnimatedSwitcher, etc.)
