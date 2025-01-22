import Foundation

class ResultsPrinter {
    
    private let processResultsConfig: [ProcessResultsOption]
    private let createResultsConfig: [CreateResultsOption]
    private let modelResultsConfig: [ModelResultsOption]
    
    init(processResultsConfig: [ProcessResultsOption], createResultsConfig: [CreateResultsOption], modelResultsConfig: [ModelResultsOption]) {
        self.processResultsConfig = processResultsConfig
        self.modelResultsConfig = modelResultsConfig
        self.createResultsConfig = createResultsConfig
    }
    
    func printModelResults(_ model: Model) {
        print("[Result of work model]")
        modelResultsConfig.forEach({ printModelResult(model, option: $0) })
    }
    
    private func printModelResult(_ model: Model, option: ModelResultsOption) {
        switch option {
        case .averageTasksInModel:
            print("average tasks in model = \(model.tasksInModel / model.tCurr)")
        case .averageTimeBetweenTaskCompletions:
            print("average time between task completions = \(Double(model.processCount) * model.tCurr / Double(model.tasksCompleted))")
        case .averageTimeTasksSpendsInModel:
            print("average time tasks spends in model = \(model.tasksInModel / Double(model.tasksCompleted))") // Формула Літтла
        case .failureProbability:
            print("failure probability = \(model.failureProbability)")
        case .relatedCount:
            print("related count = \(model.relatedCount)")
        }
    }
    
    func printCreateResults(_ create: Create) {
        print("[Result of work \(create.name)]")
        createResultsConfig.forEach({ printCreateResult(create, option: $0) })
    }
    
    private func printCreateResult(_ create: Create, option: CreateResultsOption) {
        switch option {
        case .quantity:
            print("quantity = \(create.quantity)")
        }
    }
    
    func printProcessResults(_ process: Process) {
        print("[Result of work \(process.name)]")
        processResultsConfig.forEach({ printProcessResult(process, option: $0) })
    }
    
    private func printProcessResult(_ process: Process, option: ProcessResultsOption) {
        switch option {
        case .quantity:
            print("quantity = \(process.quantity)")
        case .averageQueueLength:
            print("average length of queue = \(process.averageQueue / process.tCurr)")
        case .failureProbability:
            print("failure probability = \(Double(process.failure) / Double(process.quantity + process.failure))")
        case .averageLoadDevice:
            print("average load device = \(process.loadTime / process.tCurr)")
        case .averageWorkingDevice:
            print("average working devices = \(process.workingDevicesCount / process.tCurr)")
        case .averageTasksInWork:
            print("average tasks in work = \(process.tasksInWorkCount / process.tCurr)")
        case .averageTimeBetweenTaskCompletions:
            print("average time between task completions = \(Double(process.devices.count) * process.tCurr / Double(process.quantity))")
        }
    }
    
}
