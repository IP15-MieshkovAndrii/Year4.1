import Foundation

class CustomTransfer: Transfer {
    
    private let nextElement: (Task) -> Element?
    
    init(nextElement: @escaping (Task) -> Element?) {
        self.nextElement = nextElement
    }
    
    func goNext(for task: Task) {
        let element = nextElement(task)
        element?.inAct(task: task)
    }
    
}
