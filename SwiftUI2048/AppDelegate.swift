//
//  AppDelegate.swift
//  SwiftUI2048
//
//  Created by Hongyu on 6/5/19.
//  Copyright © 2019 Cyandev. All rights reserved.
//

import UIKit
import SwiftUI

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var gameLogic: GameLogic!
    var window: UIWindow?
    
#if targetEnvironment(UIKitForMac)
    var akSupports: AppKitSupports?
#endif
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        gameLogic = GameLogic()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window!.rootViewController = UIHostingController(rootView:
            GameView().environmentObject(gameLogic)
        )
        window!.makeKeyAndVisible()
        
#if targetEnvironment(UIKitForMac)
        initializeAppKitSupports()
        setupKeyboardEvents()
#endif
        
        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    @objc func newGame(_ sender: AnyObject?) {
        gameLogic.newGame()
    }
    
    override func buildCommands(with builder: UICommandBuilder) {
        builder.remove(menu: .edit)
        builder.remove(menu: .format)
        builder.remove(menu: .view)
        
        builder.replaceChildren(ofMenu: .file) { oldChildren in
            var newChildren = oldChildren
            let newGameItem = UIMutableKeyCommand(input: "N",
                                                  modifierFlags: .command,
                                                  action: #selector(newGame(_:)))
            newGameItem.title = "New Game"
            newChildren.insert(newGameItem, at: 0)
            return newChildren
        }
    }
    
    // MARK: - macOS-Specific Methods
    
#if targetEnvironment(UIKitForMac)
    private func initializeAppKitSupports() {
        akSupports = loadAppKitSupports()
    }
    
    private func setupKeyboardEvents() {
        akSupports?.monitorKeyDown({ e in
            guard !e.repeat else {
                return
            }
            
            switch e.key {
            case .down:
                self.gameLogic.move(.down)
                return
            case .left:
                self.gameLogic.move(.left)
                return
            case .right:
                self.gameLogic.move(.right)
                return
            case .up:
                self.gameLogic.move(.up)
                return
            }
        })
    }
#endif

}

