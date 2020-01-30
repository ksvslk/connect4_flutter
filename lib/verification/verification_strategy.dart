import 'dart:collection';

import 'package:connect4/model/piece.dart';
import 'package:connect4/model/piece_state.dart';
import 'package:connect4/verification/verification_result.dart';

abstract class VerificationStrategy {
  final int lastMovePosition;
  final List<Piece> pieces;
  final HashMap<int, int> positionsAndPriorities;

  VerificationStrategy(this.lastMovePosition, this.pieces, this.positionsAndPriorities);

  VerificationResult getResult();
  int firstIndex();
  int lastIndex();
  int getFirstFreePosition(List<int> connectedPieces);

  bool isInRange(int number, int low, int high) {
    if(number == null || low == null || high == null) {
      return false;
    }
    return number >= low && number <= high;
  }

  void addPositions(int first, int last, int connectedPiecesCount) {
    if (isInRange(first, 0, 41)) {
      saveFreePosition(pieces[first].state, first, connectedPiecesCount);
    }
    if (isInRange(last, 0, 41)) {
        saveFreePosition(pieces[last].state, last, connectedPiecesCount);
      }
    }

  void saveFreePosition(PieceState state, int position, int priority) {
    if (state == PieceState.empty && priority >= 2) {
      positionsAndPriorities.putIfAbsent(position, () => priority);
    }
  }

  bool isFreePositionInTheSameColumn(int free, int occupied) {
      int freePositionColumnNr = (free / 6).floor();
      int occupiedPositionColumnNr = (occupied / 6).floor();
      return occupiedPositionColumnNr == freePositionColumnNr;
  }
}
