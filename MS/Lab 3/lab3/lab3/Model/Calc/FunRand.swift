//
//  FunRand.swift
//  lab2
//
//  Created by Andrey Meshkov on 01.01.2025.
//

import Foundation

class FunRand {
    
    private class var generateA: Double {
        var a = Double.random(in: 0..<1)
        while a == 0 {
            a = Double.random(in: 0..<1)
        }
        return a
    }
    
    class func exp(timeaverage: Double) -> Double {
        var a = generateA
        a = -timeaverage * log(a)
        return a
    }
    
    class func unif(timeMin: Double, timeMax: Double) -> Double {
        var a = generateA
        a = timeMin + a * (timeMax - timeMin)
        return a
    }
    
    class func norm(timeaverage: Double, timeDeviation: Double) -> Double {
        timeaverage + timeDeviation * Double.random(in: -1...1)
    }
    
    class func erlanga(timeaverage: Double, k: Int) -> Double {
        (0..<k).reduce(0.0, { prevValue, _ in
            prevValue + exp(timeaverage: timeaverage)
        })
    }
    
}
