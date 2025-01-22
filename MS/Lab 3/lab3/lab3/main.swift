//
//  main.swift
//  lab3
//
//  Created by Andrey Meshkov on 01.01.2025.
//

import Foundation

let model = ModelFactory().makeModel(.shop)
model.simulate(timeModeling: 1000)
