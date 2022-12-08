//
//  Board.swift
//  TicTacToe
//
//  Created by Aksel Nielsen on 2022-12-07.
//

import Foundation

enum Piece: String {
    case X = "X"
    case O = "O"
    case E = " "
    var opposite: Piece {
        switch self {
        case .X:
            return .O
        case .O:
            return .X
        case .E:
            return .E
        }
    }
}

typealias Move = Int

struct Board {
    var position: [Piece]
    let turn: Piece
    let lastMove: Move
    
    // by default the board is empty and X goes first
    // lastMove being -1 is a marker of a start position
    init(position: [Piece] = [.E, .E, .E, .E, .E, .E, .E, .E, .E], turn: Piece = .X, lastMove: Int = -1) {
        self.position = position
        self.turn = turn
        self.lastMove = lastMove
    }
    
    // location can be 0-8, indicating where to move
    // return a new board with the move played
    func move(_ location: Move) -> Board {
        var newPosition = position
        newPosition[location] = turn
        return Board(position: newPosition, turn: turn.opposite, lastMove: location)
    }
    
    var legalMoves: [Move] {
        //Returns all availible moves where the position is .E(empty)
        return position.indices.filter { position[$0] == .E }
    }
    
    var isWin: Bool {
        //Win conditions
        return
        position[0] == position[1] && position[0] == position[2] && position[0] != .E || // row 0
        position[3] == position[4] && position[3] == position[5] && position[3] != .E || // row 1
        position[6] == position[7] && position[6] == position[8] && position[6] != .E || // row 2
        position[0] == position[3] && position[0] == position[6] && position[0] != .E || // col 0
        position[1] == position[4] && position[1] == position[7] && position[1] != .E || // col 1
        position[2] == position[5] && position[2] == position[8] && position[2] != .E || // col 2
        position[0] == position[4] && position[0] == position[8] && position[0] != .E || // diag 0
        position[2] == position[4] && position[2] == position[6] && position[2] != .E // diag 1
        
    }
    var isDraw: Bool {
        return !isWin && legalMoves.count == 0
    }
    // Find the best possible outcome for originalPlayer
    func minimax(_ board: Board, maximizing: Bool, originalPlayer: Piece) -> Int {
        // Base case - evaluate the position if it is a win or a draw
        if board.isWin && originalPlayer == board.turn.opposite { return 1 } // win
        else if board.isWin && originalPlayer != board.turn.opposite { return -1 } // loss
        else if board.isDraw { return 0 } // draw
        
        // Recursive case - maximize your gains or minimize the opponent's gains
        if maximizing {
            var bestEval = Int.min
            for move in board.legalMoves { // find the move with the highest evaluation
                let result = minimax(board.move(move), maximizing: false, originalPlayer: originalPlayer)
                bestEval = max(result, bestEval)
            }
            return bestEval
        } else { // minimizing
            var worstEval = Int.max
            for move in board.legalMoves {
                let result = minimax(board.move(move), maximizing: true, originalPlayer: originalPlayer)
                worstEval = min(result, worstEval)
            }
            return worstEval
        }
    }
    // Run minimax on every possible move to find the best one
    func findBestMove(_ board: Board) -> Move {
        var bestEval = Int.min
        var bestMove = -1
        for move in board.legalMoves {
            let result = minimax(board.move(move), maximizing: false, originalPlayer: board.turn)
            if result > bestEval {
                bestEval = result
                bestMove = move
            }
        }
        return bestMove
    }
    //Returns a new empty board
    func newBoard () -> Board{
        return Board()
    }
    //Return a new board where a a "random" move has been played
    func randomPlacement (board : Board) -> Board{
        let availablePlacements = board.legalMoves
        if availablePlacements.isEmpty{
            let emptyBoard = Board()
            return emptyBoard
        }else{
            let randomMove = availablePlacements.shuffled().first
            return move(randomMove!)
            
        }
     
    }
    
    
    
    
    
}
