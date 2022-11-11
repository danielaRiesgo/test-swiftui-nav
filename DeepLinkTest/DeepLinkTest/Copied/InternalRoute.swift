//
//  InternalRoute.swift
//  DeepLinkTest
//
//  Created by Dani on 11/10/22.
//

import Foundation

//
//  InternalRoutex.swift
//  helm
//
//  Created by Dani on 11/4/22.
//

import Foundation

enum InternalRoute {
    case playable(String)
    case collection(String)
}

extension InternalRoute: Equatable {
    static func == (lhs: InternalRoute, rhs: InternalRoute) -> Bool {
        switch (lhs, rhs) {
        case (.playable(let p1), .playable(let p2)) where p1 == p2:
            return true
        case (.collection(let c1), .collection(let c2)) where c1 == c2:
            return true
        default:
            return false
        }
    }
}
