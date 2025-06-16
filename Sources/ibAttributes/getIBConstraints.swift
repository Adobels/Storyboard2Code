//
//  getIBConstraints.swift
//  story2code
//
//  Created by Blazej Sleboda on 11/06/2025.
//

import StoryboardDecoder

// xxxxx self.lgyyyy
// xxxxx viewddd.lgyyyy
// xxxxx $0.lgyyyy
/*

@MainActor
func getIBConstraints(of view: ViewProtocol) -> [String] {
    var attributes: [String] = []
    let viewId: String = (view as! IBIdentifiable).id
    view.constraints?.forEach { constraint in
        var strings: [String] = []
        if constraint.firstItem == nil, constraint.secondItem == nil {
 
        } else if constraint.firstItem == nil {
            strings.append("$0." + constraintLayoutAttribute(constraint.firstAttribute) + ".")
            strings.append("(")
            strings.append(sanitizedOutletName(from: constraint.secondItem)! + ".")
            strings.append(constraintLayoutAttribute(constraint.secondAttribute))
            if let constant = constraint.constant {
                strings.append(", constant: \(constant)")
            }
            strings.append(")")
            if let priority = constraint.priority {
                strings.append(".ibPriority(.init(\(priority)))")
            }
            if let identifier = constraint.identifier {
                strings.append(".ibIdentifier(\(identifier))")
            }
        } else {
            return
        }
        _ = {
            guard let outlet = (Context.shared.ibOutlet.filter { $0.destination == constraint.id }.first) else { return }
            strings.append(".ibOutlet(&\(outlet.id)-\(outlet.property))")
        }()
        if !strings.isEmpty {
            if let firstItem = constraint.firstItem {
                Context.shared.ibViews.insert(sanitizedOutletName(from: firstItem)!)
            }
            if let secondItem = constraint.secondItem {
                Context.shared.ibViews.insert(sanitizedOutletName(from: secondItem)!)
            }
        }
        attributes.append(strings.joined(separator: ""))
    }

    var constraintsWithBothItems: [Constraint] = Context.shared.rootView.children(of: Constraint.self, recursive: true).filter {
        $0.firstItem == viewId || $0.firstItem == (view as? View)?.viewLayoutGuide?.id
    }
    constraintsWithBothItems.forEach {
        attributes.append(getConstraintLine(constraintWithBothItems: $0))
    }
    func getConstraintLine(constraintWithBothItems: Constraint) -> String {
        guard
            let constraintFirstItem = constraintWithBothItems.firstItem,
            let constraintSecondItem = constraintWithBothItems.secondItem
        else { fatalError() }
        var strings: [String] = []
        var firstItem = sanitizedOutletName(from: constraintFirstItem)!
        Context.shared.rootView.browse { element in
            guard let view = element as? ViewProtocol else {
                return true
            }
            if let layoutGuide = view.with(id: constraintWithBothItems.firstItem!) as LayoutGuide? {
                if layoutGuide.key == "safeArea" {
                    firstItem = "\(sanitizedOutletName(from: (view as! IBIdentifiable).id)!).safeAreaLayoutGuide"
                } else if layoutGuide.key == "keyboard" {
                    firstItem = "\(sanitizedOutletName(from: (view as! IBIdentifiable).id)!).keyboardLayoutGuide"
                } else {
                    fatalError()
                }
                return false
            }
            return true
        }

        var secondItem = sanitizedOutletName(from: constraintWithBothItems.secondItem)!
        Context.shared.rootView.browse { element in
            guard let view = element as? ViewProtocol else {
                return true
            }
            if let layoutGuide = view.with(id: constraintWithBothItems.secondItem!) as LayoutGuide? {
                if layoutGuide.key == "safeArea" {
                    secondItem = "\(sanitizedOutletName(from: (view as! IBIdentifiable).id)!).safeAreaLayoutGuide"
                } else if layoutGuide.key == "keyboard" {
                    secondItem = "\(sanitizedOutletName(from: (view as! IBIdentifiable).id)!).keyboardLayoutGuide"
                } else {
                    fatalError()
                }
                return false
            }
            return true
        }
        strings.append("\(firstItem + ".")")
        strings.append(constraintLayoutAttribute(constraintWithBothItems.firstAttribute) + ".")
        strings.append(printConstraintRelationOpen(constraintWithBothItems.relation))
        strings.append("\(secondItem + ".")")
        strings.append(constraintLayoutAttribute(constraintWithBothItems.secondAttribute))
        let shouldInvertConstraint = shouldInvertConstraint(owner: view, firstElement: firstItem, secondElement: secondItem)
        if let constant = constraintWithBothItems.constant {
            strings.append(", constant: \(constant)")
        }
        strings.append(printConstraintRelationClose())
        if let priority = constraintWithBothItems.priority {
            strings.append(".ibPriority(.init(\(priority)))")
        }
        if let identifier = constraintWithBothItems.identifier {
            strings.append(".ibIdentifier(\(identifier))")
        }
        return strings.joined()
    }

    return attributes
}

func printConstraintRelationClose() -> String { ")" }

func parseConstraint(_ constraint: Constraint) -> [String] {
    var strings = [String]()
    if constraint.firstItem == nil {
        strings.append("$0")
    }
    strings.append(constraintLayoutAttribute(constraint.firstAttribute))
    return strings
}
*/
