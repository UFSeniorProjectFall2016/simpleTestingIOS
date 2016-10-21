//
//  ViewController.swift
//  SocketChat
//
//  Created by Anthony Colas on 9/20/16.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import UIKit

class ViewController: UIViewController, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate {

    var logInViewController: PFLogInViewController! = PFLogInViewController()
    var signUpViewController: PFSignUpViewController! = PFSignUpViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if(PFUser.currentUser() == nil){
            self.logInViewController.fields = [.UsernameAndPassword, .LogInButton, .SignUpButton, .PasswordForgotten, .DismissButton]
            
            
            let logInLogoTitle = UILabel()
            logInLogoTitle.text = "KAI"
            
            self.logInViewController.logInView?.logo = logInLogoTitle
            self.logInViewController.delegate = self
            
            let signUpLogoTitle = UILabel()
            signUpLogoTitle.text = "KAI"
            
            self.signUpViewController.signUpView?.logo = signUpLogoTitle
            self.signUpViewController.delegate = self
            
            self.logInViewController.signUpController = self.signUpViewController
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Parse Login
    
    
    func logInViewController(logInController: PFLogInViewController, shouldBeginLogInWithUsername username: String, password: String) -> Bool {
        if(!username.isEmpty || !password.isEmpty){
            return true
        }
        else{
            return false
        }
    }
    
    
    func logInViewController(logInController: PFLogInViewController, didLogInUser user: PFUser) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func logInViewController(logInController: PFLogInViewController, didFailToLogInWithError error: NSError?) {
        print("Failed to login")
    }
    //MARK: Parse Sign Up

    
    func signUpViewController(signUpController: PFSignUpViewController, didSignUpUser user: PFUser) {
        print("signedup")
        self.performSegueWithIdentifier("mainmenu", sender: self)
    }
    
    
    func signUpViewController(signUpController: PFSignUpViewController, didFailToSignUpWithError error: NSError?) {
        print("Failed to sign up")
    }
    
    func signUpViewControllerDidCancelSignUp(signUpController: PFSignUpViewController) {
        print("User dismissed sign up")
    }
    
    //MARK: Actions
    
    @IBAction func simpleAction(sender: AnyObject){
        self.presentViewController(self.logInViewController, animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
