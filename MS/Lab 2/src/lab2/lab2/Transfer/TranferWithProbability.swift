//
//  TranferWithProbability.swift
//  lab2
//
//  Created by Andrey Meshkov on 31.12.2024.
//

import Foundation

class TranferWithProbability: Transfer {
    
    let probabilities: [TransferProbability]
    let maxProbability: Double
    
    init(probabilities: [TransferProbability]) {
        self.probabilities = probabilities
        maxProbability = probabilities.reduce(0.0, { $0 + $1.probability })
    }
    
    func goNext() {
        let number = Double.random(in: 0..<maxProbability)
        var currentProbability = 0.0
        for probability in probabilities {
            currentProbability += probability.probability
            if currentProbability > number {
                probability.nextElement.inAct()
                break
            }
        }
    }
    
}

struct TransferProbability {
    let probability: Double
    let nextElement: Element
}
