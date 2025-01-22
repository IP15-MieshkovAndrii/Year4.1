//
//  Task.swift
//  lab3
//
//  Created by Andrey Meshkov on 01.01.2025.
//

import Foundation

class Task {
    
    let id = UUID()
    var typeId: Int
    
    init(typeId: Int = 1) {
        self.typeId = typeId
    }
    
}
