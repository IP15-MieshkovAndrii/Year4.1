//
//  Element.swift
//  lab2
//
//  Created by Andrey Meshkov on 31.12.2024.
//

import Foundation

class Element {
    
    private static var nextID = 0
    
    let name: String
    var distribution = Method.exp
    private(set) var quantity = 0
    var tCurr = 0.0 {
        didSet {
            devices.forEach({ $0.tCurr = tCurr })
        }
    }
    var transfer: Transfer?
    let id: Int
    
    var devices: [Device]
    
    init(nameOfElement: String, delays: [Double]) {
        id = Element.nextID
        Element.nextID += 1
        name = nameOfElement
        devices = []
        delays.forEach({ devices.append(Device(delay: $0, distribution: distribution)) })
    }
    
    var tNext: Double {
        devices.map({ $0.tNext }).min()!
    }
    
    var state: State {
        if devices.filter({ $0.state == .free }).count > 0 {
            return .free
        } else {
            return .working
        }
    }
    
    func inAct() {
        
    }
    
    func outAct() {
        quantity += 1
    }
    
    func printResult() {
        print("Result of work \(name) \nquantity = \(quantity)")
    }
    
    func printInfo() {
        print("\(name) state = \(state.rawValue) quantity = \(quantity) tNext = \(tNext)")
    }
    
    func doStatisctic(delta: Double) {
        
    }
}

enum Method {
    case exp, norm, unif
}

enum State: String {
    case working, free
}

