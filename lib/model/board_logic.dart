import 'dart:collection';
import 'dart:math';

import 'package:connect4/model/piece.dart';
import 'package:connect4/model/piece_state.dart';
import 'package:connect4/verification/falling_diagonal_strategy.dart';
import 'package:connect4/verification/horizontal_strategy.dart';
import 'package:connect4/verification/rising_diagonal_strategy.dart';
import 'package:connect4/verification/verification_strategy.dart';
import 'package:connect4/verification/vertical_strategy.dart';

class BoardLogic {
  static const columnHeight = 6;
  static const rowWidth = 7;
  static const four = 4;
  static const size = columnHeight * rowWidth;
  HashMap<int, int> freePositions = HashMap();

  var boardPieces = List<Piece>.generate(size, (i) {
    return Piece();
  });

  void resetBoard() {
    boardPieces = List<Piece>.generate(size, (i) {
      return Piece();
    });
  }

  PieceState getPieceState(int nr) {
    return boardPieces[nr].state;
  }

  int putPieceInColumn(int columnNr, PieceState player) {
    if (columnHasSpace(columnNr)) {
      int pos = getFirstFreePositionInColumn(columnNr);
      boardPieces[pos].newState = player;
      return pos;
    }
    return -1;
  }

  int getFirstFreePositionInColumn(int columnNr) {
    int freePosition = -1;
    int topPosition = getTopPiecePosition(columnNr);
    int bottomPosition = topPosition - columnHeight + 1;

    for (int i = bottomPosition; i <= topPosition; i++) {
      if (boardPieces[i].state == PieceState.empty) {
        freePosition = i;
        break;
      }
    }
    return freePosition;
  }

  bool columnHasSpace(int columnNr) {
    int columnTopPosition = getTopPiecePosition(columnNr);
    return boardPieces[columnTopPosition].state == PieceState.empty;
  }

  int getTopPiecePosition(columnNr) {
    return columnNr * columnHeight - 1;
  }

  bool isGameOverWithOneWinner(
      List<VerificationStrategy> strategies, PieceState player) {
    freePositions.clear();
    bool result = false;
    for (VerificationStrategy vs in strategies) {
      freePositions.addAll(vs.positionsAndPriorities);
      var verifResult = vs.getResult();
      if (verifResult.isGameOver) {
        result = true;
        highlightWinningPieces(verifResult.winningPieces, player);
        break;
      }
    }
    return result;
  }

  int getMaxPriorityColumnNr() {
    int maxPriorityPosition = -1;
    int maxPriority = -1;
    freePositions.forEach((pos, pri) {
      print("position, priority: $pos, $pri");
      print("considering column: ${(pos / 6).floor()}");
      if (pri > maxPriority) {
        maxPriorityPosition = pos;
        maxPriority = pri;
      }
    });
    if (maxPriorityPosition == -1) {
      return getRandomColumn();
    }
    return (maxPriorityPosition / 6).floor() + 1;
  }

  int getRandomColumn() {
    var ran = Random().nextInt(6) + 1;
    while (!columnHasSpace(ran)) {
      ran = Random().nextInt(6) + 1;
    }
    return ran;
  }

  bool isGameOverWithTie() {
    var emptyPiece = boardPieces.firstWhere((p) => p.state == PieceState.empty,
        orElse: () => null);
    if (emptyPiece == null) {
      return true;
    }
    return false;
  }

  void highlightWinningPieces(List<int> indexes, PieceState player) {
    for (int i in indexes) {
      boardPieces[i].newState = player == PieceState.player1
          ? PieceState.winner2
          : PieceState.winner1;
    }
  }

  List<VerificationStrategy> getStrategies(
      int lastMovePosition, PieceState pieceState) {
    var positionsAndPriorities = new HashMap<int, int>();
    VerificationStrategy horizontal = HorizontalStrategy(
        lastMovePosition, boardPieces, positionsAndPriorities);
    VerificationStrategy vertical =
        VerticalStrategy(lastMovePosition, boardPieces, positionsAndPriorities);
    VerificationStrategy risingDiagonal = RisingDiagonalStrategy(
        lastMovePosition, boardPieces, positionsAndPriorities);
    VerificationStrategy fallingDiagonal = FallingDiagonalStrategy(
        lastMovePosition, boardPieces, positionsAndPriorities);
    List<VerificationStrategy> strategies = List();
    strategies.add(horizontal);
    strategies.add(vertical);
    strategies.add(risingDiagonal);
    strategies.add(fallingDiagonal);
    return strategies;
  }
}
