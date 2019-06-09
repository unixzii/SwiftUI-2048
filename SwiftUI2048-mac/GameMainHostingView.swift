//
//  GameMainHostingView.swift
//  2048
//
//  Created by Hongyu on 6/9/19.
//  Copyright © 2019 Cyandev. All rights reserved.
//

import SwiftUI

struct GameViewWrapper : View {
    
    fileprivate let gameLogic: GameLogic
    
    var body: some View {
        GameView()
            .environmentObject(gameLogic)
    }
    
}

class GameMainHostingView: NSHostingView<GameViewWrapper> {

    fileprivate var gameLogic: GameLogic!
    
    init() {
        gameLogic = GameLogic()
        super.init(rootView: GameViewWrapper(gameLogic: gameLogic))
    }
    
    @objc required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init(rootView: GameViewWrapper) {
        fatalError("init(rootView:) should not be called directly")
    }
    
    override var acceptsFirstResponder: Bool {
        return true
    }
    
    override var mouseDownCanMoveWindow: Bool {
        return true
    }
    
    override func keyDown(with event: NSEvent) {
        guard !event.isARepeat else {
            return
        }
        
        switch event.keyCode {
        case 125:
            self.gameLogic.move(.down)
            return
        case 123:
            self.gameLogic.move(.left)
            return
        case 124:
            self.gameLogic.move(.right)
            return
        case 126:
            self.gameLogic.move(.up)
            return
        default:
            return
        }
    }
    
    func newGame() {
        gameLogic.newGame()
    }
    
}
