import 'dart:collection';

import 'package:connect4/model/piece.dart';
import 'package:connect4/model/piece_state.dart';
import 'package:connect4/verification/verification_result.dart';
import 'package:connect4/verification/verification_strategy.dart';

class FallingDiagonalStrategy extends VerificationStrategy {
  FallingDiagonalStrategy(int lastMovePosition, List<Piece> pieces, HashMap<int, int> positions)
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

    for (int index = first; index <= last; index += 5) {
      if (pieces[index].state == pieceState && connectedPiecesCount != 4) {
        connectedPiecesCount++;
        winningPieces.add(index);
      } else if (pieces[index].state != pieceState &&
              connectedPiecesCount != 4 ||
          (index).remainder(6) == 0 && connectedPiecesCount != 4  ||
          (index / 6).floor() == 6 && connectedPiecesCount != 4) {
            print("falling_stategy winninPieces: $winningPieces");
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
      lastMovePosition + rightMostPos() - rightMostPos() * 6;
  int topMostPos() =>
      lastMovePosition + 5 + distanceToLeft() * 6 - lastMovePosition;
  int rightMostPos() => lastMovePosition + distanceToRight() * 6;
  int distanceToBottom() => 5 - (topMostPos() - lastMovePosition);
  int distanceToTop() => topMostPos() - lastMovePosition;

  @override
  int lastIndex() {
    if (lastMovePosition == 41 || lastMovePosition == 0) {
      return lastMovePosition;
    } else if ((lastMovePosition).remainder(6) == 0) {
      return lastMovePosition;
    } else if ((lastMovePosition - distanceToBottom()) +
            distanceToBottom() * 6 <=
        41) {
      return (lastMovePosition - distanceToBottom()) + distanceToBottom() * 6;
    } else if ((lastMovePosition - distanceToBottom()) +
            distanceToBottom() * 6 >
        41) {
      return (lastMovePosition + distanceToRight() * 6) - distanceToRight();
    } else {
      return bottomFirstDiagonalPos();
    }
  }

  @override
  int firstIndex() {
    if (lastMovePosition == 41 || lastMovePosition == 0) {
      return lastMovePosition;
    } else if (distanceToLeft() > distanceToTop()) {
      return topMostPos() - 6 * (topMostPos() - lastMovePosition);
    }
    return leftMostPos() + distanceToLeft();
  }

  @override
  int getFirstFreePosition(List<int> positions) {
    if (positions.length > 0) {
      int free = positions[0] - 5;
      return free;
    }
    return -1;
  }
}
