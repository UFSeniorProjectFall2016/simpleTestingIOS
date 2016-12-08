//
//  CustomLoginViewController.swift
//  SocketChat
//
//  Created by Anthony Colas on 9/23/16.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import UIKit
import Parse

class CustomLoginViewController: UIViewController {
var tField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    var actInd: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0, 0, 150, 150)) as UIActivityIndicatorView
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.actInd.center = self.view.center
        self.actInd.hidesWhenStopped = true
        self.actInd.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        
        view.addSubview(self.actInd)
    }
    
    override func viewDidAppear(animated: Bool) {
        //[self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"home.png"]];
    }
    
    override func shouldAutorotate() -> Bool {
        if (UIDevice.currentDevice().orientation == UIDeviceOrientation.LandscapeLeft ||
            UIDevice.currentDevice().orientation == UIDeviceOrientation.LandscapeRight ||
            UIDevice.currentDevice().orientation == UIDeviceOrientation.Unknown) {
                return false
        }
        else {
            return true
        }
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return [UIInterfaceOrientationMask.Portrait ,UIInterfaceOrientationMask.PortraitUpsideDown]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configurationTextField(textField: UITextField!)
    {
        print("generating the TextField")
        textField.placeholder = "Enter an item"
        tField = textField
    }
    
    func handleCancel(alertView: UIAlertAction!)
    {
        print("Cancelled !!")
    }
    
    @IBAction func loginAction(sender: AnyObject) {
        
        
        let username = self.usernameField.text
        let password = self.passwordField.text
        
        
        if(username?.characters.count < 4 || password?.characters.count < 5){
            let alert = UIAlertView(title: "Invalid", message: "Username must be greater than 4 and Password must be greater than 5.", delegate: self, cancelButtonTitle: "OK")
            alert.show()
            
        }else{
            self.actInd.startAnimating()
            PFUser.logInWithUsernameInBackground(username!, password: password!, block: { (user, error) ->
                Void in
                
                
                
                self.actInd.stopAnimating()
                
                if error == nil {
                    print("Logged in Successfully")
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    
                    let sw = storyboard.instantiateViewControllerWithIdentifier("SWRevealViewController") as! SWRevealViewController
                    
                    self.view.window?.rootViewController = sw
                    
                    let destinationController = self.storyboard?.instantiateViewControllerWithIdentifier("StoryboardID") as! SWRevealViewController
                    
                    let navigationController = UINavigationController(rootViewController: destinationController)
                    
                    sw.pushFrontViewController(navigationController, animated: true)
                    
                    
                    
                    
                }
                
              else{
                   
                    let alert = UIAlertView(title: "Error", message: "\(error)", delegate: self, cancelButtonTitle: "OK")
                    alert.show()
                    
                }
                
                
            })
            
            
        }
    }

    @IBAction func signupAction(sender: AnyObject) {
        self.performSegueWithIdentifier("signup", sender: self)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func forgotpasswordAction(sender: AnyObject) {
        var email = ""
        
        
        let alert = UIAlertController(title: "Enter Email", message: "", preferredStyle: .Alert)
        
        alert.addTextFieldWithConfigurationHandler(configurationTextField)
        alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler:handleCancel))
        alert.addAction(UIAlertAction(title: "Send", style: .Default, handler:{ (UIAlertAction) in
            print("Done !!")
            
            print("Item : \(self.tField.text)")
            email = self.tField.text!
            PFUser.requestPasswordResetForEmailInBackground(email)
           

        }))
        self.presentViewController(alert, animated: true, completion: {
            print("completion block")
        })

    }
}
