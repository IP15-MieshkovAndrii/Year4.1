

import Foundation

class ResultsPrinter {
    
    private let processResultsConfig: [ProcessResultsOption]
    
    init(processResultsConfig: [ProcessResultsOption]) {
        self.processResultsConfig = processResultsConfig
    }

    func printProcessResults(_ process: Process) {
        print("[Result of work \(process.name)]")
        processResultsConfig.forEach({ printProcessResult(process, option: $0) })
    }
    
    private func printProcessResult(_ process: Process, option: ProcessResultsOption) {
        switch option {
        case .averageTimeInQueue:
            print("average time in queue = \(process.queue.averageTimeInQueue)")
        }
    }
    
}
