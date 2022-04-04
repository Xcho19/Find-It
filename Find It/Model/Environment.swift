//
//  Environment.swift
//  Find It
//
//  Created by Xcho on 12.03.22.
//

import Foundation

struct Environment: Codable {
    var easy: [String] = []
    var medium: [String] = []
    var hard: [String] = []

    init(withPlistAt url: URL) {
        do {
            let plistData = try Data(contentsOf: url)
            self = try PropertyListDecoder().decode(Environment.self, from: plistData)
        } catch {
            print(error.localizedDescription)
        }
    }
}
