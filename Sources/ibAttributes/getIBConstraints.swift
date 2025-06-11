//
//  getIBConstraints.swift
//  story2code
//
//  Created by Blazej Sleboda on 11/06/2025.
//

import StoryboardDecoder

func getIBConstraints(of view: ViewProtocol) -> [String] {
    var attributes: [String] = []
    let viewId: String = (view as! IBIdentifiable).id
    view.constraints?.forEach { constraint in
        if constraint.firstItem == nil, constraint.secondItem == nil {
            if constraint.firstAttribute == .width {
                attributes.append("$0.widthAnchor.constraint(equalToConstant: \(constraint.constant!))")
            } else if constraint.firstAttribute == .height {
                attributes.append("$0.heightAnchor.constraint(equalToConstant: \(constraint.constant!))")
            }
        } else {
            var strings: [String] = []
            if constraint.firstItem == nil {
                strings.append("$0." + constraintLayoutAttribute(constraint.firstAttribute) + ".")
                strings.append(printConstraintRelationOpen(constraint.relation))
                strings.append(sanitizedOutletName(from: constraint.secondItem)! + ".")
                strings.append(constraintLayoutAttribute(constraint.secondAttribute))
                if let constant = constraint.constant {
                    strings.append(", constant: \(constant)")
                }
                strings.append(printConstraintRelationClose())
                if let priority = constraint.priority {
                    strings.append(".ibPriority(.init(\(priority)))")
                }
                if let identifier = constraint.identifier {
                    strings.append(".ibIdentifier(\(identifier))")
                }
            } else {
                var firstItem = sanitizedOutletName(from: constraint.firstItem)!
                Context.shared.rootView.browse { element in
                    guard let view = element as? ViewProtocol else {
                        return true
                    }
                    if let layoutGuide = view.with(id: constraint.firstItem!) as LayoutGuide? {
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
                var secondItem = sanitizedOutletName(from: constraint.secondItem)!
                Context.shared.rootView.browse { element in
                    guard let view = element as? ViewProtocol else {
                        return true
                    }
                    if let layoutGuide = view.with(id: constraint.secondItem!) as LayoutGuide? {
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
                strings.append(constraintLayoutAttribute(constraint.firstAttribute) + ".")
                strings.append(printConstraintRelationOpen(constraint.relation))
                strings.append("\(secondItem + ".")")
                strings.append(constraintLayoutAttribute(constraint.secondAttribute))
                if let constant = constraint.constant {
                    strings.append(", constant: \(constant)")
                }
                strings.append(printConstraintRelationClose())
                if let priority = constraint.priority {
                    strings.append(".ibPriority(.init(\(priority)))")
                }
                if let identifier = constraint.identifier {
                    strings.append(".ibIdentifier(\(identifier))")
                }
                //attributes.append("\(sanitizedOutletName(from: constraint.firstItem)) \(constraint.firstAttribute) \(sanitizedOutletName(from: constraint.secondItem)) \(constraint.secondAttribute) \(constraint.constant) \(constraint.priority) \(constraint.identifier)")
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
    }
    return attributes
}
