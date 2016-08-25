//
//  ViewController.swift
//  AppBeta
//
//  Created by Khoi Nguyen on 8/24/16.
//  Copyright © 2016 Khoi Nguyen. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit
import FBSDKCoreKit



class SignInVC: UIViewController {

    @IBOutlet weak var emailField: Fancyfield!
    @IBOutlet weak var pwdField: Fancyfield!
    
    var SegueIscalled = false
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.HideKeyboardWhenTapGesture()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDefaults.standard.value(forKey: KEY_UID) != nil {
            self.ChangeScreen()
        }
    }
    
    func HideKeyboardWhenTapGesture() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func FacebookAuth(_ sender: AnyObject) {
        let facebookLogin = FBSDKLoginManager()
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            
            if error != nil {
                self.showErrorAlert(title: "Opps", msg: "Unable to anthenticate with Facebook")
            } else if (result?.isCancelled)! {
                self.showErrorAlert(title: "Sorry", msg: "User cancelled Facebook authenticatetion")
            } else {
                self.showErrorAlert(title: "Sucessfully authenticate with Facebook", msg: "Welcome to social app !!!")
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.authenticateWithFirebase(credential)
                
            }
            
            
            
        }
        
        
    }
    
    func authenticateWithFirebase(_ credential: FIRAuthCredential) {
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            if error != nil {
                UserDefaults.standard.setValue(user?.uid, forKey: KEY_UID)
                self.showErrorAlert(title: "Oops", msg: "Unable to authenticate with our server!!!")
            } else {
                self.showErrorAlert(title: "Thank you", msg: "Sucessfully authenticate with our server !!!")
            }
        })
    }
    
    
    @IBAction func FirebaseAuth(_ sender: AnyObject) {
        
        if let email = emailField.text , email != "", let pwd = pwdField.text , pwd != "" {
            FIRAuth.auth()?.signIn(withEmail: email, password: pwd, completion: { (user, error) in
                if error == nil {
                    UserDefaults.standard.setValue(user?.uid, forKey: KEY_UID)
                    self.ChangeScreen()
                    //print("abcd")
                    
                } else {
                    
                    FIRAuth.auth()?.createUser(withEmail: email, password: pwd, completion: { (user, error) in
                        if error != nil {
                            self.showErrorAlert(title: "Cannot sign in or sign up", msg: "Please double check your email and password again or try alternative ways")
                        } else {
                            //self.showErrorAlert(title: "Sign up Successfully", msg: "Welcome to social app")
                            UserDefaults.standard.setValue(user?.uid, forKey: KEY_UID)
                            
                            self.ChangeScreen()
                            
                        }
                    })
                    
                }
            })
        } else {
            showErrorAlert(title: "Please fill correct email and password", msg: "You need to have a valid email or password to sign in or sign up for this app !!!")
        }
        
    }

    func showErrorAlert(title: String, msg: String) {
        
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
        
        
    }
    func ChangeScreen() {
        self.performSegue(withIdentifier: SEGUE_INDENTIFIER, sender: nil)
    }
    
    
}

