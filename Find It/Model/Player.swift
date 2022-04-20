//
//  Players.swift
//  Find It
//
//  Created by Xcho on 20.03.22.
//

import Foundation

class Player {
    var name: String = ""
    var score: Int = 0
}

extension Player: Equatable {
    static func == (lhs: Player, rhs: Player) -> Bool {
        lhs.name == rhs.name
    }
}
