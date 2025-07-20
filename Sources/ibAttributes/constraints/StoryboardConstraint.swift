//
//  S2CConstraintStandard.swift
//  story2code
//
//  Created by Blazej Sleboda on 19/07/2025.
//

struct ConverterConstraint {
    var ownerItem: String
    var firstItem: String
    var firstLayoutGuide: String?
    var firstAttribute: String
    var relation: String?
    var secondItem: String?
    var secondLayoutGuide: String?
    var secondAttribute: String?
    var multiplier: String?
    var priority: Float?
    var constant: Float?
    var identifier: String?
    var id: String
}

struct StoryboardConstraint: Equatable, Identifiable {
    var firstItem: String?
    var firstAttribute: String
    var relation: String?
    var secondItem: String?
    var secondAttribute: String?
    var multiplier: String?
    let priority: Float?
    var constant: Float?
    let identifier: String?
    let id: String
}

func reverseFirstAndSecondItemIfNeededWithHierarchy(_ hierarchy: [HierarchyElement], constraint: ConverterConstraint) -> ConverterConstraint {
    guard let secondItem = constraint.secondItem else { return constraint }
    let firstItemViewId = hierarchy.first { $0.eId == constraint.firstItem }?.vId ?? constraint.firstItem
    let secondItemViewId = hierarchy.first { $0.eId == secondItem }?.vId ?? secondItem
    let firstItemIndex: Int = hierarchy.firstIndex(where: { $0.eId == firstItemViewId })!
    let secondItemIndex: Int = hierarchy.firstIndex(where: { $0.eId == secondItemViewId })!
    let shouldReverse = firstItemIndex < secondItemIndex
    return shouldReverse ? reverseFirstAndSecondItemIfNeeded(constraint) : constraint
}

func reverseFirstAndSecondItemIfNeeded(_ constraint: ConverterConstraint) -> ConverterConstraint {
    guard let secondItem = constraint.secondItem else { return constraint }
    guard let secondItemAttribute = constraint.secondAttribute else { return constraint }
    let newFirstItem = secondItem
    let newFirstLayoutGuide = constraint.secondLayoutGuide
    let newFirstItemAttribute = secondItemAttribute
    let newSecondItem = constraint.firstItem
    let newSecondLayoutGuide = constraint.firstLayoutGuide
    let newSecondAttribute = constraint.firstAttribute
    let newRelation: String? = {
        guard let relation = constraint.relation else { return nil }
        return switch relation {
        case "greaterThanOrEqual": "lessThanOrEqual"
        case "lessThanOrEqual": "greaterThanOrEqual"
        default: relation
        }
    }()
    let newMultiplier: String? = {
        guard let multiplier = constraint.multiplier else { return nil }
        let multiplierFloat = Float(multiplier)
        return if let multiplierFloat {
            .init(1 / multiplierFloat)
        } else {
            multiplier.components(separatedBy: ":").reversed().joined(separator: ":")
        }
    }()
    let newConstant: Float? = {
        guard let constant = constraint.constant else { return nil }
        guard let multiplier = constraint.multiplier else { return constant * -1 }
        let multiplierFloat = Float(multiplier)
        if let multiplierFloat {
            return multiplierFloat * constant * -1
        } else {
            let componentsOfIntegers = multiplier.components(separatedBy: ":").map { Float($0)! }
            let value = componentsOfIntegers[0] / componentsOfIntegers[1]
            return value * constant * -1
        }
    }()
    return .init(
        ownerItem: constraint.ownerItem,
        firstItem: newFirstItem,
        firstLayoutGuide: newFirstLayoutGuide,
        firstAttribute: newFirstItemAttribute,
        relation: newRelation,
        secondItem: newSecondItem,
        secondLayoutGuide: newSecondLayoutGuide,
        secondAttribute: newSecondAttribute,
        multiplier: newMultiplier,
        priority: constraint.priority,
        constant: newConstant,
        identifier: constraint.identifier,
        id: constraint.id,
    )
}
