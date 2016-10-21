//
//  ControlsTableViewController.swift
//  SocketChat
//
//  Created by Anthony Colas on 8/31/16.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import UIKit

class ControlsTableViewController: UITableViewController{
    
    @IBOutlet weak var doorUISwitch: UISwitch!
    @IBOutlet weak var lightUISwitch: UISwitch!
    @IBOutlet weak var coffeeUISwitch: UISwitch!
    @IBOutlet weak var windUISwitch: UISwitch!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    @IBAction func connect(sender: AnyObject) {
        SocketIOManager.sharedInstance.connectToServer()
    }
    
    var feedModelArray = [MyCustomTableViewCellModel]()
    
    
    var users = [[String: AnyObject]]()
    
    var nickname: String!
    
    var configurationOK = false
    


    override func viewDidLoad() {
        super.viewDidLoad()
        if revealViewController() != nil{
            print("hello")
            
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
            
        }
        
        
        self.navigationController?.setToolbarHidden(false, animated: true)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "handleDeviceStatus:", name: "deviceStatus", object: nil)
        print("viewDidLoad")
        
      
        
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        SocketIOManager.sharedInstance.connectToServer()
        

    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated);
        self.navigationController?.setToolbarHidden(true, animated: animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }

    
    func handleDeviceStatus(notification: NSNotification){
        print("handleDeviceStatus")
        
        if let objectSwitched = notification.object as? [String: AnyObject]{
            print(objectSwitched)
            let id = objectSwitched["id"] as! String
            let status = objectSwitched["status"] as! Bool
            print(status)
           
            // let status = dataArray[0]["status"] as! String
            SocketIOManager.sharedInstance.switchDevice(id)
            socketSwitchReceived(id, status: status)
            
        }
        
    }
    
    func socketSwitchReceived(id : String, status: Bool){
        switch id{
        
        case "#door":
            doorUISwitch.setOn(status, animated: true)
            print(id)
            
        case "#light":
            lightUISwitch.setOn(status, animated: true)
            print(id)

        case "#coffee":
            coffeeUISwitch.setOn(status, animated: true)
            print(id)

        case "#wind":
            windUISwitch.setOn(status, animated: true)
            print(id)

        default:
            print("error")
            
        }
    
    }
    
    @IBAction func doorSwitched(sender: UISwitch) {
        SocketIOManager.sharedInstance.chooseDevice("#door")
        print("door")
        
    }
    
    
    @IBAction func lightSwitch(sender: UISwitch) {
        SocketIOManager.sharedInstance.chooseDevice("#light")
        print("light")
    }
    
    
    @IBAction func coffeeSwitch(sender: UISwitch) {
        SocketIOManager.sharedInstance.chooseDevice("#coffee")
        print("coffee")
    }
    
    
    
    @IBAction func windowSwitch(sender: UISwitch) {
        SocketIOManager.sharedInstance.chooseDevice("#wind")
        print("window")
    }

    @IBAction func logout(sender: AnyObject) {
        let alert = UIAlertController(title: "Are You Sure You Want To Log Out?", message: "", preferredStyle: UIAlertControllerStyle.Alert)
        
      
        alert.addAction(UIAlertAction(title: "Log Out", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
            
            
           PFUser.logOut()
            
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
            if action == true {
                self.dismissViewControllerAnimated(false, completion: nil)
            }}))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
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
