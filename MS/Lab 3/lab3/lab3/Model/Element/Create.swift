//
//  Create.swift
//  lab2
//
//  Created by Andrey Meshkov on 01.01.2025.
//

import Foundation

class Create: Element {
    
    init(name: String, delay: Double) {
        super.init(nameOfElement: name, delays: [delay])
        devices[0].tNext = 0
    }
    
    override func outAct() {
        super.outAct()
        let newTask = devices[0].outAct()
        devices[0].tNext += devices[0].delay
        transfer?.goNext(for: newTask)
    }
    
}
