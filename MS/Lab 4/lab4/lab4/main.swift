import Foundation

let n = 10
let model = ModelFactory().task4(n)
let start = Date.now
model.simulate(timeModeling: 1000)
print("n =", n)
print("Time =", Date.now.timeIntervalSince1970 - start.timeIntervalSince1970)
