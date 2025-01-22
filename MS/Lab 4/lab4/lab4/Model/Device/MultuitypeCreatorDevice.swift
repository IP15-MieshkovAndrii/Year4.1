import Foundation

class MultuitypeCreatorDevice: Device {
    
    private let delays: [MultuitypeCreatorProbabilities]
    private var nextType = 1
    
    init(delays: [MultuitypeCreatorProbabilities], distribution: Method) {
        self.delays = delays
        super.init(delay: delays[0].delay, distribution: distribution)
    }
    
    override var delay: Double {
        let newAverageDelay = generatedNextDelay
        var delay = newAverageDelay
        switch distribution {
        case .exp:
            delay = FunRand.exp(timeaverage: newAverageDelay)
        case .norm:
            delay = FunRand.norm(timeaverage: newAverageDelay, timeDeviation: delayDev)
        case .unif:
            delay = FunRand.unif(timeMin: newAverageDelay, timeMax: delayDev)
        case .erlanga:
            delay = FunRand.erlanga(timeaverage: newAverageDelay, k: erlangaValue)
        }
        return delay
    }
    
    private var generatedNextDelay: Double {
        var randomValue = Double.random(in: 0..<delays.reduce(0.0, { $0 + $1.probability }))
        for index in 0..<delays.count {
            let probability = delays[index]
            if randomValue < probability.probability {
                nextType = index + 1
                return probability.delay
            } else {
                randomValue -= probability.probability
            }
        }
        return 0
    }
    
    override func outAct() -> Task {
        state = .free
        return Task(typeId: nextType)
    }
    
}

struct MultuitypeCreatorProbabilities {
    let delay: Double
    let probability: Double
}
