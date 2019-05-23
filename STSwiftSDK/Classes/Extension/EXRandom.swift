//
//  EXBool.swift
//  Swift-Kit
//
//  Created by cfans on 2018/12/4.
//  Copyright © 2018 cfans. All rights reserved.
//

import Foundation

open struct Random {

    /// Returns random double number between two values
    public static func randomDouble(lower:Double=0,upper:Double=1.0) ->Double{
        return (Double(arc4random()) / 0xffffffff) * (upper - lower) + lower
    }

    /// Returns random value, true or false
    public static func randomBool()->Bool {
        return Random.randomDouble(lower: 0, upper: 1) > 0.5
    }

    /// Returns random Int number,between two values
    public static func randomInt(lower:Int=0,upper:Int=Int.max)->Int {
        return Int(Random.randomDouble(lower: Double(lower), upper: Double(upper)))
    }

    /// Returns random double number between two values
    public static func randomFloat(lower:Double=0,upper:Double=1.0) ->Float{
        return Float(randomDouble(lower: lower, upper: upper))
    }

}

struct CFMath {
    public static func roundTo(input:Double,places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (input * divisor).rounded() / divisor
    }
}
