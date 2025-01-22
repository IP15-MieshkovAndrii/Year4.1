import Foundation

class SoloTransfer: Transfer {
    
    let nextElement: Element
    
    init(nextElement: Element) {
        self.nextElement = nextElement
    }
    
    func goNext(for task: Task) {
        nextElement.inAct(task: task)
    }
    
}
