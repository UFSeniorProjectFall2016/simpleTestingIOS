

import UIKit

class SocketIOManager: NSObject {
    static let sharedInstance = SocketIOManager()
    
    let local = "http://10.136.96.246:3000"
    
    let  webstr = "https://sleepy-inlet-14613.herokuapp.com/"
    
    var door = false
    
    var light = false
    
    var coffee = false
    
    var window = false
    
    var socket: SocketIOClient = SocketIOClient(socketURL: NSURL(string: "https://sleepy-inlet-14613.herokuapp.com/")!)
    
    
    
    
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
    
    func createJson(id : String, msg: String, status: Bool) -> [String: AnyObject]{
        
        let jsonObject: [String: AnyObject] = [
            
            "id": id,
            
            "name": msg,
            
            "status": status
        ]
        
        print(jsonObject)
        
        return jsonObject
 
    }
    
    
    
    //emits json object
    
    func sendJson(jsonObj : [String: AnyObject]){
        
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
    }
    
    //controller for device
    
    func switchDevice(choice: String)->Bool {
        
        switch choice{
            
        case "#door":
            
            door = !door
            
            return door
            
        case "#light":
            
            light = !light
            
            return light
            
        case "#coffee":
            
            coffee = !coffee
            
            return coffee
            
        case "#wind":
            
            window = !window
            
            return window
            
        default:
            
            print("error")
            
            return false
            
            
            
        }
        
    }
    
    

}
