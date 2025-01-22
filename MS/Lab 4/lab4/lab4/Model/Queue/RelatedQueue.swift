import Foundation

class RelatedQueue: Queue {
    
    let relatedProcesses: [Process]
    let minimumTransitionDifference: Int
    
    init(relatedProcesses: [Process], minimumTransitionDifference: Int, maxLength: Int) {
        self.relatedProcesses = relatedProcesses
        self.minimumTransitionDifference = minimumTransitionDifference
        super.init(maxLength: maxLength)
    }
    
    override func remove() throws -> Task {
        let result = try super.remove()
        outerloop: while status != .full {
            for process in relatedProcesses {
                if process.queue.status != .full && currentLength + minimumTransitionDifference <= process.queue.currentLength {
                    let newTask = try process.queue.remove()
                    try add(newTask)
                    relatedCount += 1
                    continue outerloop
                }
            }
            break
        }
        return result
    }
    
}
