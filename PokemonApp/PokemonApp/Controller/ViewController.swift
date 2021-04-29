//
//  ViewController.swift
//  PokemonApp
//
//  Created by Yihang Sun on 4/22/21.
//

import UIKit
import FirebaseDatabase

class ViewController: UIViewController {
    
    // Home Page Variables
    @IBOutlet weak var headerPic: UIImageView!
    @IBOutlet weak var bodyPic: UIImageView!
    @IBOutlet weak var InputUserName: UITextField!
    @IBOutlet weak var InputPassword: UITextField!
    @IBOutlet weak var ButtonLogIn: UIButton!
    @IBOutlet weak var ButtonSignUp: UIButton!
    @IBOutlet weak var ButtonVerify: UIButton!
    @IBOutlet weak var lblVerifyResult: UILabel!
    
    // Sign Up Page Variables
    @IBOutlet weak var InputSignUpName: UITextField!
    @IBOutlet weak var InputSignUpPassword: UITextField!
    @IBOutlet weak var ButtonCreate: UIButton!
    @IBOutlet weak var lblSignUpMessage: UILabel!
    @IBOutlet weak var ButtonBack: UIButton!
    
    
    var ref = Database.database().reference()
    var handle : DatabaseHandle?
    public var userData : ModelUser = PokemonApp.ModelUser("", "", "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func verifyAccount(_ sender: Any) {
        readVal(InputUserName.text!, InputPassword.text!)
        let result = userVerify()
        if (result) {
            lblVerifyResult.text = "You're In!"
        } else {
            lblVerifyResult.text = "Can't Verify!"
            viewDidLoad()
        }
    }
    
    @IBAction func createAccount(_ sender: Any) {
        readVal(InputSignUpName.text!, InputSignUpPassword.text!)
        let result = userVerify()
        if (result) {
            database[userData.userName] = userData.password
            lblSignUpMessage.text = "User Existed and Password is Updated"
            viewDidLoad()
        } else {
            database[userData.userName] = userData.password
            print(database[userData.userName]!)
            ref.child("\(userData.userName)").setValue(["password" : userData.password])
            lblSignUpMessage.text = "You're All Set"
        }
    }
}

extension ViewController {
    func readVal(_ userNameText : String, _ passwordText : String) {
        userData.userName = userNameText
        userData.password = passwordText
    }
    
    func userVerify() -> Bool {
        var isUser = false
        
        for users in database.keys {
            if userData.userName == users {
                if userData.password == database[userData.userName]! {
                    isUser = true
                }
            }
        }
        
        guard ref.child("\(userData.userName)").key != nil else {
            return false
        }

        ref.child("\(userData.userName)").observeSingleEvent(of: .value, with: { (snapshot) in
            guard let value = snapshot.value as? String else {
                return
            }
            if (value == self.userData.password) {
                isUser = true
            }
        })
//        let refI = Database.database().reference().child("\(userData.userName)")
//
//        refI.observeSingleEvent(of: .childAdded, with: { (snapshot) in
//            print("IN")
//             if let userDict = snapshot.value as? [String:Any] {
//                  //Do not cast print it directly may be score is Int not string
//                print(userDict["password"]!)
//                isUser = true
//             }
//        })
        return isUser
    }
}
