//
//  globalKaiFile.swift
//  SocketChat
//
//  Created by Anthony Colas on 11/24/16.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import Foundation

struct DevicesStruct {
    var count : Int = 4
    var door : String = "Door is off"
    var window : String = "Window is closed"
    var light : String = "Light is off"
    var coffee : String = "Coffee Machine is off"
}


struct switchValues{
    var door: Bool = false;
    var light: Bool = false;
    var window: Bool = false;
    var house: Bool = false;

    
}

var userDevice = DevicesStruct()