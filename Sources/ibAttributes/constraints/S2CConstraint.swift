//
//  S2CConstraint.swift
//  story2code
//
//  Created by Blazej Sleboda on 17/07/2025.
//


import StoryboardDecoder
import math_h

struct S2CConstraint {

    var firstItem: String?
    var firstAttribute: Constraint.LayoutAttribute
    var relation: Constraint.Relation
    var secondItem: String?
    var secondAttribute: Constraint.LayoutAttribute?
    let multiplier: String?
    let priority: Float?
    var constant: Float?
    let identifier: String?
    let id: String

    mutating func convertToCode(with context: ContextForIBConstraints) -> (viewId: String, constraint: String) {
        if let code = convertConstraintWidthOrHeightToUIViewKitCode() {
            return (sanitizedOutletName(from: firstItem ?? context.constraintParentViewId)!, code)
        } else if let code = convertConstraintRelationBetweenItemsUIViewKitCode(with: context) {
            return code
        } else {
            fatalError()
        }
    }

    func stringOrNil(from object: Any?) -> String? {
        if let object {
            "\(object)"
        } else {
            nil
        }
    }

    fileprivate func extractedFunc1(_ firstItemLayoutGuide: ContextForIBConstraints.LayoutGuideIdToParentViewId?, _ secondItem: String, _ secondItemLayoutGuide: ContextForIBConstraints.LayoutGuideIdToParentViewId?, _ firstItem: String) -> (viewId: String, String)? {
        convertResolvedConstraintToCode(
            resolvedFirstItem: firstItem,
            resolvedFirstItemLayoutGuideKey: storyboardLayoutGuideKeyToCode(firstItemLayoutGuide?.layoutGuideKey),
            resolvedFirstAttribute: "\(firstAttribute)",
            relation: stringOrNil(from: relation),
            resolvedSecondItem: secondItem,
            resolvedSecondItemLayoutGuideKey: stringOrNil(from: secondItemLayoutGuide?.layoutGuideKey),
            resolvedSecondAttribute: { if let secondAttribute { "\(firstAttribute)" } else { nil } }(),
            constant: constant,
            multiplier: multiplier,
            priority: priority,
            identifier: identifier
        )
    }


    private mutating func convertConstraintRelationBetweenItemsUIViewKitCode(with context: ContextForIBConstraints) -> (viewId: String, String)? {
        guard secondItem != nil else { return nil }
        if firstItem == nil {
            firstItem = context.constraintParentViewId
        }
        reverseFirstAndSecondItemIfNeeded(with: context)
        let firstItemLayoutGuide: ContextForIBConstraints.LayoutGuideIdToParentViewId? = context.arrayLayoutGuideIdToParentViewId.first(where: { item in
            item.layoutGuideId == firstItem
        })
        if let firstItemLayoutGuide {
            firstItem = firstItemLayoutGuide.parentViewId
        }
        let secondItemLayoutGuide: ContextForIBConstraints.LayoutGuideIdToParentViewId? = context.arrayLayoutGuideIdToParentViewId.first(where: { item in
            item.layoutGuideId == secondItem
        })
        if let secondItemLayoutGuide {
            secondItem = secondItemLayoutGuide.parentViewId
        }
        guard var firstItem else { fatalError() }
        guard var secondItem else { fatalError() }
        let secondItemViewControlerOutlet = Context.shared.viewControllerIBOutlets.first(where: { $0.viewId == sanitizedOutletName(from: secondItem)! })
        if let secondItemViewControlerOutlet {
            secondItem = secondItemViewControlerOutlet.property
        }
        let result = extractedFunc1(firstItemLayoutGuide, secondItem, secondItemLayoutGuide, firstItem)
        if let result  {
            Context.shared.arrayConstrains.append(result)
        }
        return result
    }

    private func convertConstraintWidthOrHeightToUIViewKitCode() -> String? {
        guard secondItem == nil else { return nil }
        var components: [String] = []
        components.append("$0")
        if firstAttribute == .height {
            components.append(".heightAnchor")
        } else if firstAttribute == .width {
            components.append(".widthAnchor")
        } else {
            fatalError()
        }
        components.append(".constraint(\(relation)ToConstant: \(floatToString(constant ?? 0)))")
        if let ibPriority = convertPriorityToCode(priority) { components.append(ibPriority) }
        if let ibIdentifier = convertIdentifierToCode(identifier) { components.append(ibIdentifier) }
        return components.joined()
    }

    private mutating func reverseFirstAndSecondItemIfNeeded(with context: ContextForIBConstraints) {
        guard needReverseFirstAndSecondItem(with: context) else { return }
        let firstItem = firstItem ?? context.constraintParentViewId
        let tmpFirstAttribute = firstAttribute
        self.firstItem = secondItem!
        self.firstAttribute = secondAttribute!
        self.secondItem = firstItem
        self.secondAttribute = tmpFirstAttribute
        if let constant { self.constant = -constant }
        switch relation {
        case .lessThanOrEqual: relation = .greaterThanOrEqual
        case .greaterThanOrEqual: relation = .lessThanOrEqual
        case .equal, .other: break
        }
    }

    private func needReverseFirstAndSecondItem(with context: ContextForIBConstraints) -> Bool {
        guard let secondItem else { return false }
        let firstItemResolved = context.arrayLayoutGuideIdToParentViewId.first { item in
            item.layoutGuideId == firstItem
        }?.parentViewId ?? firstItem ?? context.constraintParentViewId
        let firstItemIndex = context.arrayRootViewFlattened.firstIndex(where: { item in
            item.id == firstItemResolved
        })!

        let secondItemResolved = context.arrayLayoutGuideIdToParentViewId.first { item in
            item.layoutGuideId == secondItem
        }?.parentViewId ?? secondItem
        let secondItemIndex = context.arrayRootViewFlattened.firstIndex { item in
            item.id == secondItemResolved
        }!
        return firstItemIndex < secondItemIndex
    }

//    private func storyboardLayoutGuideKeyToCode(_ layoutGuide: LayoutGuideIdToParentViewId) -> String {
//        switch layoutGuide.layoutGuideKey {
//        case "safeArea": "safeAreaLayoutGuide"
//        case "keyboard": "keyboardLayoutGuide"
//        default: fatalError()
//        }
//    }
}
