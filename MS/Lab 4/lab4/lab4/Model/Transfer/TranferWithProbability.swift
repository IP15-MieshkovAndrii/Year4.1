import Foundation

class TranferWithProbability: Transfer {
    
    let probabilities: [TransferProbability]
    let maxProbability: Double
    
    init(probabilities: [TransferProbability]) {
        self.probabilities = probabilities
        maxProbability = probabilities.reduce(0.0, { $0 + $1.probability })
    }
    
    func goNext(for task: Task) {
        let number = Double.random(in: 0..<maxProbability)
        var currentProbability = 0.0
        for probability in probabilities {
            currentProbability += probability.probability
            if currentProbability > number {
                probability.nextElement.inAct(task: task)
                break
            }
        }
    }
    
}
