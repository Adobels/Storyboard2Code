//
//  generateHierarchyOfConstraintItemOwnersOf.swift
//  story2code
//
//  Created by Blazej Sleboda on 19/07/2025.
//

import StoryboardDecoder

func generateHierarchyOfConstraintItemOwnersOf(rootView: ViewProtocol) -> [HierarchyElement] {
    var result = [HierarchyElement]()
    _ = rootView.browse { element in
        guard let element = element as? ViewProtocol else { return true }
        result.append(.init(eId: element.id, vId: element.id, lgKey: nil))
        if let safeArea = element.safeArea {
            result.append(.init(eId: safeArea.id, vId: element.id, lgKey: .safeArea))
        }
        if let keyboard = element.keyboard {
            result.append(HierarchyElement(eId: keyboard.id, vId: element.id, lgKey: .keyboard))
        }
        if let scrollView = element as? ScrollView {
            if let content = scrollView.contentLayoutGuide {
                result.append(HierarchyElement(eId: content.id, vId: element.id, lgKey: .content))
            }
            if let frame = scrollView.frameLayoutGuide {
                result.append(HierarchyElement(eId: frame.id, vId: element.id, lgKey: .frame))
            }
        }
        return true
    }
    return result
}

struct HierarchyElement: Equatable {
    /// elementID. elementID are referenced by a constraint firstItem or secondItem
    let eId: ConstraintOwnerId
    let vId: ViewId
    let lgKey: LayoutGuideKey?
}

typealias ConstraintOwnerId = String
typealias ViewId = String

