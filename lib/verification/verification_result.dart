import 'dart:collection';

class VerificationResult {
  final bool isGameOver;
  final List<int> winningPieces;
  final HashMap<int, int> positionsAndPriorities;

  VerificationResult(this.isGameOver, this.winningPieces, this.positionsAndPriorities);
}