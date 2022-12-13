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
    @IBOutlet weak var player2NameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
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
        performSegue(withIdentifier: segueToGame, sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueToGame{
            let destinationVC = segue.destination as? ViewController
            destinationVC?.p1Name = player1NameTextField.text
            destinationVC?.p2Name = player2NameTextField.text
            destinationVC?.gameMode = gameMode
        }
    }
    
    @IBAction func unwindToStartView(segue: UIStoryboardSegue){
        
    }
    
    @IBAction func dismissKeyboard(_ sender: Any) {
        view.endEditing(true)
    }
}






