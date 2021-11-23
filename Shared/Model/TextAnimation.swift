//
//  TextAnimation.swift
//  UI-319 (iOS)
//
//  Created by nyannyan0328 on 2021/10/01.
//

import SwiftUI

struct TextAnimation: Identifiable {
    var id = UUID().uuidString
    var text : String
    var offset : CGFloat = 120
}

