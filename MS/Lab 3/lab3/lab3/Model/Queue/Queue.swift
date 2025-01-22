//
//  Queue.swift
//  lab3
//
//  Created by Andrey Meshkov on 01.01.2025.
//

import Foundation

class Queue {
    
    var tasks = [Task]()
    let maxLength: Int
    private var totalTimeSpent = 0.0
    private var totalTasksProcessed = 0
    var relatedCount = 0
    
    init(maxLength: Int) {
        self.maxLength = maxLength
    }
    
    var currentLength: Int {
        tasks.count
    }
    
    var status: QueueStatus {
        if currentLength == 0 {
            return .empty
        }
        if currentLength < maxLength {
            return .withTasks
        }
        return .full
    }
    
    func add(_ task: Task) throws {
        guard currentLength < maxLength else {
            throw QueueError.queueFill
        }
        tasks.append(task)
    }
    
    var averageTimeInQueue: Double {
        guard totalTasksProcessed > 0 else { return 0.0 }
        return totalTimeSpent / Double(totalTasksProcessed)
    }
    
    @discardableResult
    func remove() throws -> Task {
        guard currentLength > 0 else {
            throw QueueError.queryEmpty
        }
        return tasks.remove(at: 0)
    }
    
}

enum QueueError: Error {
    case queueFill, queryEmpty
}

enum QueueStatus {
    case full, empty, withTasks
}
