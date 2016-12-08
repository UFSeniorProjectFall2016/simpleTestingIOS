//
//  SidebarTableViewController.swift
//  SocketChat
//
//  Created by Anthony Colas on 10/3/16.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import UIKit
import MessageUI

class SidebarTableViewController: UITableViewController, MFMailComposeViewControllerDelegate {

    
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var name: UILabel!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        if let displayFirst = PFUser.currentUser()!["firstname"] as? String{
            if let displayLast = PFUser.currentUser()!["lastname"] as? String{
                name.text = displayFirst + " " + displayLast
            }
            
            
        }

        if let displayEmail = PFUser.currentUser()!["email"] as? String{
            email.text = displayEmail
        }
        
        let userPicture = PFUser.currentUser()?["profilepicture"] as? PFFile
            userPicture!.getDataInBackgroundWithBlock { (imageData: NSData?, error: NSError?) -> Void in
                if (error == nil) {
                    let image = UIImage(data: imageData!)
                    self.profilePic.image = image
                }
            
        }
        
        profilePic.setRounded()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewDidAppear(animated: Bool) {
        if let displayFirst = PFUser.currentUser()!["firstname"] as? String{
            if let displayLast = PFUser.currentUser()!["lastname"] as? String{
                name.text = displayFirst + " " + displayLast
            }
            
            
        }
        
        if let displayEmail = PFUser.currentUser()!["email"] as? String{
            email.text = displayEmail
        }
        
        let userPicture = PFUser.currentUser()?["profilepicture"] as? PFFile
        userPicture!.getDataInBackgroundWithBlock { (imageData: NSData?, error: NSError?) -> Void in
            if (error == nil) {
                let image = UIImage(data: imageData!)
                self.profilePic.image = image
            }
            
        }
        
        profilePic.setRounded()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        
        print(indexPath.row)
        if indexPath.row == 4{
            let mailComposeViewController = configuredMailComposeViewController()
            if MFMailComposeViewController.canSendMail() {
                self.presentViewController(mailComposeViewController, animated: true, completion: nil)
            } else {
                self.showSendMailErrorAlert()
            }
        }
        if indexPath.row == 5 {
            
            
            let cancelActionSheetButton = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) {
                (cancelSelected) -> Void in
                print("Cancel Selected")
            }
            
            let logoutActionSheet = UIAlertController(title:"Logout", message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
            
            let logoutActionSheetButton = UIAlertAction(title: "Logout from App", style: UIAlertActionStyle.Destructive) {
                (logoutSelected) -> Void in
                 PFUser.logOut()
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                
                let sw = storyboard.instantiateViewControllerWithIdentifier("CustomLoginViewController") as! CustomLoginViewController
                
                self.view.window?.rootViewController = sw
                
              //  let destinationController = self.storyboard?.instantiateViewControllerWithIdentifier("CustomLoginViewController") as! CustomLoginViewController
                
            // let navigationController = UINavigationController(rootViewController: destinationController)
                
                sw.revealViewController()
            }
            
            logoutActionSheet.addAction(logoutActionSheetButton)
            logoutActionSheet.addAction(cancelActionSheetButton)
            
            self.presentViewController(logoutActionSheet, animated: true, completion:nil)
  
        }
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        
        mailComposerVC.setToRecipients(["kaismarthome@gmail.com"])
        mailComposerVC.setSubject("KAI Feedback")
        mailComposerVC.setMessageBody("Greetings Kai,\n", isHTML: false)
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertView(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", delegate: self, cancelButtonTitle: "OK")
        sendMailErrorAlert.show()
    }
    
    // MARK: MFMailComposeViewControllerDelegate
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        controller.dismissViewControllerAnimated(true, completion: nil)
        
    }
    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    

}
