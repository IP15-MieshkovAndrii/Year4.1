//
//  Process.swift
//  lab2
//
//  Created by Andrey Meshkov on 01.01.2025.
//

import Foundation

class Process: Element {
    
    var queue = Queue(maxLength: .max)
    private(set) var failure = 0
    private(set) var averageQueue = 0.0
    private(set) var loadTime = 0.0
    private(set) var workingDevicesCount = 0.0
    private(set) var tasksInWorkCount = 0.0
    
    init(name: String, delays: [Double]) {
        super.init(nameOfElement: name, delays: delays)
    }
    
    override var canAccept: Bool {
        queue.status != .full
    }
    
    override var queueLength: Int {
        queue.currentLength
    }
    
    override var queueRelatedCount: Int {
        return queue.relatedCount
    }
    
    override func inAct(task: Task) {
        switch state {
        case .free:
            devices.first(where: {$0.state == .free})?.inAct(task: task)
        case .working:
            do {
                try queue.add(task)
            } catch {
                failure += 1
            }
        }
    }
    
    override func outAct() {
        super.outAct()
        let outTasks = devices.filter({ $0.tNext == tCurr }).map({ $0.outAct() })
        (0..<outTasks.count).forEach({ index in
            do {
                if queue.currentLength > 0 {
                    let newTask = try queue.remove()
                    devices.first(where: {$0.state == .free})?.inAct(task: newTask)
                } else {
                    devices.filter({ $0.state == .free }).forEach({ $0.tNext = .infinity })
                }
                transfer?.goNext(for: outTasks[index])
            } catch {
                print(error)
            }
        })
    }
    
    override func printInfo() {
        super.printInfo()
        print("failure = \(failure)")
    }
    
    override func doStatisctic(delta: Double) {
        averageQueue += Double(queue.currentLength) * delta
        if devices.filter({ $0.state == .working }).count > 0 {
            loadTime += delta
        }
        workingDevicesCount += Double(devices.filter({ $0.state == .working }).count) * delta
        tasksInWorkCount += Double(devices.filter({ $0.state == .working }).count + queueLength) * delta
    }
    
}
