//
//  AppKitSupportsLoader.swift
//  SwiftUI2048AppKitSupports
//
//  Created by Hongyu on 6/7/19.
//  Copyright © 2019 Cyandev. All rights reserved.
//

#if targetEnvironment(UIKitForMac)
import Foundation
import AppKitSupports

func loadAppKitSupports() -> AppKitSupports? {
    guard let bundlePath = Bundle.main.path(forResource: "AppKitSupports", ofType: "bundle") else {
        return nil
    }
    
    guard let bundle = Bundle(path: bundlePath) else {
        return nil
    }
    
    bundle.load()
    
    // Note:
    // We must cast it to `NSObject`, because `AppKitSupportsFacade` here
    // is not lived in the same namespace as the bundle's.
    guard let facadeType = bundle.principalClass as? NSObject.Type else {
        return nil
    }
    
    let facade = facadeType.init() as AnyObject
    // But we can still reuse the selector.
    let implPtr = facade.getImpl()
    
    // Note:
    // The Swift 5 is ABI-stable, so the app and bundle are not necessarily
    // compiled by the same compiler. It's safe to use a pointer and pass
    // between libraries.
    return implPtr.bindMemory(to: AppKitSupports.self, capacity: 1).pointee
}

#endif
