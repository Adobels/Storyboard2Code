//
//  File.swift
//  story2code
//
//  Created by Blazej Sleboda on 13/06/2025.
//

import StoryboardDecoder
import Testing
@testable import story2code

@Test func widthConstraint() throws {

    let constraintParentId = "3Sv-A6-VJG"

    let arrayRootViewFlattened: [ViewPropertiesForParsing] = [
        .init(id: "Roo-tVi-ew", customClass: nil, elementClass: "View", verticalPositionIndex: 0),
        .init(id: "3Sv-A6-VJG", customClass: "CustomButton", elementClass: "Button", verticalPositionIndex: 1),
        .init(id: "Xzz-WF-HQg", customClass: "CustomLabel", elementClass: "Label", verticalPositionIndex: 2)
    ]
    let arraylayoutGuideIdToParentViewId: [LayoutGuideIdToParentViewId] = [
        .init(layoutGuideId: "Xzz-WF-HQg", parentViewId: "JK-DDD-ZZa")
    ]
    let constraint = S2CConstraint(constraintParentViewId: "3Sv-A6-VJG", firstItem: nil, firstAttribute: .trailing, relation: .greaterThanOrEqual, secondItem: "3Sv-A6-VJG", secondAttribute: .trailing, multiplier: "2", priority: 751, constant: 20, identifier: "constraintTrailing", id: "DlH-ew-zE1")

    let result = constraint.convertToCode(parentId: constraintParentId, flattenedHierarchy: arrayRootViewFlattened, layoutGuideToParentViewId: arraylayoutGuideIdToParentViewId)
    #expect( result ==
            ("Xzz-WF-HQg", "$0.trailingAnchor.constraint(greaterThanOrEqual: 3Sv-A6-VJG.trailing, multiplier: 2, priority: 751, constant: 20, identifier: \"constraintTrailing\"")
    )
}

@Test func widthConstraint2() throws {

    let constraintParentId = "3Sv-A6-VJG"

    let arrayRootViewFlattened: [ViewPropertiesForParsing] = [
        .init(id: "Roo-tVi-ew", customClass: nil, elementClass: "View", verticalPositionIndex: 0),
        .init(id: "3Sv-A6-VJG", customClass: "CustomButton", elementClass: "Button", verticalPositionIndex: 1),
        .init(id: "Xzz-WF-HQg", customClass: "CustomLabel", elementClass: "Label", verticalPositionIndex: 2)
    ]
    let arraylayoutGuideIdToParentViewId: [LayoutGuideIdToParentViewId] = [
        .init(layoutGuideId: "Xzz-WF-HQg", parentViewId: "JK-DDD-ZZa")
    ]
    let constraint = S2CConstraint(firstItem: "Xzz-WF-HQg", firstAttribute: .trailing, relation: .greaterThanOrEqual, secondItem: "3Sv-A6-VJG", secondAttribute: .trailing, multiplier: "2", priority: 751, constant: 20, identifier: "constraintTrailing", id: "DlH-ew-zE1")

    let result = constraint.convertToCode(parentId: constraintParentId, flattenedHierarchy: arrayRootViewFlattened, layoutGuideToParentViewId: arraylayoutGuideIdToParentViewId)
    #expect( result ==
            ("Xzz-WF-HQg", "$0.trailingAnchor.constraint(greaterThanOrEqual: 3Sv-A6-VJG.trailing, multiplier: 2, priority: 751, constant: 20, identifier: \"constraintTrailing\"")
    )
}

