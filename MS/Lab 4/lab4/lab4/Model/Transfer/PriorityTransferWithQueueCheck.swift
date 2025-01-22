import Foundation

class PriorityTransferWithQueueCheck: Transfer {
    
    let elements: [ElementWithPriority]
    
    init(elements: [ElementWithPriority]) {
        self.elements = elements
    }
    
    func goNext(for task: Task) {
        let elementsWithEmptyDevice = self.elements.filter({ $0.element.state == .free })
        if let maxElement = elementsWithEmptyDevice.max(by: { $0.priority.value < $1.priority.value }) {
            elementsWithEmptyDevice.filter({ $0.priority.value == maxElement.priority.value }).randomElement()?.element.inAct(task: task)
            return
        }
        let minQueueLength = self.elements.compactMap { element in
            if element.element.canAccept {
                return element.element.queueLength
            } else {
                return nil
            }
        }.min()
        let elementsWithEmptyQueue = self.elements.filter({ $0.element.queueLength == minQueueLength && $0.element.canAccept })
        if let maxElement = elementsWithEmptyQueue.max(by: { $0.priority.value < $1.priority.value }) {
            elementsWithEmptyQueue.filter({ $0.priority.value == maxElement.priority.value }).randomElement()?.element.inAct(task: task)
            return
        }
        elements.max(by: { $0.priority.value < $1.priority.value })?.element.inAct(task: task)
    }
    
}
