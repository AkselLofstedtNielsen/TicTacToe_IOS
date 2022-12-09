//
//  ViewController.swift
//  TicTacToe
//
//  Created by Aksel Nielsen on 2022-11-29.
//

import UIKit

class ViewController: UIViewController {
    
    
    var gameMode = 2
    //int that is being sent from startVC 0 = 1v1(standard), 1 = easyBot, 2 = hardBot
    
    var p1Name : String?
    var p2Name : String?
    
    var p1Score = 0
    var p2Score = 0
    
    @IBOutlet weak var p1TurnLabel: UILabel!
    //x = p1
    @IBOutlet weak var p2TurnLabel: UILabel!
    //o = p2
    @IBOutlet weak var p2TurnTextForFlip: UILabel!
    
    @IBOutlet weak var a1: UIButton!
    @IBOutlet weak var a2: UIButton!
    @IBOutlet weak var a3: UIButton!
    
    @IBOutlet weak var b1: UIButton!
    @IBOutlet weak var b2: UIButton!
    @IBOutlet weak var b3: UIButton!
    
    @IBOutlet weak var c1: UIButton!
    @IBOutlet weak var c2: UIButton!
    @IBOutlet weak var c3: UIButton!
    
    var buttonBoard = [UIButton]()
    var board = Board()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initButtons()
        implementBoardToTitles()
        
        //Mirrors player2s texts
        p2TurnLabel.transform = CGAffineTransform(rotationAngle: 3.14)
        p2TurnTextForFlip.transform = CGAffineTransform(rotationAngle: 3.14)
        
        
            p1TurnLabel.text = p1Name
            p2TurnLabel.text = p1Name
        
       
        
        
    }

    
    func initButtons(){
        //Adds the buttons to an array of buttons
        buttonBoard.append(a1)
        buttonBoard.append(a2)
        buttonBoard.append(a3)
        
        buttonBoard.append(b1)
        buttonBoard.append(b2)
        buttonBoard.append(b3)
        
        buttonBoard.append(c1)
        buttonBoard.append(c2)
        buttonBoard.append(c3)
    }

    @IBAction func buttonPress(_ sender: UIButton) {
        if sender.title(for: .normal) == " "{
            switch sender{
            case a1:
                makeMove(index: 0)
            case a2:
                makeMove(index: 1)
            case a3:
                makeMove(index: 2)
            case b1:
                makeMove(index: 3)
            case b2:
                makeMove(index: 4)
            case b3:
                makeMove(index: 5)
            case c1:
                makeMove(index: 6)
            case c2:
                makeMove(index: 7)
            case c3:
                makeMove(index: 8)
            default:
                break
            }
        }

    }
    func makeMove (index : Int){
        //Function for making a move and checking win or draw per move. For gamemodes 1-3.
        if gameMode == 0{
            board = board.move(index)
            implementBoardToTitles()
            changeNameLabels()
            if board.isWin{
                win()
            }
            else if board.isDraw{
                resultAlert(title: "Draw!")
            }

        }
        else if gameMode == 1{
            //User Input + win/draw check
            board = board.move(index)
            implementBoardToTitles()
            if board.isWin{
                win()
            }
            else if board.isDraw{
                resultAlert(title: "Draw")
            }
            else{
                //Random Input+ win/draw check
                board = board.randomPlacement(board: board)
                implementBoardToTitles()
                if board.isWin{
                    win()
                }
                else if board.isDraw{
                    resultAlert(title: "Draw")
                }
            }
        }
        else if gameMode == 2{
            board = board.move(index)
            //user input + win/draw check
            if board.isWin == true{
                win()
            }
            else if board.isDraw == true {
                resultAlert(title: "Draw")
            }else{
                    //Impossible computer input + win/draw check
                    let aiMove = board.findBestMove(board)
                    let aiBoard = board.move(aiMove)
                    board = aiBoard
                    implementBoardToTitles()
                    if board.isWin == true{
                        win()
                    }
                    else if board.isDraw{
                        resultAlert(title: "Draw")
                    }

            }
        }
    }
    func win(){
        if board.position[board.lastMove].rawValue == "X"{
            p1Score += 1
            resultAlert(title: "Winner: \(p1Name ?? "X")")
        }else{
            p2Score += 1
            resultAlert(title: "Winner: \(p2Name ?? "O")")
        }
    }
    func resultAlert(title : String){
        let message = "\n\(p1Name ?? "X") " + String(p1Score) + "\n\(p2Name ?? "O") " + String(p2Score)
        let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Reset", style: .default, handler: {(_) in
            self.resetBoard()
        }))
        self.present(ac, animated: true)
     }
    
    func resetBoard(){
        board = board.newBoard()
        implementBoardToTitles()
    }
    func implementBoardToTitles (){
        //Implementing the "Board" to the buttons titles for the user to see and interact with.
        var i = 0
        for pieces in board.position{
            buttonBoard[i].setTitle(pieces.rawValue, for: .normal)
            i += 1

        }
        
    }
    func changeNameLabels (){
        //func for changing the labels between turns to the payer whos turn it is.
        if p1TurnLabel.text == p1Name && p2TurnLabel.text == p1Name{
            p1TurnLabel.text = p2Name
            p2TurnLabel.text = p2Name
        }
        else if p1TurnLabel.text == p2Name && p2TurnLabel.text == p2Name{
            p1TurnLabel.text = p1Name
            p2TurnLabel.text = p1Name
        }
        
    }
  
    //Fix Player names per turn
    //Back button

    }
    


