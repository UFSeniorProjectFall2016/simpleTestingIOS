//
//  SettingsTableViewController.swift
//  SocketChat
//
//  Created by Anthony Colas on 11/19/16.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var firstName: UITextField!
    
    @IBOutlet weak var lastName: UITextField!

    @IBOutlet weak var emailField: UITextField!

    @IBOutlet weak var userField: UITextField!
    
    @IBOutlet weak var imageField: UIImageView!
    var user = PFUser.currentUser()!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        self.view.backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1.0)
        self.navigationController!.navigationBar.topItem!.title = "";

        
        if let displayFirst = PFUser.currentUser()!["firstname"] as? String{
            if let displayLast = PFUser.currentUser()!["lastname"] as? String{
                firstName.text = displayFirst
                lastName.text = displayLast
            }
    
        }
        
        if let displayEmail = PFUser.currentUser()!["email"] as? String{
            emailField.text = displayEmail
        }
        
        if let displayUser = PFUser.currentUser()!["username"] as? String{
            userField.text = displayUser
        }
        
        
        
        let userPicture = PFUser.currentUser()?["profilepicture"] as? PFFile
        userPicture!.getDataInBackgroundWithBlock { (imageData: NSData?, error: NSError?) -> Void in
            if (error == nil) {
                let image = UIImage(data: imageData!)
                self.imageField.image = image
            }
            
        }
        
     
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            return 4
        } else if section == 1 {
            return 1
            
        }
        return 4
    }
    
    @IBAction func editName(sender: AnyObject) {
        let first = firstName.text
      
       
        if(first != ""){
        user["firstname"] = first?.lowercaseString
        user.saveInBackground()
        }else{
            let alert = UIAlertView(title: "Invalid", message: "Please enter a full name.", delegate: self, cancelButtonTitle: "OK")
            alert.show()
        }
    }
    
    @IBAction func editLast(sender: AnyObject) {
        let last = lastName.text
        if(last != ""){
        PFUser.currentUser()!["lastname"] = last?.lowercaseString
        user.saveInBackground()
        }else{
            let alert = UIAlertView(title: "Invalid", message: "Please enter a full name.", delegate: self, cancelButtonTitle: "OK")
            alert.show()
            
        }

    }

    @IBAction func editEmail(sender: AnyObject) {
        let email = emailField.text
        if(isValidEmail(email!)){
        PFUser.currentUser()!["email"] = email?.lowercaseString
        user.saveInBackground()
        }else{
            let alert = UIAlertView(title: "Invalid", message: "Please enter a valid email.", delegate: self, cancelButtonTitle: "OK")
            alert.show()

            
        }

    }
    
    @IBAction func editUser(sender: AnyObject) {
        let username = userField.text
        let query = PFQuery(className: "_User")
        query.whereKey("username", equalTo: username!)
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil || username != "" {
                if (objects!.count > 0){
                    let alert = UIAlertView(title: "Invalid", message: "Username is already taken.", delegate: self, cancelButtonTitle: "OK")
                    alert.show()
                    
                } else{
                    PFUser.currentUser()!["username"] = username?.lowercaseString
                    self.user.saveInBackground()
                }
            } else {
                let alert = UIAlertView(title: "Error", message: "Invalid username)", delegate: self, cancelButtonTitle: "OK")
                alert.show()
                
            }
        }

    }
    
    @IBAction func editPicture(sender: AnyObject) {
        let ImagePicker = UIImagePickerController()
        ImagePicker.delegate = self
        ImagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        ImagePicker.allowsEditing = true
        self.presentViewController(ImagePicker, animated: true, completion: nil)

    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        imageField.image = image
        self.dismissViewControllerAnimated(true, completion: nil);
        let upcomingImage = self.imageField.image
        let imgData = UIImagePNGRepresentation(upcomingImage!)!
        print("exit")
        let file: PFFile = PFFile(data: imgData)!
        user["profilepicture"] = file
        user.saveInBackground()
    }
    
    func isValidEmail(testStr:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluateWithObject(testStr)
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
