//
//  customSignupViewController.swift
//  SocketChat
//
//  Created by Anthony Colas on 9/23/16.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import UIKit
import Parse

extension UIImageView {
    
    func setRounded() {
        let radius = CGRectGetWidth(self.frame) / 2
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
}

class customSignupViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imagePicked: UIImageView!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var firstField: UITextField!
    @IBOutlet weak var lastField: UITextField!
    
    var actInd: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0, 0, 150, 150)) as UIActivityIndicatorView
    
    var locationManager = CLLocationManager()
   
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.actInd.center = self.view.center
        self.actInd.hidesWhenStopped = true
        self.actInd.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        
        view.addSubview(self.actInd)
        imagePicked.setRounded()
       
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func processSignOut() {
        
        // // Sign out
        PFUser.logOut()
        
        // Display sign in / up view controller
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("CustomLoginViewController")
        self.presentViewController(vc, animated: true, completion: nil)
    }

    @IBAction func backButton(sender: AnyObject) {
        self.performSegueWithIdentifier("signup", sender: self)

        
    }
    
    @IBAction func uploadPicture(sender: AnyObject) {
        let ImagePicker = UIImagePickerController()
        ImagePicker.delegate = self
        ImagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        ImagePicker.allowsEditing = true
        self.presentViewController(ImagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        imagePicked.image = image
        self.dismissViewControllerAnimated(true, completion: nil);
    }
    
    @IBAction func signupAction(sender: AnyObject) {
        let upcomingImage = self.imagePicked.image
        let imgData = UIImagePNGRepresentation(upcomingImage!)!
        let file: PFFile = PFFile(data: imgData)!
       // var lat = 123
        //var lon = 123
        //lat = locationManager.location!.coordinate.latitude
        //lon = locationManager.location!.coordinate.longitude

        let username = self.usernameField.text
        let password = self.passwordField.text
        let email = self.emailField.text
        let first = self.firstField.text
        let last = self.lastField.text
   
       // let myGeoPoint = PFGeoPoint(latitude: lat, longitude:lon)

        
        
        
        
        if(username?.characters.count < 4 || password?.characters.count < 5){
            let alert = UIAlertView(title: "Invalid", message: "Username must be greater than 4 and Password must be greater than 5.", delegate: self, cancelButtonTitle: "OK")
            alert.show()
            
        }else if(!isValidEmail(email!)){
            let alert = UIAlertView(title: "Invalid", message: "Please enter a valid email.", delegate: self, cancelButtonTitle: "OK")
            alert.show()
        }else if(first == "" || last == ""){
            let alert = UIAlertView(title: "Invalid", message: "Please enter a full name.", delegate: self, cancelButtonTitle: "OK")
            alert.show()
        }else{
            
            
            self.actInd.startAnimating()
            
            let newUser = PFUser()
            
            newUser.username = username?.lowercaseString
            newUser.password = password?.lowercaseString
            newUser.email = email?.lowercaseString
            newUser["firstname"] = first?.lowercaseString
            newUser["lastname"] = last?.lowercaseString
            newUser["profilepicture"] = file
           // newUser["homeAddress"] = myGeoPoint
            

            
            
            
            
            newUser.signUpInBackgroundWithBlock({ (succeed, error) -> Void in
                
                self.actInd.stopAnimating()
                
                if((error) == nil){
                    //User needs to verify email address before continuing
                    let alertController = UIAlertController(title: "Email address verification",
                        message: "We have sent you an email that contains a link - you must click this link before you can continue.",
                        preferredStyle: UIAlertControllerStyle.Alert
                    )
                    alertController.addAction(UIAlertAction(title: "OKAY",
                        style: UIAlertActionStyle.Default,
                        handler: {alertController in self.processSignOut()})
                    )
                    // Display alert
                    self.presentViewController(alertController, animated: true, completion: nil)
                    
                    
                    
                    
                    
                    
                    
                }else{
                    let alert = UIAlertView(title: "Error", message: "\(error)", delegate: self, cancelButtonTitle: "OK")
                    alert.show()
                    
                }
            })
            
        }

        
        }
    
    
  
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func isValidEmail(testStr:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluateWithObject(testStr)
    }

}
