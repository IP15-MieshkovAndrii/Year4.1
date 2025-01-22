//
//  SoloTransfer.swift
//  lab2
//
//  Created by Andrey Meshkov on 01.01.2025.
//

import Foundation

class SoloTransfer: Transfer {
    
    let elements: [Element]
    
    init(elements: [Element]) {
        self.elements = elements
    }
    func goNext(for task: Task) {
         let freeElements = elements.filter { $0.element.state == .free }
         if let highestPriorityFreeElement = freeElements.max(by: { $0.priority.value < $1.priority.value }) {
             freeElements
                 .filter { $0.priority.value == highestPriorityFreeElement.priority.value }
                 .randomElement()?.element.inAct(task: task)
             return
         }

         let smallestQueueLength = elements
             .compactMap { $0.element.canAccept ? $0.element.queueLength : nil }
             .min()

         let elementsWithSmallestQueue = elements.filter {
             $0.element.queueLength == smallestQueueLength && $0.element.canAccept
         }
         if let highestPriorityElementWithSmallQueue = elementsWithSmallestQueue.max(by: { $0.priority.value < $1.priority.value }) {
             elementsWithSmallestQueue
                 .filter { $0.priority.value == highestPriorityElementWithSmallQueue.priority.value }
                 .randomElement()?.element.inAct(task: task)
             return
         }

         elements.max(by: { $0.priority.value < $1.priority.value })?.element.inAct(task: task)
     }
    
}
