//
//  ViewController.swift
//  SpotifyApp
//
//  Created by Yihang Sun on 4/16/21.
//

import UIKit
import FirebaseDatabase


class HomeViewController: UIViewController {

    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var InputUserName: UITextField!
    @IBOutlet weak var InputPassword: UITextField!
    @IBOutlet weak var lblPassword: UILabel!
    @IBOutlet weak var Login: UIButton!
    @IBOutlet weak var SignUp: UIButton!
    
    var ref = Database.database().reference()
    
    public var userData : ModelUser = SpotifyApp.ModelUser("", "")
    

    @IBOutlet weak var InputNewName: UITextField!
    @IBOutlet weak var InputNewPassword: UITextField!
    @IBOutlet weak var ButtonNewName: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        InputUserName.text = ""
        InputPassword.text = ""
    }

    @IBAction func LoginGetVal(_ sender: Any) {
        readVal(InputUserName.text!, InputPassword.text!)
        if (userVerify()) {
            print("Yes,it's user")
        }
    }
    @IBAction func AddUser(_ sender: Any) {
        readVal(InputNewName.text!, InputNewPassword.text!)
        let object: [String: Any] = [
                    "password": userData.password
                ]
        ref.child("User").child("\(userData.userName)").setValue(object)
    }
    
//    @IBAction func AddUserName(_ sender: Any) {
//        readVal(InputNewName.text!, InputNewPassword.text!)
//        let object: [String: Any] = [
//                    "password": userData.password
//                ]
//        ref.child("User").child("\(userData.userName)").setValue(object)
//        //        print(1)
////        self.ref.child("\(userData.userName)").getData { [self] (error, snapshot) in
////            for child in snapshot.children {
////                print("Child: \(child)")
////            }
////            while true {
////                readVal(InputNewName.text!, InputNewPassword.text!)
////                if let error = error {
////                    print("Error getting data \(error)")
////                }
////                else if snapshot.exists() {
////                    self.ButtonNewName.setTitle("User Name Existed.", for: .normal)
////                    userData.userName = ""
////                    InputNewName.text = ""
////                }
////                else {
////                    let object: [String: Any] = [
////                        "Password" : userData.password
////                    ]
////                    self.ref.child("\(self.userData.userName)").setValue(object)
////                    self.ButtonNewName.setTitle("Succeed", for: .normal)
////                    break
////                }
////            }
////        }
//
//    }
    
}

extension HomeViewController {
    func userVerify() -> Bool {
        let isUser = true
        ref.child("User").child("\(userData.userName)").child("Password").observeSingleEvent(of: .value, with: { snapshot in
            guard let value = snapshot.value as? [String: Any] else {
                return
            }
            print(value)
//            if (userData.password == value.){
//                print("Password is right")
//                isUser = true
//            }
        })
//        self.ref.child("User/\(userData.userName)").getData { (error, snapshot) in
//            if let error = error {
//                print("Error finding user \(error)")
//            }
//            else if snapshot.exists() {
//                print("Got data \(snapshot.value!)")
//            }
//            else {
//                print("No user data available")
//            }
//        }
        return isUser
    }

    func readVal(_ userNameText : String, _ passwordText : String) {
        userData.userName = userNameText
        userData.password = passwordText
    }
}

