//
//  UsersViewController.swift
//  SocketChat
//
//  Created by Gabriel Theodoropoulos on 1/31/16.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import UIKit
var newModel = MyCustomTableViewCellModel()

class UsersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tblUserList: UITableView!
    var feedModelArray = [MyCustomTableViewCellModel]()
    
    
    var users = [[String: AnyObject]]()
    
    var nickname: String!
    
    var configurationOK = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fillDataArray()
        // Do any additional setup after loading the view.
        tblUserList.registerNib(UINib(nibName: "MyCustomTableViewCell", bundle: nil), forCellReuseIdentifier:"MyCustomCell")
    }

    func fillDataArray(){
        for index in 0..<4{
             let newModel = MyCustomTableViewCellModel()

            if index == 0 {
                newModel.deviceName = "Door"
            } else if index == 1 {
                newModel.deviceName = "Light"
                
            }else if index == 2{
                newModel.deviceName = "Coffee Machine"
            } else if index == 3 {
                newModel.deviceName = "Window"
            }
            feedModelArray.append(newModel)
            
        }
    }

    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if !configurationOK {
            configureNavigationBar()
            configureTableView()
            configurationOK = true
        }
        
    }

    
    
  override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
       /*if nickname == nil {
           askForNickname()
        }
*/
    
    self.tblUserList.reloadData()
    self.tblUserList.hidden = false
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


  
    
    // MARK: IBAction Methods
    
   @IBAction func exitChat(sender: AnyObject) {
        SocketIOManager.sharedInstance.exitChatWithNickname(nickname) { () -> Void in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.nickname = nil
                self.users.removeAll()
                self.tblUserList.hidden = true
                //self.askForNickname()
            })
        }
    }

    
    
    // MARK: Custom Methods
    
    func configureNavigationBar() {
        navigationItem.title = "KAI"
        UINavigationBar.appearance().backgroundColor = UIColor.greenColor()

    }
    
    
    func configureTableView() {
        tblUserList.delegate = self
        tblUserList.dataSource = self
        tblUserList.registerNib(UINib(nibName: "UserCell", bundle: nil), forCellReuseIdentifier: "idCellUser")
        tblUserList.hidden = true
        tblUserList.tableFooterView = UIView(frame: CGRectZero)
    }
    
    /*
   func askForNickname() {
        let alertController = UIAlertController(title: "SocketChat", message: "Please enter a nickname:", preferredStyle: UIAlertControllerStyle.Alert)
        
        alertController.addTextFieldWithConfigurationHandler(nil)
        
        let OKAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { (action) -> Void in
            let textfield = alertController.textFields![0]
            if textfield.text?.characters.count == 0 {
                self.askForNickname()
            }
            else {
                self.nickname = textfield.text
                
                SocketIOManager.sharedInstance.connectToServerWithNickname(self.nickname, completionHandler: { (userList) -> Void in
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        if userList != nil {
                            self.users = userList
                            self.tblUserList.reloadData()
                            self.tblUserList.hidden = false
                        }
                    })
                })
            }
        }

        alertController.addAction(OKAction)
        presentViewController(alertController, animated: true, completion: nil)
    }
    */
    
    // MARK: UITableView Delegate and Datasource methods
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4;
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       // let cell = tableView.dequeueReusableCellWithIdentifier("idCellUser", forIndexPath: indexPath) as! UserCell
        
        //cell.textLabel?.text = users[indexPath.row]["nickname"] as? String
        //cell.detailTextLabel?.text = (users[indexPath.row]["isConnected"] as! Bool) ? "Online" : "Offline"
        //cell.detailTextLabel?.textColor = (users[indexPath.row]["isConnected"] as! Bool) ? UIColor.greenColor() : UIColor.redColor()
        
        let cell = tableView.dequeueReusableCellWithIdentifier("MyCustomCell") as! MyCustomTableViewCell
        cell.delegate = self
        cell.setupWithModel(feedModelArray[indexPath.row])
        return cell
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44.0
    }
    
   
    
    
}

extension UsersViewController: MyCustomTableViewCellDelegate{
    func didTappedSwitch(cell: MyCustomTableViewCell){
        let indexPath = tblUserList.indexPathForCell(cell)
        feedModelArray[indexPath!.row].changed = cell.changed.on
        if(feedModelArray[indexPath!.row].deviceName == "Door"){
             SocketIOManager.sharedInstance.chooseDevice("#door")
            print("Door")
        }else if(feedModelArray[indexPath!.row].deviceName == "Light"){
        SocketIOManager.sharedInstance.sendLight()
            print("Light")
        }else if(feedModelArray[indexPath!.row].deviceName == "Coffee Machine"){
            SocketIOManager.sharedInstance.sendCoffee()
            print("Coffee")
        }else if(feedModelArray[indexPath!.row].deviceName == "Window"){
            SocketIOManager.sharedInstance.sendWindow()
            print("Window")
        }
    }
}
