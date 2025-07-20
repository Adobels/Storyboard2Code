//
//  ParserConstraint.swift
//  story2code
//
//  Created by Blazej Sleboda on 18/07/2025.
//

struct ParserConstraint {
    var firstItem: String
    var firstAttribute: String
    var relation: String?
    var secondItem: String?
    var secondAttribute: String?
    var multiplier: String?
    var priority: Float?
    var constant: Float?
    var identifier: String?
    var id: String

    mutating func reverseFirstAndSecondItem() {
        guard let secondItem else { return }
        guard let secondAttribute else { return }
        let firstItemCopy = firstItem
        let firstAttributeCopy = firstAttribute
        self.firstItem = secondItem
        self.firstAttribute = secondAttribute
        if let relation {
            switch relation {
            case "greaterThanOrEqual": self.relation = "lessThanOrEqual"
            case "lessThanOrEqual": self.relation = "greaterThanOrEqual"
            default: break
            }
        }
        self.secondItem = firstItemCopy
        self.secondAttribute = firstAttributeCopy
        let multiplierCopy = multiplier
        if let multiplierCopy {
            let multiplierFloat = Float(multiplierCopy)
            if let multiplierFloat {
                self.multiplier = .init(1 / multiplierFloat)
            } else {
                self.multiplier = multiplierCopy.components(separatedBy: ":").reversed().joined(separator: ":")
            }
        }
        if let constant {
            self.constant = {
                if let multiplierCopy {
                    return calculateConstantAfterReversingMultiplier(originalMultiplier: multiplierCopy, constant: constant)
                } else {
                    return constant * -1
                }
            }()
        }
        func calculateConstantAfterReversingMultiplier(originalMultiplier: String, constant: Float) -> Float {
            let multiplierFloat = Float(originalMultiplier)
            if let multiplierFloat {
                return multiplierFloat * constant * -1
            } else {
                let componentsOfIntegers = originalMultiplier.components(separatedBy: ":").map { Float($0)! }
                let value = componentsOfIntegers[0] / componentsOfIntegers[1]
                return value * constant * -1
            }
        }
    }
}
