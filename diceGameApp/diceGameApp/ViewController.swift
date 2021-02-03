//
//  ViewController.swift
//  diceGameApp
//
//  Created by Yihang Sun on 2/2/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var Dice1: UIImageView!
    @IBOutlet weak var Dice2: UIImageView!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    let imageArray = ["Dice1", "Dice2", "Dice3", "Dice4", "Dice5", "Dice6"]
    var balance = 15
    var diceNum1 = 0
    var diceNum2 = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changeImage()
        resultLabel.text = "Let's Begin!"
        balanceLabel.text = "Your Balance: $\(balance)"
        
    }
    func changeImage() {
        diceNum1 = Int.random(in: 0...5)
        diceNum2 = Int.random(in: 0...5)
        Dice1.image = UIImage(named: imageArray[diceNum1])
        Dice2.image = UIImage(named: imageArray[diceNum2])
    }
    
    @IBAction func playDice(_ sender: UIButton) {
        changeImage()
        let sum = diceNum1 + diceNum2 + 2
        if (sum == 7) {
            balance = balance + 3
            resultLabel.text = "You won $3!"
        } else if (sum < 7) {
            balance = balance - 1
            resultLabel.text = "You lost $1!"
        } else {
            balance = balance + 1
            resultLabel.text = "You won $1!"
        }
        balanceLabel.text = "Your Balance: $\(balance)"
    }
    
}

