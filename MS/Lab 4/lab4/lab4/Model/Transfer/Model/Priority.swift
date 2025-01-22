//
//  Priority.swift
//  lab3
//
//  Created by Anatoliy Khramchenko on 25.11.2023.
//

import Foundation

struct ElementWithPriority {
    let element: Element
    let priority: Prioroty
}

protocol Prioroty {
    var value: Int { get }
}

extension Int: Prioroty {
    var value: Int {
        self
    }
}

enum PriorityConstant: Prioroty {
    
    case low, medium, hight
    
    var value: Int {
        switch self {
        case .low:
            return 0
        case .medium:
            return 50
        case .hight:
            return 100
        }
    }
    
}
