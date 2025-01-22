import Foundation

class ModelFactory {
    
    private let standartResultsPrinter = ResultsPrinter(
        processResultsConfig: [.quantity, .averageQueueLength, .failureProbability, .averageLoadDevice, .averageWorkingDevice, .averageTasksInWork], 
        createResultsConfig: [.quantity],
        modelResultsConfig: []
    )
    private let lab4Printer = ResultsPrinter(
        processResultsConfig: [],
        createResultsConfig: [],
        modelResultsConfig: []
    )
    
    func makeModel(_ type: ModelType) -> Model {
        switch type {
        case .priorityTest:
            priorityTest()
        }
    }
    
    private func priorityTest() -> Model {
        let create = Create(name: "create", delay: 1)
        let process1 = Process(name: "process1", delays: [5, 5, 5])
        let process2 = Process(name: "process2", delays: [1.8, 1.8])
        let process3 = Process(name: "process3", delays: [2])
        let process4 = Process(name: "process4", delays: [1])

        create.transfer = SoloTransfer(nextElement: process1)
        process1.transfer = SoloTransfer(nextElement: process2)
        process2.transfer = PriorityTransferWithQueueCheck(elements: [
            ElementWithPriority(element: process3, priority: PriorityConstant.hight),
            ElementWithPriority(element: process4, priority: PriorityConstant.low)
        ])

        process1.queue = Queue(maxLength: 1)
        process2.queue = Queue(maxLength: 5)
        process3.queue = Queue(maxLength: 5)
        process4.queue = Queue(maxLength: 1)

        create.distribution = .exp
        process1.distribution = .exp
        process2.distribution = .exp
        process3.distribution = .exp
        process4.distribution = .exp

        return Model(elements: [create, process1, process2, process3, process4], resultsPrinter: standartResultsPrinter)
    }
    
    func task1(_ n: Int) -> Model {
        let create = Create(name: "create", delay: 3)
        create.distribution = .exp
        
        var elements: [Element] = [create]
        for index in 0..<n {
            let process = Process(name: "process\(index)", delays: [1])
            if elements.isEmpty {
                create.transfer = SoloTransfer(nextElement: process)
            } else {
                elements.last?.transfer = SoloTransfer(nextElement: process)
            }
            process.queue = Queue(maxLength: .max)
            process.distribution = .exp
            elements.append(process)
        }
        
        return Model(elements: elements, resultsPrinter: lab4Printer)
    }
    
    func task4(_ n: Int) -> Model {
        let create = Create(name: "create", delay: 3)
        create.distribution = .exp
        
        var elements: [Element] = [create]
        for index in 0..<n {
            let process = Process(name: "process\(index)", delays: [1])
            if elements.isEmpty {
                create.transfer = SoloTransfer(nextElement: process)
            } else {
                elements.last?.transfer = SoloTransfer(nextElement: process)
            }
            process.queue = Queue(maxLength: .max)
            process.distribution = .exp
            elements.append(process)
        }
        
        elements.last?.transfer = CustomTransfer(nextElement: { _ in
            if Double.random(in: 0..<1) > 0.5 {
                return elements[1]
            } else {
                return nil
            }
        })
        
        return Model(elements: elements, resultsPrinter: lab4Printer)
    }
    
}

enum ModelType {
    case priorityTest
}
