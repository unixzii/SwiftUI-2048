//
//  BlockGridView.swift
//  SwiftUI2048
//
//  Created by Hongyu on 6/5/19.
//  Copyright © 2019 Cyandev. All rights reserved.
//

import SwiftUI

struct AnchoredScale : ViewModifier {
    
    let scaleFactor: CGFloat
    let anchor: UnitPoint
    
    func body(content: Self.Content) -> some View {
        content.scaleEffect(scaleFactor, anchor: anchor)
    }
    
}

struct BlurEffect : ViewModifier {
    
    let blurRaduis: CGFloat
    
    func body(content: Self.Content) -> some View {
        content.blur(radius: blurRaduis)
    }
    
}

struct MergedViewModifier<M1, M2> : ViewModifier where M1: ViewModifier, M2: ViewModifier {
    
    let m1: M1
    let m2: M2
    
    init(first: M1, second: M2) {
        m1 = first
        m2 = second
    }
    
    func body(content: Self.Content) -> some View {
        content.modifier(m1).modifier(m2)
    }
    
}

extension AnyTransition {
    
    static func blockGenerated(from: Edge, position: CGPoint, `in`: CGRect) -> AnyTransition {
        let anchor = UnitPoint(x: position.x / `in`.width, y: position.y / `in`.height)
        
        return .asymmetric(
            insertion: AnyTransition.opacity.combined(with: .move(edge: from)),
            removal: AnyTransition.opacity.combined(with: .modifier(
                active: MergedViewModifier(
                    first: AnchoredScale(scaleFactor: 0.8, anchor: anchor),
                    second: BlurEffect(blurRaduis: 20)
                ),
                identity: MergedViewModifier(
                    first: AnchoredScale(scaleFactor: 1, anchor: anchor),
                    second: BlurEffect(blurRaduis: 0)
                )
            ))
        )
    }
    
}

struct BlockGridView : View {
    
    typealias SupportingMatrix = BlockMatrix<IdentifiedBlock>
    
    let matrix: Self.SupportingMatrix
    let blockEnterEdge: Edge
    
    func createBlock(_ block: IdentifiedBlock?,
                     at index: IndexedBlock<IdentifiedBlock>.Index) -> some View {
        let blockView: BlockView
        if let block = block {
            blockView = BlockView(block: block)
        } else {
            blockView = BlockView.blank()
        }
        
        // TODO: Still need refactor, these hard-coded values sucks!!
        let blockSize: CGFloat = 65
        let spacing: CGFloat = 12
        
        let position = CGPoint(
            x: CGFloat(index.0) * (blockSize + spacing) + blockSize / 2 + spacing,
            y: CGFloat(index.1) * (blockSize + spacing) + blockSize / 2 + spacing
        )
        
        return blockView
            .frame(width: 65, height: 65, alignment: .center)
            .position(x: position.x, y: position.y)
            .transition(.blockGenerated(
                from: self.blockEnterEdge,
                position: CGPoint(x: position.x, y: position.y),
                in: CGRect(x: 0, y: 0, width: 320, height: 320)
            ))
    }
    
    // FIXME: This is existed as a workaround for a Swift compiler bug.
    func zIndex(_ block: IdentifiedBlock?) -> Double {
        if block == nil {
            return 1
        }
        return 1000
    }
    
    var body: some View {
        ZStack {
            // Background grid blocks:
            ForEach(0..<4) { x in
                ForEach(0..<4) { y in
                    self.createBlock(nil, at: (x, y))
                }
            }
            .zIndex(1)
            
            // Number blocks:
            ForEach(self.matrix.flatten, id: \.item.id) {
                self.createBlock($0.item, at: $0.index)
            }
            .zIndex(1000)
            .animation(.interactiveSpring(response: 0.4, dampingFraction: 0.8))
        }
        .frame(width: 320, height: 320, alignment: .center)
        .background(
            Rectangle()
                .fill(Color(red:0.72, green:0.66, blue:0.63, opacity:1.00))
        )
        .clipped()
        .cornerRadius(6)
        .drawingGroup(opaque: false, colorMode: .linear)
    }
    
}

#if DEBUG
struct BlockGridView_Previews : PreviewProvider {
    
    static var matrix: BlockGridView.SupportingMatrix {
        var _matrix = BlockGridView.SupportingMatrix()
        _matrix.place(IdentifiedBlock(id: 1, number: 2), to: (2, 0))
        _matrix.place(IdentifiedBlock(id: 2, number: 2), to: (3, 0))
        _matrix.place(IdentifiedBlock(id: 3, number: 8), to: (1, 1))
        _matrix.place(IdentifiedBlock(id: 4, number: 4), to: (2, 1))
        _matrix.place(IdentifiedBlock(id: 5, number: 512), to: (3, 3))
        _matrix.place(IdentifiedBlock(id: 6, number: 1024), to: (2, 3))
        _matrix.place(IdentifiedBlock(id: 7, number: 16), to: (0, 3))
        _matrix.place(IdentifiedBlock(id: 8, number: 8), to: (1, 3))
        return _matrix
    }
    
    static var previews: some View {
        BlockGridView(matrix: matrix, blockEnterEdge: .top)
            .previewLayout(.sizeThatFits)
    }
    
}
#endif
