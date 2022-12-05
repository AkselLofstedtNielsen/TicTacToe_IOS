//
//  ViewController.swift
//  TicTacToe
//
//  Created by Aksel Nielsen on 2022-11-29.
//

import UIKit

class ViewController: UIViewController {
    

    var chosenGameMode = 0
    //int that is being sent from startVC 0 = 1v1(standard), 1 = easyBot, 2 = hardBot
    
    var p1Name : String?
    var p2Name : String?
    
    enum Turn{
        case Circle
        case Cross
    }
    var firstTurn = Turn.Cross
    var currentTurn = Turn.Cross
    
    var CIRCLE = "O"
    var CROSS = "X"
    
    var board = [UIButton]()
    
    var p1Score = 0
    var p2Score = 0

    @IBOutlet weak var p1TurnLabel: UILabel!
    //x = p1
    @IBOutlet weak var p2TurnLabel: UILabel!
    //o = p2
    @IBOutlet weak var p2TurnTextForFlip: UILabel!
    
    @IBOutlet weak var row1Btn1: UIButton!
    @IBOutlet weak var row1Btn2: UIButton!
    @IBOutlet weak var row1Btn3: UIButton!
    
    @IBOutlet weak var row2Btn1: UIButton!
    @IBOutlet weak var row2Btn2: UIButton!
    @IBOutlet weak var row2Btn3: UIButton!
    
    @IBOutlet weak var row3Btn1: UIButton!
    @IBOutlet weak var row3Btn2: UIButton!
    @IBOutlet weak var row3Btn3: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initBoard()
        print(String(chosenGameMode))
        
        p2TurnLabel.transform = CGAffineTransform(rotationAngle: 3.14)
        p2TurnTextForFlip.transform = CGAffineTransform(rotationAngle: 3.14)
       
        if let player1NameFromStart = p1Name{
            p1TurnLabel.text = player1NameFromStart
        }
        if let player2NameFromStart = p2Name{
            p2TurnLabel.text = player2NameFromStart
        }
      
    }
    
    func initBoard(){
        board.append(row1Btn1)
        board.append(row1Btn2)
        board.append(row1Btn3)
        
        board.append(row2Btn1)
        board.append(row2Btn2)
        board.append(row2Btn3)
        
        board.append(row3Btn1)
        board.append(row3Btn2)
        board.append(row3Btn3)
    }

    @IBAction func buttonPress(_ sender: UIButton) {
        if chosenGameMode == 0{
            addToBoard(sender)
            
            if checkForWin(symbol: CROSS){
                p1Score += 1
                resultAlert(title: "\(p1Name ?? "X") Wins!")
            }
            if checkForWin(symbol: CIRCLE){
                p2Score += 1
                resultAlert(title: "\(p2Name ?? "O") Wins!")
            }
            
            if(fullBoard()){
                resultAlert(title: "Draw")
            }
        }
        else if chosenGameMode == 1{
            addToBoard(sender)
            randomAI()
            
            if checkForWin(symbol: CROSS){
                p1Score += 1
                resultAlert(title: "\(p1Name ?? "X") Wins!")
            }
            else if checkForWin(symbol: CIRCLE){
                p2Score += 1
                resultAlert(title: "\(p2Name ?? "O") Wins!")
            }
            else if(fullBoard()){
                resultAlert(title: "Draw")
            }
            
            
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
        for button in board{
            button.setTitle(nil, for: .normal)
            button.isEnabled = true
        }
        if chosenGameMode == 0{
            if firstTurn == Turn.Circle{
                firstTurn = Turn.Cross
                p1TurnLabel.text = p1Name
                p2TurnLabel.text = p1Name
            }else if firstTurn == Turn.Cross{
                firstTurn = Turn.Circle
                p1TurnLabel.text = p2Name
                p2TurnLabel.text = p2Name
            }
            currentTurn = firstTurn
        }else{
            firstTurn = Turn.Cross
            p1TurnLabel.text = p1Name
            p2TurnLabel.text = p1Name
            currentTurn = firstTurn
        }

    }
    func checkForWin (symbol : String) -> Bool{
        //horizontal
        if thisSymbol(button: row1Btn1, symbol: symbol) && thisSymbol(button: row1Btn2, symbol: symbol) && thisSymbol(button: row1Btn3, symbol: symbol){
            return true
        }
        else if thisSymbol(button: row2Btn1, symbol: symbol) && thisSymbol(button: row2Btn2, symbol: symbol) && thisSymbol(button: row2Btn3, symbol: symbol){
            return true
        }
        else if thisSymbol(button: row3Btn1, symbol: symbol) && thisSymbol(button: row3Btn2, symbol: symbol) && thisSymbol(button: row3Btn3, symbol: symbol){
            return true
        }
        //vertical
        else if thisSymbol(button: row1Btn1, symbol: symbol) && thisSymbol(button: row2Btn1, symbol: symbol) && thisSymbol(button: row3Btn1, symbol: symbol){
            return true
        }
        else if thisSymbol(button: row1Btn2, symbol: symbol) && thisSymbol(button: row2Btn2, symbol: symbol) && thisSymbol(button: row3Btn2, symbol: symbol){
            return true
        }
        else if thisSymbol(button: row1Btn3, symbol: symbol) && thisSymbol(button: row2Btn3, symbol: symbol) && thisSymbol(button: row3Btn3, symbol: symbol){
            return true
        }
        //diagonal
        else if thisSymbol(button: row1Btn1, symbol: symbol) && thisSymbol(button: row2Btn2, symbol: symbol) && thisSymbol(button: row3Btn3, symbol: symbol){
            return true
        }
        else if thisSymbol(button: row1Btn3, symbol: symbol) && thisSymbol(button: row2Btn2, symbol: symbol) && thisSymbol(button: row3Btn1, symbol: symbol){
            return true
        }
        
   
        return false
    }
    func thisSymbol(button : UIButton, symbol : String) -> Bool{
        if button.title(for: .normal) == symbol{
            return true
        }
        else {
            return false
        }
    }
    func fullBoard() -> Bool{
        for buttons in board
        {
            if buttons.title(for: .normal) == nil
            {
                return false
            }
        }
        return true
    }
    func addToBoard(_ sender: UIButton){
            if(sender.title(for: .normal) == nil){
                    if(currentTurn == Turn.Circle){
                        sender.setTitle(CIRCLE, for: .normal)
                        currentTurn = Turn.Cross
                        p1TurnLabel.text = p1Name
                        p2TurnLabel.text = p1Name
                    }else if(currentTurn == Turn.Cross){
                        sender.setTitle(CROSS, for: .normal)
                        currentTurn = Turn.Circle
                        p1TurnLabel.text = p2Name
                        p2TurnLabel.text = p2Name
                    }
                
            }else {
            
               
            }

        }
    
    func randomAI() {

        var listOfAvailableButtons = [UIButton]()
        
        for buttons in board{
            if buttons.title(for: .normal) == nil{
                listOfAvailableButtons.append(buttons)
            }
        }

        let random = listOfAvailableButtons.shuffled().first

        if listOfAvailableButtons.count > 0 {
            addToBoard(random!)
            listOfAvailableButtons.removeAll()
        }
        

        
       
        //Välj en "random" position i Board, ifall knappen har title = nil
        //kör addToBoard med aiButton, annars välj en ny random position.
        // Behöver fixa till addToBoard func så den exempelVis kollar ifall 1vsAI är true innan existerande IF satser
        //behöver möjligtvis en ny func lik addToBoard för AI gamemode
        //usedboard där alla knappar som blivit valda läggs till i, kolla om den random knappen finns där isåfall ta en ny random
        
    }
    
}

