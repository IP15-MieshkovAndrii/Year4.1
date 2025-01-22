import Foundation

class PriorityQueue: Queue {
    
    private let priorityCheck: (Task, Task) -> Bool
    
    init(maxLength: Int, priorityCheck: @escaping (Task, Task) -> Bool) {
        self.priorityCheck = priorityCheck
        super.init(maxLength: maxLength)
    }
    
    override func add(_ task: Task) throws {
        guard currentLength < maxLength else {
            throw QueueError.queueFill
        }
        if tasks.isEmpty {
            tasks.append(task)
            return
        }
        var isInsert = false
        for taskIndex in 0..<tasks.count {
            if priorityCheck(task, tasks[taskIndex]) {
                isInsert = true
                tasks.insert(task, at: taskIndex)
                break
            }
        }
        if !isInsert {
            tasks.append(task)
        }
    }
    
}
