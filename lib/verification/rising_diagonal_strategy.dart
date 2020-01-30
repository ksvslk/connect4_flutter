import 'dart:collection';

import 'package:connect4/model/piece.dart';
import 'package:connect4/model/piece_state.dart';
import 'package:connect4/verification/verification_result.dart';
import 'package:connect4/verification/verification_strategy.dart';

class RisingDiagonalStrategy extends VerificationStrategy {
  RisingDiagonalStrategy(int lastMovePosition, List<Piece> pieces, HashMap<int, int> positions)
      : super(lastMovePosition, pieces, positions);
  @override
  VerificationResult getResult() {
    final PieceState pieceState = pieces[lastMovePosition].state;
    final int first = firstIndex();
    final int last = lastIndex();
    List<int> winningPieces = new List();
    if (first == last)
      return VerificationResult(false, winningPieces, positionsAndPriorities);
    int connectedPiecesCount = 0;

    for (int index = first; index <= last; index += 7) {
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

  int distanceToLeft() => (lastMovePosition / 6).floor();
  int distanceToRight() => 6 - (lastMovePosition / 6).floor();
  int leftMostPos() => lastMovePosition - distanceToLeft() * 6;
  int bottomFirstDiagonalPos() =>
      lastMovePosition - leftMostPos() - leftMostPos() * 6;
  int topMostPos() =>
      lastMovePosition + 5 + distanceToLeft() * 6 - lastMovePosition;
  int rightMostPos() => lastMovePosition + distanceToRight() * 6;

  @override
  int firstIndex() {
    if ((lastMovePosition).remainder(6) == 0)
      return lastMovePosition;
    else if (leftMostPos() - distanceToLeft() >= 0)
      return leftMostPos() - distanceToLeft();
    else
      return bottomFirstDiagonalPos();
  }

  @override
  int lastIndex() {
    if (leftMostPos() - distanceToLeft() >= 0) {
      return topMostPos() + 6 * (topMostPos() - lastMovePosition);
    }
    return rightMostPos() + distanceToRight();
  }

  @override
  int getFirstFreePosition(List<int> positions) {
    if (positions.length > 0) {
      int free = positions[0] - 7;
      return free.remainder(6) == 0 ? free : -1;
    }
    return -1;
  }
}
