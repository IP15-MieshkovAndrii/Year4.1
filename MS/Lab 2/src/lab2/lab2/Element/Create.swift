//
//  Create.swift
//  lab2
//
//  Created by Andrey Meshkov on 31.12.2024.
//

import Foundation

class Create: Element {
    
    init(name: String, delay: Double) {
        super.init(nameOfElement: name, delays: [delay])
        devices[0].tNext = 0
    }
    
    override func outAct() {
        super.outAct()
        devices[0].outAct()
        devices[0].tNext += devices[0].delay
        transfer?.goNext()
    }
    
}
