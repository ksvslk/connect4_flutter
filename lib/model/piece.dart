import 'package:connect4/model/piece_state.dart';

class Piece {

  var _state = PieceState.empty;
  set newState(PieceState pieceState) => _state = pieceState;
  get state => _state;

}
