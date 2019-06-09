//
//  AppDelegate.swift
//  SwiftUI2048-mac
//
//  Created by Hongyu on 6/9/19.
//  Copyright © 2019 Cyandev. All rights reserved.
//

import Cocoa
import SwiftUI

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var window: NSWindow!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 600, height: 600),
            styleMask: [.titled, .closable, .miniaturizable, .fullSizeContentView],
            backing: .buffered, defer: false)
        window.titlebarAppearsTransparent = true
        window.isMovableByWindowBackground = true
        window.center()
        window.setFrameAutosaveName("Main Window")

        window.contentView = GameMainHostingView()

        window.makeKeyAndOrderFront(nil)
        window.makeFirstResponder(window.contentView)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
    }
    
    @objc func newGame(_ sender: Any?) {
        (window.contentView as? GameMainHostingView)?.newGame()
    }
    
}

