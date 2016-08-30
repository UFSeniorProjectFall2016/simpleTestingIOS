

import UIKit

class SocketIOManager: NSObject {
    static let sharedInstance = SocketIOManager()
    let local = "http://10.136.96.246:3000"
    let  webstr = "https://sleepy-inlet-14613.herokuapp.com/"
    var door = false;

    var socket: SocketIOClient = SocketIOClient(socketURL: NSURL(string: "https://sleepy-inlet-14613.herokuapp.com/")!)
    
    
    override init() {
        super.init()
    }
    
    
    func establishConnection() {
        socket.connect()
        socket.emit("connected_user", "iPhone App User");
        print("connected");
        
    }
    
    
    func closeConnection() {
        socket.disconnect()
    }
    
    
    
    
    
    func exitChatWithNickname(nickname: String, completionHandler: () -> Void) {
        socket.emit("exitUser", nickname)
        completionHandler()
    }
    
    
    func chooseDevice(choice: String){
        switch choice{
        //door activated
        case "#door":
        print("door")
        
        let jsonObj = createJson(choice, msg: choice, status: (isDoor()))
        
        let valid = NSJSONSerialization.isValidJSONObject(jsonObj)
        if(valid){
            print("got it")
        socket.emit("device status", jsonObj)
        }

        //light activated
        case "light":
            let savedData = ["Something": 1]
            
            let jsonObject: [String: AnyObject] = [
                "type_id": 1,
                "model_id": 1,
                "transfer": [
                    "startDate": "10/04/2015 12:45",
                    "endDate": "10/04/2015 16:00"
                ],
                "custom": savedData
            ]
            
            let valid = NSJSONSerialization.isValidJSONObject(jsonObject)
            socket.emit("device status", jsonObject)

        //coffee activated
        case "coffee":
            let savedData = ["Something": 1]
            
            let jsonObject: [String: AnyObject] = [
                "type_id": 1,
                "model_id": 1,
                "transfer": [
                    "startDate": "10/04/2015 12:45",
                    "endDate": "10/04/2015 16:00"
                ],
                "custom": savedData
            ]
            
            let valid = NSJSONSerialization.isValidJSONObject(jsonObject)
            socket.emit("device status", jsonObject)

        //window activated
        case"window":
            let savedData = ["Something": 1]
            
            let jsonObject: [String: AnyObject] = [
                "type_id": 1,
                "model_id": 1,
                "transfer": [
                    "startDate": "10/04/2015 12:45",
                    "endDate": "10/04/2015 16:00"
                ],
                "custom": savedData
            ]
            
            let valid = NSJSONSerialization.isValidJSONObject(jsonObject)
            socket.emit("device status", jsonObject)

            
        default:
            print("error occured")
            
        }
    
    }
    
    
    func createJson(id : String, msg: String, status: Bool) -> [String: AnyObject]{
        
        let jsonObject: [String: AnyObject] = [
            "id": id,
            "name": msg,
            "status": status
        ]
        print(jsonObject)
        return jsonObject

        
    }
    func sendJson(jsonObj : [String: AnyObject]){
        socket.emit("device status", jsonObj)
    }
    
    
    
    private func listenForOtherMessages() {
        socket.on("userConnectUpdate") { (dataArray, socketAck) -> Void in
            NSNotificationCenter.defaultCenter().postNotificationName("userWasConnectedNotification", object: dataArray[0] as! [String: AnyObject])
        }
        
        socket.on("userExitUpdate") { (dataArray, socketAck) -> Void in
            NSNotificationCenter.defaultCenter().postNotificationName("userWasDisconnectedNotification", object: dataArray[0] as! String)
        }
        
        socket.on("userTypingUpdate") { (dataArray, socketAck) -> Void in
            NSNotificationCenter.defaultCenter().postNotificationName("userTypingNotification", object: dataArray[0] as? [String: AnyObject])
        }
    }
    
    func isDoor()->Bool {
        door = !door
        return door;
    }
    
    func sendStartTypingMessage(nickname: String) {
        socket.emit("startType", nickname)
    }
    
    
    func sendStopTypingMessage(nickname: String) {
        socket.emit("stopType", nickname)
    }
}
