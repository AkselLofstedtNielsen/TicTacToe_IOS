//
//  ViewController.swift
//  TicTacToe
//
//  Created by Aksel Nielsen on 2022-11-29.
//

import UIKit

class ViewController: UIViewController {
    
    enum Turn{
        case Circle
        case Cross
    }
    var firstTurn = Turn.Cross
    var currentTurn = Turn.Cross
    
    var CIRCLE = "O"
    var CROSS = "X"

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
        p2TurnLabel.transform = CGAffineTransform(rotationAngle: 3.14)
        p2TurnTextForFlip.transform = CGAffineTransform(rotationAngle: 3.14)
    }

    @IBAction func buttonPress(_ sender: UIButton) {
        addToBoard(sender)
        
    }
    func addToBoard(_ sender: UIButton){
        if(sender.title(for: .normal) == nil){
            if(currentTurn == Turn.Circle){
                sender.setTitle(CIRCLE, for: .normal)
                currentTurn = Turn.Cross
                p1TurnLabel.text = CROSS
                p2TurnLabel.text = CROSS
            }else if(currentTurn == Turn.Cross){
                sender.setTitle(CROSS, for: .normal)
                currentTurn = Turn.Circle
                p1TurnLabel.text = CIRCLE
                p2TurnLabel.text = CIRCLE
            }
        }
    }
    
}

