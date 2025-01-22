//
//  FunRand.swift
//  lab2
//
//  Created by Andrey Meshkov on 31.12.2024.
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
    
    class func exp(timeMean: Double) -> Double {
        var a = generateA
        a = -timeMean * log(a)
        return a
    }
    
    class func unif(timeMin: Double, timeMax: Double) -> Double {
        var a = generateA
        a = timeMin + a * (timeMax - timeMin)
        return a
    }
    
    class func norm(timeMean: Double, timeDeviation: Double) -> Double {
        timeMean + timeDeviation * Double.random(in: -Double.infinity...Double.infinity)
    }
    
}
