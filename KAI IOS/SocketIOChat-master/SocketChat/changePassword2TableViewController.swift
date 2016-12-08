//
//  changePassword2TableViewController.swift
//  SocketChat
//
//  Created by Anthony Colas on 11/23/16.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import UIKit

class changePassword2TableViewController: UITableViewController {

    @IBOutlet weak var newPassword: UITextField!
    
    @IBOutlet weak var confirmNewPassword: UITextField!
    
    @IBOutlet weak var messageConfirm: UITextView!
    
    
    var sectionTwoRows = 0
    var dataReloaded = false
    var timer = NSTimer.init()

    override func viewDidLoad() {
        super.viewDidLoad()
       // timer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: "checkPass", userInfo: nil, repeats: true)
        self.navigationController!.navigationBar.topItem!.title = "";
       confirmNewPassword.addTarget(self, action:"checkPass", forControlEvents:UIControlEvents.EditingChanged)

        
        
       


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
            return 2
        } else if section == 1 {
            return sectionTwoRows
            
        }
        return 3
    }
    
    
    @IBAction func changePassword(sender: AnyObject) {
        PFUser.currentUser()!["password"] = confirmNewPassword.text
        messageConfirm.text = "Password Succesffuly Changed!"
        newPassword.text = ""
        confirmNewPassword.text = ""
        sectionTwoRows = 0
        
        }
    
    
    func checkPass(){
        
        if newPassword.text == confirmNewPassword.text && confirmNewPassword.text?.characters.count >= 5{
            sectionTwoRows = 1;
            dataReloaded = false
            self.tableView.reloadData()
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
