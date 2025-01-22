import Foundation

class ModelFactory {
    
    private let standartResultsPrinter = ResultsPrinter(
        processResultsConfig: [], 
        createResultsConfig: [],
        modelResultsConfig: []
    )
    
    
    func task1() -> Model {
        let create = Create(name: "create", delay: 3)
        create.distribution = .exp
        let n = 10
        
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
        
        return Model(elements: elements, resultsPrinter: standartResultsPrinter)
    }
    
}