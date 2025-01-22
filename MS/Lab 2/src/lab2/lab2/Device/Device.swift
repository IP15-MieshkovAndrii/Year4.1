//
//  Device.swift
//  lab2
//
//  Created by Andrey Meshkov on 31.12.2024.
//
import Foundation

class Device {
    
    var tNext = 0.0
    private let delayMean: Double
    var tCurr = 0.0
    var state = State.free
    let distribution: Method
    private let delayDev = 0.0
    
    var delay: Double {
        var delay = delayMean
        switch distribution {
        case .exp:
            delay = FunRand.exp(timeMean: delayMean)
        case .norm:
            delay = FunRand.norm(timeMean: delayMean, timeDeviation: delayDev)
        case .unif:
            delay = FunRand.unif(timeMin: delayMean, timeMax: delayDev)
        }
        return delay
    }

    init(delay: Double, distribution: Method) {
        self.delayMean = delay
        self.distribution = distribution
    }
    
    func inAct() {
        state = .working
        tNext = tCurr + delay
    }
    
    func outAct() {
        state = .free
    }
    
}
