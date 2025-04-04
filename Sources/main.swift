//
//  main.swift
//  story2code
//
//  Created by Blazej Sleboda on 20/03/2025.
//

import Foundation
import IBDecodable

let url = Bundle.module.url(forResource: "storyboard", withExtension: "xml")!
let sb = try! StoryboardFile(url: url)
let initialScene = sb.document.scenes!.first!
let vc = initialScene.viewController!

let cells = vc.children(of: TableViewCell.self)
let rrr = vc.children(of: AnyView.self, recursive: true)
let fcell = cells[0]
let subviews = fcell.contentView
let anyViews = subviews.children(of: AnyView.self, recursive: true)

//anyViews.forEach {
//    guard let ee: ImageView = $0.with(id: "FlV-QM-mBo") else { return }
//    print(ee)
//    if let key: Label = $0.with(key: "label") {
//        print(key)
//    }
//}
//
//for anyView in anyViews {
//    print("\(anyView.view.customClass ??  anyView.view.elementClass)")
//}

print("Cell: \(fcell.customClass)")
printView(elements: fcell.subviews!)
//printView(elements: subviews.subviews!)
//let result = subviews.browse { element in
//    guard let view = element as? AnyView else {
//        return true
//    }
//    let velement = view as? View
//    let elementClass = (element as? AnyView)?.view.elementClass
//    let customClass = (element as? AnyView)?.view.customClass
//    //print(elementClass, customClass)
//
//    return true
//}
//print(result)

var level = 0

@MainActor
func printView(elements: [AnyView], level: Int = 0) {
    guard !elements.isEmpty else { return }
    print(indent(of: level) + ".ibSubviews {")
    elements.forEach { element in
        let elementClass = element.view.customClass ?? element.view.elementClass
        print("\(elementClass)() // \((element.view as! IBIdentifiable).id) userLabel: \(element.view.userLabel) key: \(element.view.key) safeArea: \((element as? View)?.viewLayoutGuide?.id)")
        getIbOutlet(of: element.view)
        let viewChildren = element.children(of: AnyView.self)
        if viewChildren.count > 1 {
            printView(elements: viewChildren, level: level + 1)
        }
        printIbAttributes(of: element)
    }
    print(indent(of: level) + "}")
}

@MainActor
func printIbAttributes(of element: AnyView) {
    var attributes = [String]()
    attributes.append(" // id: \((element.view as! IBIdentifiable).id)")
    attributes.append(contentsOf: getIBConstraints(of: element.view))
    attributes.append(contentsOf: getIBActions(of: element.view))
    attributes.append(contentsOf: getIbOutlet(of: element.view))
    attributes.append(contentsOf: parseIbAttributes(of: element.view))
    if let uilabel = element.view as? Label {
        attributes.append(contentsOf: parseIbAttributes(of: uilabel))
    }
    printIbAttributes(attributes)
}

@MainActor
func getIBConstraints(of view: ViewProtocol) -> [String] {
    var attributes: [String] = []
    view.constraints?.forEach {
        if $0.firstItem == nil, $0.secondItem == nil {
            if $0.firstAttribute == .width {
                attributes.append("widthAnchor.constraint(equalToConstant: \($0.constant!))")
            } else if $0.firstAttribute == .height {
                attributes.append("heightAnchor.constraint(equalToConstant: \($0.constant!))")
            }
        } else {
            attributes.append("\($0.firstItem) \($0.firstAttribute) \($0.secondItem) \($0.secondAttribute) \($0.constant) \($0.priority) \($0.identifier)")
        }
    }
    return attributes
}

@MainActor
func printIbAttributes(_ attributes: [String]) {
    let allAttributes = (attributes).map { "$0." + $0 }.joined(separator: "\n")
    print(".ibAttributes {\n" + allAttributes + "\n}")
}

@MainActor
func getIbOutlet(of element: ViewProtocol) -> [String] {
    guard let connections = element.connections else { return [] }
    let outlets = (connections.compactMap { $0.connection as? Outlet })
    var output = [String]()
    if !outlets.isEmpty {
        outlets.forEach { outlet in
            output.append("ibOutlet(&\(outlet.destination)" + "."  + "\(outlet.property)" + ")")
        }
    }
    return output
}

@MainActor
func getIBActions(of element: ViewProtocol) -> [String] {
    guard let connections = element.connections else { return [] }
    let actions = (connections.compactMap { $0.connection as? Action })
    var actionsToReturn: [String] = []
    if !actions.isEmpty {
        actions.forEach { action in
            actionsToReturn.append("addTarget(\(action.destination)" + ", action: #selector(\(action.selector)), for: .\(action.eventType!))")
        }
    }
    return actionsToReturn
}

func indent(of count: Int) -> String {
    [String].init(repeating: " ", count: count).joined()
}
