//
//  changePassword1TableViewController.swift
//  SocketChat
//
//  Created by Anthony Colas on 11/23/16.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import UIKit

class changePassword1TableViewController: UITableViewController {
   // var tField: UITextField!

    @IBOutlet weak var passwordMessage: UITextView!
    
    @IBOutlet weak var currentPassword: UITextField!
    
    @IBOutlet weak var confirmPassword: UITextField!
    

    
    var sectionTwoRows = 0
    var timer = NSTimer.init()
    var userName = PFUser.currentUser()!["username"] as? String
    var email = PFUser.currentUser()!["email"] as? String

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        confirmPassword.addTarget(self, action:"checkPass", forControlEvents:UIControlEvents.EditingChanged)
        self.navigationController!.navigationBar.topItem!.title = "";


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
        // #warning Inomplete implementation, return the number of rows
        
        if section == 0 {
            return 2
        } else if section == 1 {
            print("hello")
            return sectionTwoRows
            
        }
        return 0
    }
    
    //override func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
      //  return
    //}
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    
        switch(section)
        {
        case 0: return nil
            
        default :return nil
            
        }
        
    }
    
    
    @IBAction func confirmAciton(sender: AnyObject) {
        currentPassword.text = ""
        confirmPassword.text = ""
        sectionTwoRows = 0
        PFUser.requestPasswordResetForEmailInBackground(email!)
        passwordMessage.text = "A link has been sent to your email!"
    }
        
   /* @IBAction func forgotPassword(sender: AnyObject) {
        var email = ""
        
        
        var alert = UIAlertController(title: "Enter Email", message: "", preferredStyle: .Alert)
        
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
    
    func configurationTextField(textField: UITextField!)
    {
        print("generating the TextField")
        textField.placeholder = "Enter an item"
        tField = textField
    }
    
    func handleCancel(alertView: UIAlertAction!)
    {
        print("Cancelled !!")
    }*/
    
    func checkPass(){
       // print(currentPassword.text)
        //print(confirmPassword.text)
        let pass = currentPassword.text
        let confirm = confirmPassword.text
        
        if pass == confirm {
            PFUser.logInWithUsernameInBackground(userName!, password: confirm!) { (user, error) -> Void in
                if error == nil {
                    self.sectionTwoRows = 1
                    self.tableView.reloadData()
                    print("succesful")
                } else {
                   print("error")
                }
            }
        }
    
        else{
            sectionTwoRows = 0
        }
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


