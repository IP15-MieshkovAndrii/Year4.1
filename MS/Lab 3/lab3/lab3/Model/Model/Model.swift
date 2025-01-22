//
//  Model.swift
//  lab2
//
//  Created by Andrey Meshkov on 01.01.2025.
//

import Foundation

class Model {
    
    private var tNext = 0.0
    private(set) var tCurr = 0.0
    private var event = 0
    private let elements: [Element]
    
    private(set) var tasksInModel = 0.0
    
    private let resultsPrinter: ResultsPrinter
    
    init(elements: [Element], resultsPrinter: ResultsPrinter) {
        self.resultsPrinter = resultsPrinter
        self.elements = elements
    }
    
    var tasksCompleted: Int {
        return elements.filter({ $0 is Create }).reduce(0, { $0 + $1.quantity })
    }
    
    var processCount: Int {
        return elements.filter({ $0 is Process }).count
    }
    
    var failureProbability: Double {
        let failures = elements.filter({ $0 is Process }).reduce(0, { $0 + ($1 as! Process).failure })
        let createdElements = elements.filter({ $0 is Create }).reduce(0, { $0 + $1.quantity })
        return Double(failures) / Double(createdElements)
    }
    
    var relatedCount: Int {
        return elements.reduce(0, { $0 + $1.queueRelatedCount })
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
            doStatistic()
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
    
    private func doStatistic() {
        calculateTasksInModel()
    }
    
    private func calculateTasksInModel() {
        var tasks = elements.reduce(0, { $0 + $1.queueLength })
        elements.forEach { element in
            tasks += element.devices.filter({ $0.state == .working }).count
        }
        tasksInModel += Double(tasks) * (tNext - tCurr)
    }
    
    private func printResult() {
        print("\n-------------RESULTS-------------\n")
        print("")
        elements.forEach { element in
            if let process = element as? Process {
                resultsPrinter.printProcessResults(process)
            }
            print("")
        }
    }
    
}
