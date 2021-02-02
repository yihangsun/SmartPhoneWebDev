//
//  ViewController.swift
//  NameApp
//
//  Created by Yihang Sun on 2/1/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var showingText: UILabel!
    
    @IBOutlet weak var clickMeButton: UIButton!
    
    var isClicked = 1;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func clickMeAction(_ sender: UIButton) {
        if (isClicked == 0) {
            showingText.text = "Click to see my name"
        } else if (isClicked == 1) {
            showingText.text = "First Name: Yihang"
            clickMeButton.setTitle("Click Me Again", for: .normal)
        } else {
            showingText.text = "Last Name: Sun"
            clickMeButton.setTitle("Click Me", for: .normal)
        }
        isClicked += 1
        if (isClicked == 3) {
            isClicked = 0
        }
    }

}

