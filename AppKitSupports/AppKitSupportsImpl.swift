//
//  AppKitSupportsImpl.swift
//  AppKitSupports
//
//  Created by Hongyu on 6/7/19.
//  Copyright © 2019 Cyandev. All rights reserved.
//

import AppKit

class _AppKitSupportsImpl : AppKitSupports {
    
    fileprivate static var shared: AppKitSupports = _AppKitSupportsImpl()
    
    func monitorKeyDown(_ listener: @escaping (Bool, UInt16) -> ()) {
        NSEvent.addLocalMonitorForEvents(matching: .keyDown) { e -> NSEvent? in
            listener(e.isARepeat, e.keyCode)
            return e
        }
    }
    
}

class _AppKitSupportsFacadeImpl : AppKitSupportsFacade {
    
    required init() {}
    
    @objc override func getImpl() -> UnsafeRawPointer {
        return withUnsafePointer(to: &_AppKitSupportsImpl.shared) {
            UnsafeRawPointer($0)
        }
    }
    
}
