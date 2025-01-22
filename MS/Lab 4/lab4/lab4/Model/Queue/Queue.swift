import Foundation

class Queue {
    
    var tasks = [Task]()
    let maxLength: Int
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
