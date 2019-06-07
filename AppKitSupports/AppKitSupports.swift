//
//  AppKitSupports.swift
//  AppKitSupports
//
//  Created by Hongyu on 6/7/19.
//  Copyright © 2019 Cyandev. All rights reserved.
//

import Foundation

struct KeyEvent {
    
    enum Key {
        case up
        case down
        case left
        case right
    }
    
    let `repeat`: Bool
    let key: Key
    
}

typealias KeyEventListener = (KeyEvent) -> ()

// The main interface that app side interacts with.
protocol AppKitSupports : class {
    
    func monitorKeyDown(_ listener: @escaping KeyEventListener)
    
}

// Note:
// This is the principal class for this bundle and acts as a trampoline, app
// side will first load this and use it to get the impl object.
//
// We don't want to perform any symbol resolution (via `dlsym`), so this is
// a must.
class AppKitSupportsFacade : NSObject {
    
    override required init() {}
    
    @objc func getImpl() -> UnsafeRawPointer {
        fatalError("Stub is called")
    }
    
}
