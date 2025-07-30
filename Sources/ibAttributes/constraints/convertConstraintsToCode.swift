//
//  convertConstraintsToCode.swift
//  story2code
//
//  Created by Blazej Sleboda on 19/07/2025.
//

import StoryboardDecoder

func convertConstraintsToCode(rootView: ViewProtocol) -> [ConstraintInCode] {
    var hierarchyOfViews = [ViewProtocol]()
    _ = rootView.browse { item in
        guard let view = item as? ViewProtocol else { return true }
        hierarchyOfViews.append(view)
        return true
    }
    var allConstraints: [ConverterConstraint] = []
    _ = rootView.browse {
        guard let view = $0 as? ViewProtocol else { return true }
        view.constraints?.forEach {
            allConstraints.append(
                .init(
                    ownerItem: view.id,
                    firstItem: $0.firstItem ?? view.id,
                    firstLayoutGuide: nil,
                    firstAttribute: String(describing: $0.firstAttribute),
                    relation: stringOrNil(from: $0.relation),
                    secondItem: $0.secondItem,
                    secondLayoutGuide: nil,
                    secondAttribute: stringOrNil(from: $0.secondAttribute),
                    multiplier: $0.multiplier,
                    priority: $0.priority,
                    constant: $0.constant,
                    identifier: $0.identifier,
                    id: $0.id,
                )
            )
        }
        return true
    }
    var constraints: [ConverterConstraint] = []
    let hierarchy: [HierarchyElement] = generateHierarchyOfConstraintItemOwnersOf(rootView: rootView)
    hierarchyOfViews.reversed().forEach { view in
        var viewRelatedConstaints = allConstraints.filter { $0.firstItem == view.id || $0.secondItem == view.id }.map {
            ConverterConstraint(
                ownerItem: view.id,
                firstItem: $0.firstItem ?? view.id,
                firstLayoutGuide: nil,
                firstAttribute: String(describing: $0.firstAttribute),
                relation: stringOrNil(from: $0.relation),
                secondItem: $0.secondItem,
                secondLayoutGuide: nil,
                secondAttribute: stringOrNil(from: $0.secondAttribute),
                multiplier: $0.multiplier,
                priority: $0.priority,
                constant: $0.constant,
                identifier: $0.identifier,
                id: $0.id,
            )
        }
        _ = {
            var result: [ConverterConstraint] = []
            viewRelatedConstaints.forEach { constraint in
                if constraint.secondItem == nil {
                    result.append(constraint)
                } else {
                    let newConstraint = try! appendGuidedLayoutIfNeededToFirstItem(hierarchy: hierarchy, constraint: constraint)
                    result.append(newConstraint)
                }
            }
            viewRelatedConstaints = result
        }() as Void
        _ = {
            var result = [ConverterConstraint]()
            viewRelatedConstaints.forEach { constraint in
                let newConstraint = reverseFirstAndSecondItemIfNeededWithHierarchy(hierarchy, constraint: constraint)
                result.append(newConstraint)
            }
            viewRelatedConstaints = result
        }()
        constraints.append(contentsOf: viewRelatedConstaints)
        _ = {
            viewRelatedConstaints.forEach { constraintToRemove in
                let index = allConstraints.firstIndex { constraint in
                    constraint.id == constraintToRemove.id
                }
                if let index {
                    allConstraints.remove(at: index)
                }
            }
        }() as Void
    }
    _ = {
        var result: [ConverterConstraint] = []
        constraints.forEach { constraint in
            var constraint = constraint
            constraint.ownerItem = constraint.ownerItem
            constraint.firstItem = constraint.firstItem
            if let secondItem = constraint.secondItem {
                constraint.secondItem = secondItem
            }
            result.append(constraint)
        }
        constraints = result
    }() as Void
    assert(constraints.count == rootView.children(of: Constraint.self).count)
    var constraintsInCode: [(String, String, String)] = constraints.map { constraint in
        (
            constraint.id,
            constraint.ownerItem,
            convertAnyConstraintToCode(
                firstItem: {
                    var result = [String]()
                    if constraint.firstItem == constraint.ownerItem {
                        result.append("$0")
                    } else {
                        result.append(getPropertyNameOfIBOutletIfExists(destinationId: constraint.firstItem) ?? constraint.firstItem)
                    }
                    if let value = constraint.firstLayoutGuide {
                        result.append(value)
                    }
                    return result.joined(separator: ".")
                }(),
                firstAttribute: constraint.firstAttribute,
                relation: constraint.relation,
                secondItem: {
                    if let secondItem = constraint.secondItem {
                        var result = [String]()
                        result.append(getPropertyNameOfIBOutletIfExists(destinationId: secondItem) ?? secondItem)
                        if let secondLayoutGuide = constraint.secondLayoutGuide {
                            result.append(secondLayoutGuide)
                        }
                        return result.joined(separator: ".")
                    } else {
                        return constraint.secondItem
                    }
                }(),
                secondAttribute: constraint.secondAttribute,
                constant: constraint.constant,
                multiplier: constraint.multiplier,
                priority: constraint.priority,
                identifier: constraint.identifier,
                id: constraint.id,
            )
        )
    }
    constraintsInCode = constraintsInCode.map { constraint in
        // TODO: Improve Outlets for constraints
        let outlets = Context.shared.referencingOutletsMgr.filterOutletIDsRecursively(matchingId: constraint.0)
        var strings: [String] = []
        outlets.forEach { outlet in
            let referencingOutlet = (getPropertyNameOfIBOutletIfExists(destinationId: outlet.ownerId) ?? outlet.ownerId) + "." + outlet.property
            strings.append(".ibOutlet(&\(referencingOutlet))")
        }
        return (constraint.0, constraint.1, constraint.2 + strings.joined())
    }
    return constraintsInCode.map { .init(constraintId: $0.0, viewId: $0.1, code: $0.2) }
}

func appendGuidedLayoutIfNeededToFirstItem(hierarchy: [HierarchyElement], constraint: ConverterConstraint) throws -> ConverterConstraint {
    guard let firstItemDetails = hierarchy.first(where: { $0.eId == constraint.firstItem }) else { throw AppError.isNill }
    guard let secondItemDetails = hierarchy.first(where: { $0.eId == constraint.secondItem }) else { throw AppError.isNill }
    var constraint = constraint
    if let lgKey = firstItemDetails.lgKey {
        constraint.firstItem = firstItemDetails.vId
        constraint.firstLayoutGuide = storyboardLayoutGuideKeyToCode(required: lgKey.rawValue)
    }
    if let lgKey = secondItemDetails.lgKey {
        constraint.secondItem = secondItemDetails.vId
        constraint.secondLayoutGuide = storyboardLayoutGuideKeyToCode(required: lgKey.rawValue)
    }
    return constraint
}
