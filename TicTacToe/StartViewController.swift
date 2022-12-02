//
//  StartViewController.swift
//  TicTacToe
//
//  Created by Aksel Nielsen on 2022-12-01.
//

import UIKit

class StartViewController: UIViewController {
    let segueToGame = "segueFromStartToGame"

    @IBOutlet weak var segmentControllOutlet: UISegmentedControl!
    
    var gameMode = 0
    
    @IBOutlet weak var player1NameTextField: UITextField!
    var player1 = ""
    
    @IBOutlet weak var player2NameTextField: UITextField!
    var player2 = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation

    @IBAction func segmentClick(_ sender: Any) {
        switch segmentControllOutlet.selectedSegmentIndex{
        case 0:
            gameMode = 0
        case 1:
            gameMode = 1
        case 2:
            gameMode = 2
        default:
            break
        }
    }
    
    @IBAction func playBtn(_ sender: UIButton) {
        player1 = player1NameTextField.text ?? "Y"
        player2 = player2NameTextField.text ?? "Y"
        performSegue(withIdentifier: segueToGame, sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueToGame{
            let destinationVC = segue.destination as? ViewController
            destinationVC?.p1Name = player1
            destinationVC?.p2Name = player2
            destinationVC?.chosenGameMode = gameMode
        
        }
    }

    
        
    }


       
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    
   


