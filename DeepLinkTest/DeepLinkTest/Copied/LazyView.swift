//
//  LazyView.swift
//  DeepLinkTest
//
//  Created by Dani on 11/10/22.
//

import Foundation
import SwiftUI

struct LazyView<Content: View>: View {

    let build: () -> Content

    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }

    var body: Content {
        build()
    }

}
