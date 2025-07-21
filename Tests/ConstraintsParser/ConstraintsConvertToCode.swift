//
//  File.swift
//  story2code
//
//  Created by Blazej Sleboda on 13/06/2025.
//

import Foundation
import StoryboardDecoder
import Testing
@testable import story2code

@MainActor @Test(.disabled("check the file")) func widthConstraint() throws {
    let url = Bundle.module.url(forResource: "Biometrics", withExtension: "xml")!
    let sb = try! StoryboardFile(url: url)
    let initialScene = sb.document.scenes!.first!
    convertStoryboard2Code(initialScene.viewController!)

    let expectedArrayConstrains = [
        (viewId: "qf_uh_shm", "$0.topAnchor.constraint(equalTo: per_y_qqk.topAnchor)"),
        (viewId: "qf_uh_shm", "$0.leadingAnchor.constraint(equalTo: per_y_qqk.leadingAnchor)"),
        (viewId: "qf_uh_shm", "$0.trailingAnchor.constraint(equalTo: per_y_qqk.trailingAnchor)"),
        (viewId: "qf_uh_shm", "$0.bottomAnchor.constraint(equalTo: per_y_qqk.bottomAnchor)"),
    ]
    let arrayConstraints = Context.shared.arrayConstrains.filter { $0.viewId == "qf_uh_shm" }
    #expect(arrayConstraints.count == 4)
    arrayConstraints.forEach { item in
        let result = expectedArrayConstrains.contains {
            itemExpected in item.constraintId == itemExpected.1
        }
        #expect(result, Comment(rawValue: item.code))
    }
}
func isEqual(_ lhs: (viewId: String, String), _ rhs: (viewId: String, String)) -> Bool {
    lhs.viewId == rhs.viewId || lhs.1 == rhs.1
}

/*

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
*/
//@Test func widthConstraint2() throws {
//
//    let constraintParentId = "3Sv-A6-VJG"
//
//    let arrayRootViewFlattened: [ViewPropertiesForParsing] = [
//        .init(id: "Roo-tVi-ew", customClass: nil, elementClass: "View", verticalPositionIndex: 0),
//        .init(id: "3Sv-A6-VJG", customClass: "CustomButton", elementClass: "Button", verticalPositionIndex: 1),
//        .init(id: "Xzz-WF-HQg", customClass: "CustomLabel", elementClass: "Label", verticalPositionIndex: 2)
//    ]
//    let arraylayoutGuideIdToParentViewId: [LayoutGuideIdToParentViewId] = [
//        .init(layoutGuideId: "Xzz-WF-HQg", parentViewId: "JK-DDD-ZZa")
//    ]
//    let constraint = S2CConstraint(firstItem: "Xzz-WF-HQg", firstAttribute: .trailing, relation: .greaterThanOrEqual, secondItem: "3Sv-A6-VJG", secondAttribute: .trailing, multiplier: "2", priority: 751, constant: 20, identifier: "constraintTrailing", id: "DlH-ew-zE1")
//
//    let result = constraint.convertToCode(parentId: constraintParentId, flattenedHierarchy: arrayRootViewFlattened, layoutGuideToParentViewId: arraylayoutGuideIdToParentViewId)
//    #expect( result ==
//            ("Xzz-WF-HQg", "$0.trailingAnchor.constraint(greaterThanOrEqual: 3Sv-A6-VJG.trailing, multiplier: 2, priority: 751, constant: 20, identifier: \"constraintTrailing\"")
//    )
//}
//
