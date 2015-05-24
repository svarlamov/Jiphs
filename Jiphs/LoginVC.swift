//
//  LoginVC.Swift
//  Jiphs
//
//  Created by Stefan DeClerck on 5/23/15.
//  Copyright (c) 2015 Stefandeclerck. All rights reserved.
//

import UIKit
import Parse

class LoginVC: UIViewController, UITextFieldDelegate {
    
    //login
    @IBOutlet weak var loginUsername: UITextField!
    @IBOutlet weak var loginPassword: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var dontHaveLabel: UILabel!
    @IBOutlet weak var decideToSignUp: UIButton!
    
    //Sign Up
    @IBOutlet weak var signUpUsername: UITextField!
    @IBOutlet weak var signUpEmail: UITextField!
    @IBOutlet weak var signUpPassword: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var alreadyHaveLabel: UILabel!
    @IBOutlet weak var decideToLogin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIView.animateWithDuration(0.1, animations: {
             
        })
        
        loginUsername.delegate = self
        loginPassword.delegate = self
        signUpUsername.delegate = self
        signUpPassword.delegate = self
        signUpEmail.delegate = self
        
        //Login
        dontHaveLabel.hidden = false
        loginButton.hidden = false
        loginPassword.hidden = false
        loginUsername.hidden = false
        decideToSignUp.hidden = false
        
        //Sign Up
        signUpUsername.hidden = true
        signUpEmail.hidden = true
        signUpPassword.hidden = true
        signUpButton.hidden = true
        alreadyHaveLabel.hidden = true
        decideToLogin.hidden = true
        
    }
    
    @IBAction func signUp(sender: AnyObject) {
        var user = PFUser()
        user.username = signUpUsername.text
        user.password = signUpPassword.text
        user.email = signUpEmail.text
        
        user.signUpInBackgroundWithBlock {
            (succeeded: Bool, error: NSError?) -> Void in
            if let error = error {
                let errorString = error.userInfo?["error"] as? NSString
                let alertController = UIAlertController(title: "Alert", message:
                    "\(errorString)", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.Default,handler: nil))
                
                self.presentViewController(alertController, animated: true, completion: nil)
            } else {
                println("success")
                self.performSegueWithIdentifier("beginningS", sender:self)
                
            }
        }
    }
    
    @IBAction func login(sender: AnyObject) {
        PFUser.logInWithUsernameInBackground(loginUsername.text, password:loginPassword.text) {
            (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
                println("success")
                self.performSegueWithIdentifier("beginningS", sender:self)
            } else if let error = error {
                let errorString = error.userInfo?["error"] as? NSString
                let alertController = UIAlertController(title: "Alert", message:
                    "\(errorString)", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.Default,handler: nil))
                
                self.presentViewController(alertController, animated: true, completion: nil)
            }
        }
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        self.view.endEditing(true)
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        self.view.endEditing(true)
        
        return true
        
    }
    @IBAction func showSUItems(sender: AnyObject) {
        //Login
        dontHaveLabel.hidden = true
        loginButton.hidden = true
        loginPassword.hidden = true
        loginUsername.hidden = true
        decideToSignUp.hidden = true
        
        //Sign Up
        signUpUsername.hidden = false
        signUpEmail.hidden = false
        signUpPassword.hidden = false
        signUpButton.hidden = false
        alreadyHaveLabel.hidden = false
        decideToLogin.hidden = false
    }
    
    @IBAction func showLoginItems(sender: AnyObject) {
        //Login
        dontHaveLabel.hidden = false
        loginButton.hidden = false
        loginPassword.hidden = false
        loginUsername.hidden = false
        decideToSignUp.hidden = false
        
        //Sign Up
        signUpUsername.hidden = true
        signUpEmail.hidden = true
        signUpPassword.hidden = true
        signUpButton.hidden = true
        alreadyHaveLabel.hidden = true
        decideToLogin.hidden = true
    }
    
    
    
    
    
}