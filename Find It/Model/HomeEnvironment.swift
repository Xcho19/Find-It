//
//  HomeEnvironment.swift
//  Find It
//
//  Created by Xcho on 03.02.22.
//

import Foundation

struct HomeEnvironment: Codable {
    var easy: [String]
    var normal: [String]
    var hard: [String]
    
    static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let archiveURL = documentsDirectory.appendingPathComponent("Home").appendingPathExtension("plist")
    
   static func loadHomeWords() -> [HomeEnvironment]? {
        guard let codedWords = try? Data(contentsOf: archiveURL) else { return nil }
        let propertyListDecoder = PropertyListDecoder()
        return try?propertyListDecoder.decode(Array<HomeEnvironment>.self, from: codedWords)
    }
}


