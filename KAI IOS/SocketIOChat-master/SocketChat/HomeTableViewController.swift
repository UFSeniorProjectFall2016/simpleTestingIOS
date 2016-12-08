//
//  HomeTableViewController.swift
//  SocketChat
//
//  Created by Anthony Colas on 11/24/16.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import UIKit


var message = ""; 
class HomeTableViewController: UITableViewController {
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    @IBOutlet weak var timeImage: UIImageView!
    
    @IBOutlet weak var temperature: UILabel!
    
    @IBOutlet weak var deviceOnLabel: UILabel!
    
    @IBOutlet weak var deviceOffLabel: UILabel!
    
    @IBOutlet weak var deviceNotification1: UILabel!
    
    
    @IBOutlet weak var deviceNotification2: UILabel!
    
    @IBOutlet weak var deviceNotification3: UILabel!
    
    @IBOutlet weak var deviceNotification4: UILabel!
    @IBOutlet weak var humidity: UILabel!
    @IBOutlet weak var lighting: UILabel!

    @IBOutlet weak var timeLabel: UILabel!
    
    var user = PFUser.currentUser()!
    let first = PFUser.currentUser()!["firstname"] as? String
   

    var day = UIImage(named:"sunrisesky.jpg")
    var day2 = UIImage(named:"daysky.jpg")
    var sunset = UIImage(named: "sunsetsky.jpeg")
    var nightsky = UIImage(named: "nightsky.jpg")
    

    @IBOutlet weak var mostRecentlyUsed: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 250/255.0, green: 250/255.0, blue: 250/255.0, alpha: 1.0)
       
        
        NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: ("changePic"), userInfo: nil, repeats: true)
         NSNotificationCenter.defaultCenter().addObserver(self, selector: "handleHomeStatus:", name: "homeStatus", object: nil)
       
        
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }


        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewDidAppear(animated: Bool) {
         var deviceCount = PFUser.currentUser()!["deviceCount"] as! Int
       let off = 4 - deviceCount
        deviceOnLabel.text = "On: " + String(4 - userDevice.count)
        deviceOffLabel.text = "Off: " + String(userDevice.count)
        print(deviceCount)
        deviceNotification1.text = userDevice.door
        deviceNotification2.text = userDevice.light
        deviceNotification3.text = userDevice.coffee
        deviceNotification4.text = userDevice.window

        

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 5
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    func changePic(){
        
        let date = NSDate()
        let calender = NSCalendar.currentCalendar()
        let components = calender.components([.Hour, .Minute], fromDate: date)
        let hour = components.hour
        if(hour >= 0 && hour < 12){
       // timeImage.image = day
            timeLabel.text = "Good Morning " + first! + "!"
            
        }else if (hour >= 10 && hour <= 16){
       //     timeImage.image = day2
            timeLabel.text = "Good Afternoon " + first! + "!"

        } else if (hour >= 17 && hour <= 24){
        //    timeImage.image = sunset
            timeLabel.text = "Good Evening " + first! + "!"


        }else{
          //  timeImage.image = nightsky
        }
    }
    
    func handleHomeStatus(notification: NSNotification){
        print("handleHomeStatus")
        
        if let objectSwitched = notification.object as? [String: AnyObject]{
            print("object")
            print(objectSwitched)
            let hum = objectSwitched["H"] as! String
            let tem = objectSwitched["T"] as! String
            
           
            
            temperature.text = tem
            humidity.text = hum
            
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
