//
//  main.swift
//  lab2
//
//  Created by Andrey Meshkov on 31.12.2024.
//

import Foundation

let create = Create(name: "create", delay: 1)
let process1 = Process(name: "process1", delays: [5, 5, 5, 5, 5])
let process2 = Process(name: "process2", delays: [1.8, 1.8])
let process3 = Process(name: "process3", delays: [1])
let process4 = Process(name: "process4", delays: [0.1])

create.transfer = SoloTransfer(nextElement: process1)
process1.transfer = SoloTransfer(nextElement: process2)
//process2.transfer = SoloTransfer(nextElement: process3)
process2.transfer = TranferWithProbability(probabilities: [
    TransferProbability(probability: 0.25, nextElement: process1),
    TransferProbability(probability: 0.25, nextElement: process3),
    TransferProbability(probability: 0.5, nextElement: process4)
])

process1.maxQueue = 1
process2.maxQueue = 2
process3.maxQueue = 5
process4.maxQueue = 1

create.distribution = .exp
process1.distribution = .exp
process2.distribution = .exp
process3.distribution = .exp
process4.distribution = .exp

// let model = Model(elements: [create, process1, process2, process3])
let model = Model(elements: [create, process1, process2, process3, process4])
model.simulate(timeModeling: 1000)

