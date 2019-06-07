//
//  AppKitSupportsImpl.swift
//  AppKitSupports
//
//  Created by Hongyu on 6/7/19.
//  Copyright © 2019 Cyandev. All rights reserved.
//

import AppKit

class _AppKitSupportsImpl : AppKitSupports {
    
    fileprivate static let shared = _AppKitSupportsImpl()
    
    func monitorKeyDown(_ listener: @escaping (KeyEvent) -> ()) {
        NSEvent.addLocalMonitorForEvents(matching: .keyDown) { e -> NSEvent? in
            let key: KeyEvent.Key
            switch e.keyCode {
            case 126:
                key = .up
                break
            case 125:
                key = .down
                break
            case 123:
                key = .left
                break
            case 124:
                key = .right
                break
            default:
                return e
            }
            
            let event = KeyEvent(repeat: e.isARepeat, key: key)
            listener(event)
            
            return e
        }
    }
    
}

class _AppKitSupportsFacadeImpl : AppKitSupportsFacade {
    
    required init() {}
    
    @objc override func getImpl() -> UnsafeRawPointer {
        var impl: AppKitSupports = _AppKitSupportsImpl.shared
        return withUnsafePointer(to: &impl) { UnsafeRawPointer($0) }
    }
    
}
