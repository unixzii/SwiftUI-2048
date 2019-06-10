//
//  SwiftUIExtensions.swift
//  2048
//
//  Created by Hongyu on 6/10/19.
//  Copyright © 2019 Cyandev. All rights reserved.
//

import SwiftUI

extension View {
    
    func eraseToAnyView() -> AnyView {
        return AnyView(self)
    }
    
}
