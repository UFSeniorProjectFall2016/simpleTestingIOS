//
//  SidebarTableViewController.swift
//  SocketChat
//
//  Created by Anthony Colas on 10/3/16.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import UIKit

class SidebarTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        
        print(indexPath.row)
        if indexPath.row == 2 {
            
            
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
                
                let destinationController = self.storyboard?.instantiateViewControllerWithIdentifier("CustomLoginViewController") as! CustomLoginViewController
                
                let navigationController = UINavigationController(rootViewController: destinationController)
                
                sw.revealViewController()
            }
            
            logoutActionSheet.addAction(logoutActionSheetButton)
            logoutActionSheet.addAction(cancelActionSheetButton)
            
            self.presentViewController(logoutActionSheet, animated: true, completion:nil)
          
            
            
          
            
        }
    }
    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    

}
