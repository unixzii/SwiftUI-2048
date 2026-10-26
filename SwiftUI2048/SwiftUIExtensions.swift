//
//  SwiftUIExtensions.swift
//  2048
//
//  Created by Hongyu on 6/10/19.
//  Copyright © 2019 Cyandev. All rights reserved.
//

#if OpenSwiftUI
import OpenSwiftUI
#else
import SwiftUI
#endif

extension View {
    
    func eraseToAnyView() -> AnyView {
        return AnyView(self)
    }
    
}

postfix operator >*
postfix func >*<V>(lhs: V) -> AnyView where V: View {
    return lhs.eraseToAnyView()
}
