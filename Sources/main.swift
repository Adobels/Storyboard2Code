//
//  main.swift
//  story2code
//
//  Created by Blazej Sleboda on 20/03/2025.
//

import Foundation
import StoryboardDecoder

let url = Bundle.module.url(forResource: "Biometrics", withExtension: "xml")!
let sb = try! StoryboardFile(url: url)
let initialScene = sb.document.scenes!.first!
let vc: AnyViewController = initialScene.viewController!
vc.children
printViewControllerRootView(initialScene.viewController!)
print(Context.shared.output.joined(separator: "\n"))

class Context: @unchecked Sendable {

    static let shared: Context = .init()

    private init() {}

    var rootViewControllerId: String!
    var rootViewProtocol: ViewProtocol!
    var rootViewAny: AnyView!
    var rootView: View!
    var variableViewIbOutlet: [(viewId: String, viewClass: String)] = []
    var variableViewIbOutlet2: Set<String> = []
    var ibOutlet: [Outlet] = []
    var ibAction: [Action] = []
    var ibViews: Set<String> = []
    var output: [String] = []
}

@MainActor
func printViewControllerRootView(_ anyViewController: AnyViewController) {
    guard let vc = anyViewController.viewController as? ViewController else {
        Context.shared.output.append("wrong view controller")
        return
    }
    let rootView: View = vc.rootView as! View
    let elements = rootView.subviews!
    Context.shared.rootView = rootView
    Context.shared.rootViewProtocol = vc.rootView!
    Context.shared.ibOutlet = rootView.allConnections.compactMap { $0.connection as? Outlet }
    Context.shared.ibAction = rootView.allConnections.compactMap { $0.connection as? StoryboardDecoder.Action }
    Context.shared.rootViewControllerId = vc.id
    _ = {
        var destinations: Set<String> = []

        vc.allConnections.filter {
            $0.connection is Outlet || $0.connection is Action
        }.forEach { destinations.insert(sanitizedOutletName(from: $0.connection.destination)!) }
        // var variableViewIbOutlet2
        let viewsWithConstaints = vc.flattened.filter {
            let constraints = $0.children(of: Constraint.self)
            return !constraints.isEmpty
        }
        var viewIds: Set<String> = []
        viewsWithConstaints.forEach { view in
            let constaints = view.children(of: Constraint.self, recursive: false)
            _ = { view, constaints in
                constaints.forEach { constaint in
                    if let firstItem = constaint.firstItem {
                        viewIds.insert(sanitizedOutletName(from: firstItem)!)
                    } else {
                        viewIds.insert(sanitizedOutletName(from: (view as! IBIdentifiable).id)!)
                    }
                    if let secondItem = constaint.secondItem {
                        viewIds.insert(sanitizedOutletName(from: secondItem)!)
                    } else {
                        viewIds.insert(sanitizedOutletName(from: (view as! IBIdentifiable).id)!)
                    }
                }
            }(view, constaints)
        }
        let allDestinations: Set<String> = destinations.union(viewIds)
        Context.shared.variableViewIbOutlet2 = allDestinations
    }()
    guard !elements.isEmpty else { return }
    Context.shared.output.append("view")
    Context.shared.output.append(".ibSubviews {")
    elements.forEach { element in
        let elementClass = element.view.customClass ?? element.view.elementClass
        let elementId = sanitizedOutletName(from: (element.view as! IBIdentifiable).id)!
        Context.shared.output.append("\(elementClass)() // \(elementId)!) userLabel: \(element.view.userLabel) key: \(element.view.key) safeArea: \(sanitizedOutletName(from: (element as? View)?.viewLayoutGuide?.id))")
        Context.shared.variableViewIbOutlet.append((viewId: elementId, viewClass: elementClass))
        if let viewIbOutlet = getIbOutletToVariable(of: element.view) {
            Context.shared.output.append(viewIbOutlet)
        }
        getIbOutlet(of: element.view)
        let subviews = element.view.subviews
        if let subviews, subviews.count > 0 {
            printView(elements: subviews)
        }
        printIbAttributes(of: element)
    }
    Context.shared.output.append("}")
    let ibOutletsToViews: [String] = Context.shared.variableViewIbOutlet2.reduce([String](), { partialResult, ibViewId in
        let variableIsNeeded = Context.shared.variableViewIbOutlet.first { (viewId: String, viewClass: String) in
            viewId == ibViewId
        }
        return if let variableIsNeeded {
            partialResult + ["var \(variableIsNeeded.viewId): \(variableIsNeeded.viewClass)!"]
        } else {
            partialResult
        }
    })
    Context.shared.output.insert(contentsOf: ibOutletsToViews, at: 0)
//    Context.shared.variableViewIbOutlet2.forEach { ibViewId in
//        let variableIsNeeded = Context.shared.variableViewIbOutlet.first { (viewId: String, viewClass: String) in
//            viewId == ibViewId
//        }
//        if let variableIsNeeded {
//            Context.shared.output.append("var \(variableIsNeeded.viewId): \(variableIsNeeded.viewClass)!")
//        }
//    }
}

@MainActor
func printView(elements: [AnyView], level: Int = 0) {
    guard !elements.isEmpty else { return }
    Context.shared.output.append(".ibSubviews {")
    elements.forEach { element in
        let elementClass = element.view.customClass ?? element.view.elementClass
        let elementId = sanitizedOutletName(from: (element.view as! IBIdentifiable).id)!
        Context.shared.output.append("\(elementClass)() // \(elementId) userLabel: \(element.view.userLabel) key: \(element.view.key) safeArea: \(sanitizedOutletName(from: (element as? View)?.viewLayoutGuide?.id))")
        Context.shared.variableViewIbOutlet.append((viewId: elementId, viewClass: elementClass))
        if let viewIbOutlet = getIbOutletToVariable(of: element.view) {
            Context.shared.output.append(viewIbOutlet)
        }
        getIbOutlet(of: element.view)
        let subviews = element.view.subviews
        if let subviews, subviews.count > 0 {
            printView(elements: subviews, level: level + 1)
        }
        printIbAttributes(of: element)
    }
    Context.shared.output.append(indent(of: level) + "}")
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
    Context.shared.output.append(".ibAttributes {\n" + allAttributes + "\n}")
}

func getIbOutletToVariable(of element: ViewProtocol) -> String? {
    let viewId = sanitizedOutletName(from: (element as! IBIdentifiable).id)!
    guard (Context.shared.variableViewIbOutlet2.contains { $0 == viewId }) else {
        return nil
    }
    return ".ibOutlet(&\(viewId))"
}

@MainActor
func getIbOutlet(of element: ViewProtocol) -> [String] {
    guard let connections = element.connections else { return [] }
    let outlets = (connections.compactMap { $0.connection as? Outlet })
    var output = [String]()
    if !outlets.isEmpty {
        outlets.forEach { outlet in
            output.append("ibOutlet(&\(sanitizedOutletName(from: outlet.destination)!)" + "."  + "\(outlet.property)" + ")")
        }
    }
    return output
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
