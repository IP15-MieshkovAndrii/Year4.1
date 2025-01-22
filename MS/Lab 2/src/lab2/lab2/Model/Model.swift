//
//  Model.swift
//  lab2
//
//  Created by Andrey Meshkov on 31.12.2024.
//
import Foundation

class Model {
    
    private var tNext = 0.0
    private var tCurr = 0.0
    private var event = 0
    private let elements: [Element]
    
    init(elements: [Element]) {
        self.elements = elements
    }
    
    func simulate(timeModeling: Double) {
        while tCurr < timeModeling {
            tNext = Double.infinity
            elements.forEach { element in
                if element.tNext < tNext {
                    tNext = element.tNext
                }
            }
            elements.forEach({ $0.doStatisctic(delta: tNext - tCurr) })
            tCurr = tNext
            elements.forEach({ $0.tCurr = tCurr })
            elements.forEach { element in
                if element.tNext == tCurr {
                    element.outAct()
                    print("It's time for event in \(element.name) time = \(tCurr)")
                }
            }
            elements.forEach({ $0.printInfo() })
        }
        printResult()
    }
    
    private func printResult() {
        print("\n-------------RESULTS-------------\n")
        elements.forEach { element in
            element.printResult()
            if let process = element as? Process {
                print("failure probability = \(Double(process.failure) / Double(process.quantity + process.failure))")
                print("mean length of queue = \(process.meanQueue / tCurr)")
                print("mean working devices = \(process.workingDevicesCount / tCurr)")
            }
            print("")
        }
    }
    
}
