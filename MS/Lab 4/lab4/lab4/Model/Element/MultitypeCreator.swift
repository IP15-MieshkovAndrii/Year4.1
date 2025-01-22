import Foundation

class MultitypeCreator: Create {
    
    init(name: String, delays: [MultuitypeCreatorProbabilities]) {
        super.init(name: name, delay: delays[0].delay)
        devices = [MultuitypeCreatorDevice(delays: delays, distribution: distribution)]
        devices[0].tNext = 0
    }
    
}
