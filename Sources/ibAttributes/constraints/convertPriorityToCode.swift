//
//  convertPriorityToCode.swift
//  story2code
//
//  Created by Blazej Sleboda on 17/07/2025.
//

func convertPriorityToCode(_ priority: Float?) -> String? {
    guard let priority else { return nil }
    let priorityInt = Int(priority)
    let priorityValueAsCode = switch priorityInt {
        case 250: ".defaultLow"
        case 750: ".defaultHigh"
        case 1000: ".required"
        default: ".init(" + String(priorityInt) + ")"
    }
    return ".ibPriority(" + priorityValueAsCode + ")"
}
