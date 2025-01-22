//
//  SoloTransfer.swift
//  lab2
//
//  Created by Andrey Meshkov on 31.12.2024.
//

import Foundation

class SoloTransfer: Transfer {
    
    let nextElement: Element
    
    init(nextElement: Element) {
        self.nextElement = nextElement
    }
    
    func goNext() {
        nextElement.inAct()
    }
    
}
