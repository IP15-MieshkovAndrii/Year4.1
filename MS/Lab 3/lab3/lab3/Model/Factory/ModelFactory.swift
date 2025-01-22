//
//  ModelFactory.swift
//  lab3
//
//  Created by Andrey Meshkov on 01.01.2025.
//

import Foundation

class ModelFactory {
    
    private let standartResultsPrinter = ResultsPrinter(
        processResultsConfig: [.quantity, .averageQueueLength, .failureProbability, .averageLoadDevice, .averageWorkingDevice, .averageTasksInWork], 
        createResultsConfig: [.quantity],
        modelResultsConfig: []
    )
    
    func makeModel(_ type: ModelType) -> Model {
        switch type {
        case .shop:
            shop()
        }
    }
    
    
    private func shop() -> Model {
        
        let create = Create(name: "create", delay: 1)
        let register1 = Process(name: "register1", delays: [9])
        let register2 = Process(name: "register2", delays: [9])
        let register3 = Process(name: "register3", delays: [9])
        let register4 = Process(name: "register4", delays: [9])
        let register5 = Process(name: "register5", delays: [9])
        let register6 = Process(name: "register6", delays: [9])
        let register7 = Process(name: "register7", delays: [9])
        let register8 = Process(name: "register8", delays: [9])
        let register9 = Process(name: "register9", delays: [9])
        let register10 = Process(name: "register10", delays: [9])
        
        
        register1.queue = Queue(maxLength: .max)
        register2.queue = Queue(maxLength: .max)
        register3.queue = Queue(maxLength: .max)
        register4.queue = Queue(maxLength: .max)
        register5.queue = Queue(maxLength: .max)
        register6.queue = Queue(maxLength: .max)
        register7.queue = Queue(maxLength: .max)
        register8.queue = Queue(maxLength: .max)
        register9.queue = Queue(maxLength: .max)
        register10.queue = Queue(maxLength: .max)
        
        register1.distribution = .exp
        register2.distribution = .exp
        register3.distribution = .exp
        register4.distribution = .exp
        register5.distribution = .exp
        register6.distribution = .exp
        register7.distribution = .exp
        register8.distribution = .exp
        register9.distribution = .exp
        register10.distribution = .exp
        
        create.transfer = SoloTransfer(nextElement: [ register1, register2, register3, register4, register5, register6, register7, register8, register9, register10])
        

        
        return Model(elements: [create, register1, register2, register3, register4, register5, register6, register7, register8, register9, register10], resultsPrinter: standartResultsPrinter)
        
    }
    
}

enum ModelType {
    case shop
}
