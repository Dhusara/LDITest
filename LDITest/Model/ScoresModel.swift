//
//  ScoresModel.swift
//  LDITest
//
//  Created by Sergei Demianenko on 22.01.2023.
//

import Foundation

public let cUserScore = "userScore"

final class ScoresModel {
    
    static let shared = ScoresModel()
    
    public func setupScore() {
        UserDefaults.standard.set(10000, forKey: cUserScore)
        UserDefaults.standard.synchronize()
    }
    
    public func setScores(value: Int) {
        UserDefaults.standard.set(value, forKey: cUserScore)
        UserDefaults.standard.synchronize()
    }
    
    public func getScore() -> Int {
       return UserDefaults.standard.integer(forKey: cUserScore)
    }
}
