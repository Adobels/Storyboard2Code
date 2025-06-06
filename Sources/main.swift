//
//  main.swift
//  story2code
//
//  Created by Blazej Sleboda on 20/03/2025.
//

import Foundation
import StoryboardDecoder

let url = Bundle.module.url(forResource: "PlaceholderAccount", withExtension: "xml")!
let sb = try! StoryboardFile(url: url)
let initialScene = sb.document.scenes!.first!
let vc: AnyViewController = initialScene.viewController!
printViewControllerRootView(initialScene.viewController!)

class Context: @unchecked Sendable {

    static let shared: Context = .init()

    private init() {}

    var rootViewProtocol: ViewProtocol!
    var rootViewAny: AnyView!
    var rootView: View!
    var variableViewIbOutlet: [(viewId: String, viewClass: String)] = []

    var ibOutlet: [Outlet] = []
    var ibAction: [Action] = []
    var ibViews: Set<String> = []
}

/*printView(elements: vc.viewController.rootView!.subviews!)

let cells = vc.children(of: TableViewCell.self)
let rrr = vc.children(of: AnyView.self, recursive: true)
let fcell = cells[0]
let subviews = fcell.contentView

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

*/



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
func printViewControllerRootView(_ anyViewController: AnyViewController) {
    guard let vc = anyViewController.viewController as? ViewController else {
        print("wrong view controller")
        return
    }
    let rootView: View = vc.rootView as! View
    let elements = rootView.subviews!
    Context.shared.rootView = rootView
    Context.shared.rootViewProtocol = vc.rootView!
    Context.shared.ibOutlet = rootView.allConnections.compactMap { $0.connection as? Outlet }
    Context.shared.ibAction = rootView.allConnections.compactMap { $0.connection as? StoryboardDecoder.Action }
    guard !elements.isEmpty else { return }
    print(indent(of: level) + ".ibSubviews {")
    elements.forEach { element in
        let elementClass = element.view.customClass ?? element.view.elementClass
        let elementId = sanitizedOutletName(from: (element.view as! IBIdentifiable).id)!
        print("\(elementClass)() // \(elementId)!) userLabel: \(element.view.userLabel) key: \(element.view.key) safeArea: \(sanitizedOutletName(from: (element as? View)?.viewLayoutGuide?.id))")
        Context.shared.variableViewIbOutlet.append((viewId: elementId, viewClass: elementClass))
        getIbOutlet(of: element.view)
        let subviews = element.view.subviews
        if let subviews, subviews.count > 0 {
            printView(elements: subviews, level: level + 1)
        }
        printIbAttributes(of: element)
    }
    print(indent(of: level) + "}")
//    let ibViews = Context.shared.ibViews.reduce([String]()) { partialResult, ibView in
//        if (partialResult.contains(where: { alreadyAddedIBView in
//            alreadyAddedIBView == ibView
//        })) {
//            return partialResult
//        } else {
//            return partialResult + [ibView]
//        }
//    }
    Context.shared.ibViews.forEach { ibViewId in
        let variableIsNeeded = Context.shared.variableViewIbOutlet.first { (viewId: String, viewClass: String) in
            viewId == ibViewId
        }
        if let variableIsNeeded {
            print("var \(variableIsNeeded.viewId): \(variableIsNeeded.viewClass)")
        }
    }
}

@MainActor
func printView(elements: [AnyView], level: Int = 0) {
    guard !elements.isEmpty else { return }
    print(indent(of: level) + ".ibSubviews {")
    elements.forEach { element in
        let elementClass = element.view.customClass ?? element.view.elementClass
        let elementId = sanitizedOutletName(from: (element.view as! IBIdentifiable).id)!
        print("\(elementClass)() // \(elementId)!) userLabel: \(element.view.userLabel) key: \(element.view.key) safeArea: \(sanitizedOutletName(from: (element as? View)?.viewLayoutGuide?.id))")
        Context.shared.variableViewIbOutlet.append((viewId: elementId, viewClass: elementClass))
        getIbOutlet(of: element.view)
        let subviews = element.view.subviews
        if let subviews, subviews.count > 0 {
            printView(elements: subviews, level: level + 1)
        }
        printIbAttributes(of: element)
    }
    print(indent(of: level) + "}")
}

@MainActor
func printIbAttributes(of element: AnyView) {
    var attributes = [String]()
    let constraints = getIBConstraints(of: element.view)
    if !constraints.isEmpty {
        attributes.append(" // ibOutlet: \(sanitizedOutletName(from: (element.view as! IBIdentifiable).id)!)")
        attributes.append(contentsOf: getIBConstraints(of: element.view))
    }
    attributes.append(contentsOf: getIBActions(of: element.view))
    attributes.append(contentsOf: getIbOutlet(of: element.view))
    if let label = element.view as? Label {
        attributes.append(contentsOf: parseIbAttributes(of: label))
    }
    if let button = element.view as? Button {
        //TODO: Add parsing for UIButton subclass attributes
    }
    if let imageView = element.view as? ImageView {
        attributes.append(contentsOf: parseImageView(of: imageView))
    }
    if let tableViewCell = element.view as? TableViewCell {
        //TODO: Add parsing for UITableViewCell subclass attributes
    }
    if let stackView = element.view as? StackView {
        attributes.append(contentsOf: parseStackViewAttributes(stackView))
    }
    if let textField = element.view as? TextField {
        //TODO: Add parsing for UITextField subclass attributes
    }
    if let tableView = element.view as? TableView {
        //TODO: Add parsing for TableView subclass attributes
    }
    if let uiswitch = element.view as? Switch {
        //TODO: Add parsing for Switch subclass attributes
    }
    if let scrollView = element.view as? ScrollView {
        //TODO: Add parsing for ScrollView subclass attributes
    }
    if let collectionViewcell = element.view as? CollectionViewCell {
        //TODO: Add parsing for UICollectionViewCell
    }
    if let datePicker = element.view as? DatePicker {
        //TODO: Add parsing for UIDatePicker
    }
    if let textView = element.view as? TextView {
        //TODO: Add parsing for UITextView
    }
    if let pageControl = element.view as? PageControl {
        //TODO: Add parsing for UIPageControl
    }
    if let collectionView = element.view as? CollectionView {
        //TODO: Add parsing for UICollectionView
    }
    if let pickerView = element.view as? PickerView {
        //TODO: Add parsing for UIPickerView
    }
    if let activityIndicatorView = element.view as? ActivityIndicatorView {
        //TODO: Add parsing for UIActivityIndicatorView
    }
    attributes.append(contentsOf: parseIbAttributes(of: element.view))
    printIbAttributes(attributes)
}

@MainActor
func getIBConstraints(of view: ViewProtocol) -> [String] {
    var attributes: [String] = []
    let viewId: String = (view as! IBIdentifiable).id
    view.constraints?.forEach { constraint in
        if constraint.firstItem == nil, constraint.secondItem == nil {
            if constraint.firstAttribute == .width {
                attributes.append("widthAnchor.constraint(equalToConstant: \(constraint.constant!))")
            } else if constraint.firstAttribute == .height {
                attributes.append("heightAnchor.constraint(equalToConstant: \(constraint.constant!))")
            }
        } else {
            var strings: [String] = []
            if constraint.firstItem == nil {
                strings.append(constraintLayoutAttribute(constraint.firstAttribute) + ".")
                strings.append(printConstraintRelationOpen(constraint.relation))
                strings.append(sanitizedOutletName(from: constraint.secondItem)! + ".")
                strings.append(constraintLayoutAttribute(constraint.secondAttribute))
                if let constant = constraint.constant {
                    strings.append(", constant: \(constant)")
                }
                strings.append(printConstraintRelationClose())
                if let priority = constraint.priority {
                    strings.append(".ibPriority(.init(\(priority))")
                }
                if let identifier = constraint.identifier {
                    strings.append(".ibIdentifier(\(identifier)")
                }
//                let currentConstraint: Constraint = $0
//                currentConstraint.id
//                view.connections?.compactMap { $0.connection as? Outlet }.map { "ibOutlet(\($0)" }.joined(separator: ".")
                /*if let outlet = view.connections?.filter { ($0 as? Outlet)? }.first {
                    strings.append("ibOutlet(&\(sanitizedOutletName(from: outlet))")
                }*/
                /*attributes.append("$0.\(constraintLayoutAttribute(constraint.firstAttribute))\(printConstraintRelationOpen(constraint.relation)) \(sanitizedOutletName(from: constraint.secondItem)!)\(constraintLayoutAttribute(constraint.secondAttribute)) \(constraint.constant) \(constraint.priority) \(constraint.identifier)")*/
            } else {
                strings.append("\(sanitizedOutletName(from: constraint.firstItem)! + ".")")
                strings.append(constraintLayoutAttribute(constraint.firstAttribute) + ".")
                strings.append(printConstraintRelationOpen(constraint.relation))
                strings.append("\(sanitizedOutletName(from: constraint.secondItem!)! + ".")")
                strings.append(constraintLayoutAttribute(constraint.secondAttribute))
                if let constant = constraint.constant {
                    strings.append(", constant: \(constant)")
                }
                strings.append(printConstraintRelationClose())
                if let priority = constraint.priority {
                    strings.append(".ibPriority(.init(\(priority))")
                }
                if let identifier = constraint.identifier {
                    strings.append(".ibIdentifier(\(identifier)")
                }
                //attributes.append("\(sanitizedOutletName(from: constraint.firstItem)) \(constraint.firstAttribute) \(sanitizedOutletName(from: constraint.secondItem)) \(constraint.secondAttribute) \(constraint.constant) \(constraint.priority) \(constraint.identifier)")
            }
            _ = {
                guard let outlet = (Context.shared.ibOutlet.filter { $0.destination == constraint.id }.first) else { return }
                strings.append(".ibOutlet(&\(outlet.id)-\(outlet.property)")
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
            output.append("ibOutlet(&\(sanitizedOutletName(from: outlet.destination))" + "."  + "\(outlet.property)" + ")")
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


func sanitizedOutletName(from outletName: String?) -> String? {

    guard let outletName else {
        return outletName
    }
    // Remove digits
    let noDigits = outletName.replacingOccurrences(of: "[0-9]", with: "", options: .regularExpression)

    // Replace hyphens with underscores
    let withUnderscores = noDigits.replacingOccurrences(of: "-", with: "_")

    // Split into components using non-letter and non-underscore characters
    let components = withUnderscores
        .components(separatedBy: CharacterSet.letters.union(.init(charactersIn: "_")).inverted)
        .filter { !$0.isEmpty }

    guard !components.isEmpty else { return "unnamedOutlet" }

    // Assemble variable name: preserve leading underscores, camelCase the rest
    var variableName = components[0].lowercased()
    for component in components.dropFirst() {
        variableName += component.capitalized
    }

    return variableName
}
