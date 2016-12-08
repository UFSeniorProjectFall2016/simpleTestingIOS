

import UIKit


var door = false

var light = false

var coffee = false

var window = false


class SocketIOManager: NSObject {
    //var user = PFUser.currentUser()
   // var deviceCount = PFUser.currentUser()!["deviceCount"] as! Int
    
    static let sharedInstance = SocketIOManager()
    
    //let local = "http://10.136.96.246:3000"
    let local = "http://192.168.0.101:3000"
    
    let  webstr = "https://kai-final.herokuapp.com/"
    
    
    var socket: SocketIOClient = SocketIOClient(socketURL: NSURL(string: "https://kai-final.herokuapp.com/")!)
    
    
    
    
    override init() {
        super.init()
    }
    
    
    func establishConnection() {
        socket.connect()
    }
    
    
    func closeConnection() {
        socket.disconnect()
    }
  
    
    func connectToServer() {
        socket.emit("connected_user", "iphone_user_detected")
        listenForOtherMessages()
    }
    
    
    func exitChatWithNickname(nickname: String, completionHandler: () -> Void) {
        socket.emit("exitUser", nickname)
        completionHandler()
    }
    
    
    func sendMessage(message: String, withNickname nickname: String) {
        socket.emit("chatMessage", nickname, message)
        
    }
    
    //chooses the correct device to turn on/off
    
    func chooseDevice(choice: String){
        
        let jsonObj = createJson(choice, msg: choice, status: (switchDevice(choice)))
        
        
        
        let valid = NSJSONSerialization.isValidJSONObject(jsonObj)
        
        if(valid){
            
            print("got it")
            
            sendJson(jsonObj)
            
        }
        
        
        
    }
    

    
    //creates json object
    
    func createJson(id : String, msg: String, status: Int) -> [String: AnyObject]{
        if(id != "#wind"){
        let jsonObject: [String: AnyObject] = [
            "date": "",
            "_name": msg,
            "_state": false,
            "created":"",
            "origin": "iPhone",
            "_devid": id,
            "_status": status,
            "type":"device status",
            "_devType": 2,
            "_des": "This is" + id
            
        ]
        
        print(jsonObject)
        
        return jsonObject
        }
        else{
            let jsonObject: [String: AnyObject] = [
                "date": "",
                "_name": msg,
                "_state": false,
                "created":"",
                "origin": "iPhone",
                "_devid": id,
                  "_status": status,
                "type":"device status",
                "_devType": 2,
                "_des": "This is" + id
                
  
            ]
            
            print(jsonObject)

            return jsonObject
        }
    }
    
    
    
    //emits json object
    
    func sendJson(jsonObj : [String: AnyObject]){
        print("sendingJson")
        socket.emit("device status", jsonObj)
        
    }
    

    
    private func listenForOtherMessages() {
        print("im here")
        /*
        var names = [String] ()
        socket.on("userConnectUpdate") { (dataArray, socketAck) -> Void in
            NSNotificationCenter.defaultCenter().postNotificationName("userWasConnectedNotification", object: dataArray[0] as! [String: AnyObject])
        }
        
        socket.on("userExitUpdate") { (dataArray, socketAck) -> Void in
            NSNotificationCenter.defaultCenter().postNotificationName("userWasDisconnectedNotification", object: dataArray[0] as! String)
        }
        
        socket.on("userTypingUpdate") { (dataArray, socketAck) -> Void in
            NSNotificationCenter.defaultCenter().postNotificationName("userTypingNotification", object: dataArray[0] as? [String: AnyObject])
        }*/
        
        socket.on("device status"){ (dataArray, socketAck) -> Void in
            NSNotificationCenter.defaultCenter().postNotificationName("deviceStatus", object: dataArray[0] as? [String: AnyObject])
            
            
            
           /* do {
                let jsonData = try NSJSONSerialization.dataWithJSONObject(dataArray, options: NSJSONWritingOptions.PrettyPrinted)
                let id = dataArray[0]["id"] as! String
               // let status = dataArray[0]["status"] as! String
                self.switchDevice(id)
                
                
                
            }catch let error as NSError{
                print(error.description)
            }*/
            
        }
        socket.on("feedback"){ (dataArray, socketAck) -> Void in
            NSNotificationCenter.defaultCenter().postNotificationName("houseStatus", object: dataArray[0] as? [String: AnyObject])}
    }
    
    //controller for device
    
    func switchDevice(choice: String)->Int {
        var retVal = 0
         var retVal2 = 0
         var retVal3 = 0
         var retVal4 = 0
            var retcoffee = 0
        switch choice{
            
        case "#door":
            
            door = !door
            if(door == true){
                print("true count")
            //    deviceCount++
            //    user["deviceCount"] = deviceCount
              //  user.saveInBackground()
                
            //    print("deviceCount " + String(deviceCount))
                retVal = 1
            }
            else{
                
             //   deviceCount--
            //    //user["deviceCount"] = deviceCount
               // user.saveInBackground()
           //     print("deviceCount " + String(deviceCount))


            }
            return retVal
            
        case "#light":
            
            light = !light
            if(light == true){
               // userDevice.door = "Light is on"
        //        deviceCount++
                
          //      print("device count is " + String(deviceCount))
              //  user["deviceCount"] = deviceCount
                //user.saveInBackground()


              retVal2 = 1
            }
            else{
              //  userDevice.door = "Light is off"
             //   deviceCount--
               // user["deviceCount"] = deviceCount
                //user.saveInBackground()


            }
            
            return retVal2
            
        case "#coffee":
            
            coffee = !coffee
            if(coffee == true){
             //   userDevice.door = "Coffee Machine is on"
           //     deviceCount++
             //   user["deviceCount"] = deviceCount
               // user.saveInBackground()

                return 1
                
            }
            else{
               // userDevice.door = "Coffee Machine is off"
              //  deviceCount--
            //    user["deviceCount"] = deviceCount
              //  user.saveInBackground()

                return 0
            }

            
      
            
        case "#wind":
            
            window = !window
            if(window == true){
           //     userDevice.door = "Window is open"
             //   deviceCount++
               // user["deviceCount"] = deviceCount
                //user.saveInBackground()

                retVal4 = 5
            }
            else{
               // userDevice.door = "Widnow is closed"
             //   deviceCount--
                //user["deviceCount"] = deviceCount
             //   user.saveInBackground()

            }

            return retVal4
            
        default:
            
            print("error")
            
            return 0
            
            
            
        }
        
    }
    
    

}
