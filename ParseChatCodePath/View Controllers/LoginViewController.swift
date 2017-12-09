//
//  LoginViewController.swift
//  ParseChatCodePath
//
//  Created by Malvern Madondo on 12/2/17.
//  Copyright © 2017 Malvern Madondo. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    

    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    let credentialsAlertController = UIAlertController(title: "Invalid Input", message: "Please enter username AND password", preferredStyle: .alert)
     let loginErrorAlertController = UIAlertController(title: "Login error", message: "There was problem during login.", preferredStyle: .alert)

    override func viewDidLoad() {
        super.viewDidLoad()
        usernameText.placeholder = "Username"
        passwordText.placeholder = "Password"
        // Do any additional setup after loading the view.
        
        // create an OK action
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
            
        }
        
        // add the OK action to the alert controller
        loginErrorAlertController.addAction(OKAction)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //Sign Up new user
    @IBAction func onSignUp(_ sender: Any) {
        
        // initialize a user object
        let newUser = PFUser()
        
        // set user properties
        newUser.username = usernameText.text
        newUser.password = passwordText.text
        
        if usernameText.text!.isEmpty || passwordText.text!.isEmpty{
          self.present(self.credentialsAlertController, animated: true)
            
        } else{
            // call sign up function on the object to sign up the user asynchronously and avoid duplicates
            newUser.signUpInBackground { (success: Bool, error: Error?) in
                if let error = error {
                      self.present(self.credentialsAlertController, animated: true)
                    print(error.localizedDescription)
                } else {
                    print("User Registered successfully")
                    // manually segue to logged in view
                    self.performSegue(withIdentifier: "loginSegue", sender: nil)
                }
            }
        }
    }
    
    //login returning user
    @IBAction func onLoginBtnPress(_ sender: Any) {
        let username = usernameText.text ?? ""
        let password = passwordText.text ?? ""
        /*
         Makes an asynchronous request to log in a user with specified credentials.
         *Returns an instance of the successfully logged in PFUser.
         *This also caches the user locally so that calls to PFUser.currentUser() will use the latest logged in user.
         *@param:  - username: The username of the user.
         - password: The password of the user.
         
         */
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
            if let error = error {
                print("User log in failed: \(error.localizedDescription)");
                self.present(self.loginErrorAlertController, animated: true);
                } else {
                
                print("User logged in successfully")
                // display view controller that needs to shown after successful login
                 self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        }
        
    }
    /*
        override func viewWillAppear(_ animated: Bool) {
        // check if user is logged in.
        if PFUser.current() != nil {
            // if there is a logged in user then load the home view controller
            print("Already Logged In!")
            self.performSegue(withIdentifier: "loginSegue", sender: nil)
        }
    } */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
