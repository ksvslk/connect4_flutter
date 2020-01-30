import 'dart:collection';

import 'package:connect4/model/piece.dart';
import 'package:connect4/model/piece_state.dart';
import 'package:connect4/verification/verification_result.dart';
import 'package:connect4/verification/verification_strategy.dart';

class VerticalStrategy extends VerificationStrategy {
  VerticalStrategy(int lastMovePosition, List<Piece> pieces, HashMap<int, int> positions)
      : super(lastMovePosition, pieces, positions);

  @override
  VerificationResult getResult() {
    final PieceState pieceState = pieces[lastMovePosition].state;
    final int first = firstIndex();
    final int last = lastIndex();

    List<int> winningPieces = new List();
    int connectedPiecesCount = 0;

    for (int index = first; index <= last; index++) {
      if (pieces[index].state == pieceState && connectedPiecesCount != 4) {
        connectedPiecesCount++;
        winningPieces.add(index);
      } else if (pieces[index].state != pieceState &&
          connectedPiecesCount != 4) {
        addPositions(
            getFirstFreePosition(winningPieces), index, connectedPiecesCount);
        connectedPiecesCount = 0;
        winningPieces.clear();
      }
    }
    return VerificationResult(
        connectedPiecesCount == 4, winningPieces, positionsAndPriorities);
  }

  @override
  int firstIndex() {
    return (lastMovePosition / 6).floor() * 6;
  }

  @override
  int lastIndex() {
    return firstIndex() + 5;
  }

  @override
  int getFirstFreePosition(List<int> positions) {
    if (positions.length > 0) {
      int free = positions[0] - 1;
      int occupied = positions[0];
      bool columnsAreSame = isFreePositionInTheSameColumn(free, occupied);
      return columnsAreSame ? free :  -1;
    }
    return -1;
  }

  
}
