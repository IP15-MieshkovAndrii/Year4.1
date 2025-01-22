import Foundation

class Task {
    
    let id = UUID()
    var typeId: Int
    
    init(typeId: Int = 1) {
        self.typeId = typeId
    }
    
}
