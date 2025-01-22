import Foundation

class PriorotyTransfer: Transfer {
    
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
        let elementsWithEmptyQueue = self.elements.filter({ $0.element.canAccept })
        if let maxElement = elementsWithEmptyQueue.max(by: { $0.priority.value < $1.priority.value }) {
            elementsWithEmptyQueue.filter({ $0.priority.value == maxElement.priority.value }).randomElement()?.element.inAct(task: task)
            return
        }
        elements.max(by: { $0.priority.value < $1.priority.value })?.element.inAct(task: task)
    }
    
}
