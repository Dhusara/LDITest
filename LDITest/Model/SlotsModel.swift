//
//  SlotsModel.swift
//  LDITest
//
//  Created by Sergei Demianenko on 24.01.2023.
//

import Foundation

struct SlotsModel {
    let name: String
    let backgroungImage: String
    let slotImageArray: [String]
    let logoImage: String
    let countLines: Int
    
    func randomSlot() -> Int { return Int.random(in: 9...17) }
    
    func pickerImageLine() -> [String] {
        var pikerImageLine = [String]()
        for _ in 1...3 { pikerImageLine.append(contentsOf: slotImageArray) }
        return pikerImageLine
    }
    
    func equalInLine(lineArray: [Int], currentBank: Int,currentBet: Double) -> Int {
        let filter = Set(lineArray).count
        var bank = currentBank
        switch filter {
        case 1:
            // 5 / 5
            bank = bank + Int(currentBet * 10)
        case 2:
            // 4 / 5
            bank = bank + Int(currentBet * 3)
        case 3:
            // 3 / 5
            bank = bank + Int(currentBet * 2)
        case 4:
            // 2 / 5
            bank = bank - Int(currentBet * 0.5)
        case 5:
            // 0 / 5
            bank = bank - Int(currentBet)
        default: print("Unknown Error")
        }
        return bank
    }
    
    func infoLabelText(before: Int, after: Int) -> String {
        let changesBank = after - before
        var infoText: String = ""
        if changesBank > 0 {
            infoText = "YOU WON: +\(changesBank)"
        } else {
            infoText = "YOU LOST: \(changesBank)"
        }
        return infoText
    }
}
