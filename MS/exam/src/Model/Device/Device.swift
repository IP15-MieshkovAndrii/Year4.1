import Foundation

class Device {
    
    var tNext = 0.0
    private let delayaverage: Double
    var tCurr = 0.0
    var state = State.free
    var currentTask: Task?
    var distribution: Method
    var delayDev = 0.0
    var erlangaValue = 0
    
    var delay: Double {
        var delay = delayaverage
        switch distribution {
        case .exp:
            delay = FunRand.exp(timeaverage: delayaverage)
        case .norm:
            delay = FunRand.norm(timeaverage: delayaverage, timeDeviation: delayDev)
        case .unif:
            delay = FunRand.unif(timeMin: delayaverage, timeMax: delayDev)
        case .erlanga:
            delay = FunRand.erlanga(timeaverage: delayaverage, k: erlangaValue)
        }
        return delay
    }

    init(delay: Double, distribution: Method) {
        self.delayaverage = delay
        self.distribution = distribution
    }
    
    func inAct(task: Task) {
        state = .working
        tNext = tCurr + delay
        currentTask = task
    }
    
    func outAct() -> Task {
        state = .free
        if let result = currentTask {
            currentTask = nil
            return result
        } else {
            return Task()
        }
    }
    
}
