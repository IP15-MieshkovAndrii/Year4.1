//
//  Process.swift
//  lab2
//
//  Created by Andrey Meshkov on 31.12.2024.
//

import Foundation

class Process: Element {
    
    private var queue = 0
    var maxQueue = Int.max
    private(set) var failure = 0
    private(set) var meanQueue = 0.0
    private(set) var loadTime = 0.0
    private(set) var workingDevicesCount = 0.0
    
    init(name: String, delays: [Double]) {
        super.init(nameOfElement: name, delays: delays)
    }
    
    override func inAct() {
        switch state {
        case .free:
            devices.first(where: {$0.state == .free})?.inAct()
        case .working:
            if queue < maxQueue {
                queue += 1
            } else {
                failure += 1
            }
        }
    }
    
    override func outAct() {
        super.outAct()
        let outCount = devices.filter({ $0.tNext == tCurr }).count
        devices.filter({ $0.tNext == tCurr }).forEach({ $0.outAct() })
        (0..<outCount).forEach({ _ in
            if queue > 0 {
                queue -= 1
                devices.first(where: {$0.state == .free})?.inAct()
            } else {
                devices.filter({ $0.state == .free }).forEach({ $0.tNext = .infinity })
            }
            transfer?.goNext()
        })
    }
    
    override func printInfo() {
        super.printInfo()
        print("failure = \(failure)")
    }
    
    override func doStatisctic(delta: Double) {
        meanQueue += Double(queue) * delta
        if devices.filter({ $0.state == .working }).count > 0 {
            loadTime += delta
        }
        workingDevicesCount += Double(devices.filter({ $0.state == .working }).count) * delta
    }
    
}
