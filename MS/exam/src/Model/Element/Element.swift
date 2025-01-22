import Foundation

class Element {
    
    private static var nextID = 0
    
    let name: String
    var distribution = Method.exp {
        didSet {
            devices.forEach({ $0.distribution = distribution })
        }
    }
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
    
    var canAccept: Bool {
        return true
    }
    
    var queueLength: Int {
        return 0
    }
    
    var queueRelatedCount: Int {
        return 0
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
    
    func inAct(task: Task) {
        
    }
    
    func outAct() {
        quantity += 1
    }
    
    func printInfo() {
        // print("\(name) state = \(state.rawValue) quantity = \(quantity) tNext = \(tNext)")
    }
    
    func doStatisctic(delta: Double) {
        
    }
    
    func setDelayDev(_ value: Double) {
        devices.forEach({ $0.delayDev = value })
    }
    
    func setErlangaValue(_ value: Int) {
        devices.forEach({ $0.erlangaValue = value })
    }
    
}

enum Method {
    case exp, norm, unif, erlanga
}

enum State: String {
    case working, free
}
