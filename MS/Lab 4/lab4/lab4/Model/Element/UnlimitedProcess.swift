import Foundation

class UnlimitedProcess: Process {
    
    private let constDelay: Double
    
    init(name: String, delay: Double) {
        constDelay = delay
        super.init(name: name, delays: [constDelay])
    }
    
    override var canAccept: Bool {
        return true
    }
    
    override var state: State {
        .free
    }
    
    override func inAct(task: Task) {
        if !devices.contains(where: { $0.state == .free }) {
            devices.append(Device(delay: constDelay, distribution: distribution))
        }
        super.inAct(task: task)
    }
    
}
