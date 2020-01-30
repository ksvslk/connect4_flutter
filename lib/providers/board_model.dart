
import 'package:connect4/model/board_logic.dart';
import 'package:connect4/model/piece_state.dart';
import 'package:flutter/cupertino.dart';

class BoardModel with ChangeNotifier {
  final bool isAgainstComputer;
  final BoardLogic _board = BoardLogic();
  
  BoardModel({@required this.isAgainstComputer});

  var _player = PieceState.player1;
  var _isGameOverWithTie = false;
  var _isGameOverWithOneWinner = false;
  var _lastMovePosition = -1;
  var _p1Points = 0.0;
  var _p2Points = 0.0;
  var _statusText = "";

  get statusText => _statusText;
  get p1Points => _p1Points;
  get p2Points => _p2Points;
  get playerTurn => _player;
  get isGameOverWithOneWinner => _isGameOverWithOneWinner;
  get isGameOverWithTie => _isGameOverWithTie;

  void move(int columnNr) {
    _lastMovePosition = _board.putPieceInColumn(columnNr, _player);
    if (_lastMovePosition != -1 &&
        !_isGameOverWithOneWinner &&
        !_isGameOverWithTie) {
      changePlayerTurn();
      endGameWhenItIsOver();
      notifyListeners();
    }
  }

  Future computerMove() {
    return Future.delayed(const Duration(seconds: 1),
        () => move(_board.getMaxPriorityColumnNr()));
  }

  void makeMove(int columnNr) {
    if (isAgainstComputer) {
      if (_player == PieceState.player1) {
        move(columnNr);
        computerMove();
      }
    } else {
      move(columnNr);
    }
  }

  void changePlayerTurn() {
    _player =
        _player == PieceState.player1 ? PieceState.player2 : PieceState.player1;
  }

  void endGameWhenItIsOver() {
    var strategies = _board.getStrategies(_lastMovePosition, _player);
    _isGameOverWithOneWinner =
        _board.isGameOverWithOneWinner(strategies, _player);
    _isGameOverWithTie = _board.isGameOverWithTie();
    addPoints();
    updateStatusText();
  }

  void updateStatusText() {
    if (isGameOverWithTie) {
      _statusText = "TIE!";
    } else if (_isGameOverWithOneWinner && !isAgainstComputer) {
      _statusText =
          "WINNER: ${_player == PieceState.player1 ? 'Luigi' : 'Mario'}";
    } else if (_isGameOverWithOneWinner && isAgainstComputer) {
      _statusText =
          "WINNER: ${_player == PieceState.player1 ? 'Computer' : 'Luigi'}";
    }
  }

  void addPoints() {
    if (_isGameOverWithOneWinner) {
      addPointsToWinner();
    } else if (_isGameOverWithTie) {
      addPointsToBoth();
    }
  }

  void addPointsToWinner() {
    if (_player == PieceState.player1) {
      _p2Points++;
    } else if (_player == PieceState.player2) {
      _p1Points++;
    }
  }

  void addPointsToBoth() {
    _p1Points += 0.5;
    _p2Points += 0.5;
  }

  PieceState getPositionState(int position) {
    return _board.getPieceState(position);
  }

  void resetGame() {
    _board.resetBoard();
    _isGameOverWithTie = false;
    _isGameOverWithOneWinner = false;
    _player = PieceState.player1;
    _lastMovePosition = -1;
    _statusText = "";
    notifyListeners();
  }
}
