//
//  AppKitSupports.swift
//  AppKitSupports
//
//  Created by Hongyu on 6/7/19.
//  Copyright © 2019 Cyandev. All rights reserved.
//

import Foundation

/*
public struct KeyEvent {
    
    public enum Key {
        case up
        case down
        case left
        case right
    }
    
    public let `repeat`: Bool
    public let key: Key
    
}
*/

public typealias KeyEventListener = (Bool, UInt16) -> ()

// The main interface that app side interacts with.
public protocol AppKitSupports : class {
    
    func monitorKeyDown(_ listener: @escaping KeyEventListener)
    
}

// Note:
// This is the principal class for this bundle and acts as a trampoline, app
// side will first load this and use it to get the impl object.
//
// We don't want to perform any symbol resolution (via `dlsym`), so this is
// a must.
public class AppKitSupportsFacade : NSObject {
    
    public override required init() {}
    
    @objc public func getImpl() -> UnsafeRawPointer {
        fatalError("Stub is called")
    }
    
}
