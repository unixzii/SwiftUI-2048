//
//  BlockView.swift
//  SwiftUI2048
//
//  Created by Hongyu on 6/5/19.
//  Copyright © 2019 Cyandev. All rights reserved.
//

import SwiftUI

struct BlockView : View {
    
    // Vibrant gradient color scheme: (gradientStart, gradientEnd, textColor)
    fileprivate let colorScheme: [(Color, Color, Color)] = [
        // 2 - Soft Cyan Gradient
        (Color(red:0.53, green:0.81, blue:0.92, opacity:1.00), Color(red:0.40, green:0.93, blue:0.93, opacity:1.00), Color.white),
        // 4 - Purple to Pink Gradient
        (Color(red:0.73, green:0.33, blue:0.83, opacity:1.00), Color(red:0.91, green:0.12, blue:0.39, opacity:1.00), Color.white),
        // 8 - Orange to Red Gradient
        (Color(red:1.00, green:0.60, blue:0.00, opacity:1.00), Color(red:0.90, green:0.22, blue:0.21, opacity:1.00), Color.white),
        // 16 - Deep Orange to Coral Gradient
        (Color(red:1.00, green:0.34, blue:0.13, opacity:1.00), Color(red:1.00, green:0.50, blue:0.38, opacity:1.00), Color.white),
        // 32 - Red to Pink Gradient
        (Color(red:0.96, green:0.26, blue:0.21, opacity:1.00), Color(red:0.91, green:0.30, blue:0.58, opacity:1.00), Color.white),
        // 64 - Deep Red to Magenta Gradient
        (Color(red:0.80, green:0.00, blue:0.00, opacity:1.00), Color(red:0.86, green:0.08, blue:0.24, opacity:1.00), Color.white),
        // 128 - Bright Yellow to Gold Gradient
        (Color(red:1.00, green:0.84, blue:0.00, opacity:1.00), Color(red:1.00, green:0.65, blue:0.00, opacity:1.00), Color.white),
        // 256 - Gold to Amber Gradient
        (Color(red:1.00, green:0.65, blue:0.00, opacity:1.00), Color(red:1.00, green:0.50, blue:0.00, opacity:1.00), Color.white),
        // 512 - Lime to Green Gradient
        (Color(red:0.50, green:0.98, blue:0.00, opacity:1.00), Color(red:0.00, green:0.80, blue:0.00, opacity:1.00), Color.white),
        // 1024 - Blue to Indigo Gradient
        (Color(red:0.13, green:0.59, blue:0.95, opacity:1.00), Color(red:0.25, green:0.32, blue:0.71, opacity:1.00), Color.white),
        // 2048 - Royal Purple to Deep Purple Gradient (Victory!)
        (Color(red:0.61, green:0.15, blue:0.69, opacity:1.00), Color(red:0.29, green:0.00, blue:0.51, opacity:1.00), Color.white),
    ]
    
    fileprivate let number: Int?
    
    // This is required to make the Text element be a different
    // instance every time the block is updated. Otherwise, the
    // text will be incorrectly rendered.
    //
    // TODO: File a bug.
    fileprivate let textId: String?
    
    init(block: IdentifiedBlock) {
        self.number = block.number
        self.textId = "\(block.id):\(block.number)"
    }
    
    fileprivate init() {
        self.number = nil
        self.textId = ""
    }
    
    static func blank() -> Self {
        return self.init()
    }
    
    fileprivate var numberText: String {
        guard let number = number else {
            return ""
        }
        return String(number)
    }
    
    fileprivate var fontSize: CGFloat {
        let textLength = numberText.count
        if textLength < 3 {
            return 32
        } else if textLength < 4 {
            return 18
        } else {
            return 12
        }
    }
    
    fileprivate var colorPair: (Color, Color, Color) {
        guard let number = number else {
            // Blank tile - subtle gray gradient
            return (Color(red:0.78, green:0.73, blue:0.68, opacity:1.00),
                    Color(red:0.70, green:0.65, blue:0.60, opacity:1.00),
                    Color.black)
        }
        let index = Int(log2(Double(number))) - 1
        if index < 0 || index >= colorScheme.count {
            fatalError("No color for such number")
        }
        return colorScheme[index]
    }
    
    // MARK: Body
    
    var body: some View {
        ZStack {
            // Vibrant gradient background
            LinearGradient(
                gradient: Gradient(colors: [colorPair.0, colorPair.1]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .zIndex(1)

            Text(numberText)
                .font(Font.system(size: fontSize).bold())
                .foregroundColor(colorPair.2)
                .id(textId!)
                // ⚠️ Gotcha: `zIndex` is important for removal transition!!
                .zIndex(1000)
                .transition(AnyTransition.opacity.combined(with: .scale))
        }
        .clipped()
        .cornerRadius(6)
    }
    
}

// MARK: - Previews

#if DEBUG
struct BlockView_Previews : PreviewProvider {
    
    static var previews: some View {
        Group {
            ForEach((1...11).map { Int(pow(2, Double($0))) }, id: \.self) { i in
                BlockView(block: IdentifiedBlock(id: 0, number: i))
                    .previewLayout(.sizeThatFits)
            }
            
            BlockView.blank()
                .previewLayout(.sizeThatFits)
        }
    }
    
}
#endif
