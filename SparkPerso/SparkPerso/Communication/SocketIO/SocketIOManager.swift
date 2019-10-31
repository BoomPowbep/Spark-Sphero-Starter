//
//  SocketIOManager.swift
//  SparkPerso
//
//  Created by Mickaël Debalme on 30/10/2019.
//  Copyright © 2019 AlbanPerli. All rights reserved.
//

import Foundation
import SocketIO

class SocketIOManager {
    static let instance = SocketIOManager()
    
    struct Ctx {
        var ip:String
        var port:String
        var modeVerbose:Bool
        // ...
        
        func fullIp() -> String {
            return "http://" + ip + ":" + port
        }
        
        static func debugContext() -> Ctx {
            return Ctx(ip: "172.28.59.25", port: "3000", modeVerbose: true)
        }
    }
    
    var manager:SocketManager? = nil
    var socket:SocketIOClient? = nil
    
    func setup(pCtx: Ctx = Ctx.debugContext()) {
        manager = SocketManager(socketURL: URL(string: pCtx.fullIp())!, config: [.log(pCtx.modeVerbose), .compress])
        socket = manager?.defaultSocket
    }
    
    func connect(callBack:@escaping ()->()) {
        listenToConnection(callBack: callBack)
        socket?.connect()
    }
    
    func listenToConnection(callBack:@escaping ()->()) {
        socket?.on(clientEvent: .connect) {data, ack in
            print("socket connected")
            callBack()
        }
    }
    
    func listenToChannel(channel:String, callBack:@escaping ()->()) {
        socket?.on(channel) {data, ack in
            ack.with("Got your currentAmount", "dude")
        }
    }
    
    func writeValue(_ value:String, toChannel channel:String, callBack:@escaping ()->()) {
        socket?.emit(channel, value)
    }
}
