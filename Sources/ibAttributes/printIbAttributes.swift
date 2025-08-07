//
//  printIbAttributes.swift
//  story2code
//
//  Created by Blazej Sleboda on 11/06/2025.
//

import StoryboardDecoder

func printIbAttributes(of element: ViewProtocol, ctx: Context) {
    let content = printIbAttributes(element, ctx: ctx)
    guard !content.isEmpty else { return }
    //ctx.output.append(".ibAttributes {")
    ctx.output.appendToLastElement(".ibAttributes {")
    ctx.output.append(contentsOf: content)
    ctx.output.append("}")
}

private func printIbAttributes(_ element: ViewProtocol, ctx: Context) -> [String] {
    var results = [String]()
    let viewId = element.id
    // Constraints
    _ = {
        let constraintsFound = ctx.constraints.filter { $0.viewId == viewId }.forEach { constraint in
            results.append(constraint.code)
            ctx.constraints.removeAll(where: { $0 == constraint })
        }
    }() as Void
    // Attributes
    if let view = element as? View {
        results.append(contentsOf: parseView(of: view))
    }
    if let label = element as? Label {
        results.append(contentsOf: parseIbAttributes(of: label))
    }
    if let button = element as? Button {
        results.append(contentsOf: parseButton(of: button))
    }
    if let imageView = element as? ImageView {
        results.append(contentsOf: parseImageView(of: imageView))
    }
    if let tableViewCell = element as? TableViewCell {
        //TODO: Add parsing for UITableViewCell subclass attributes
    }
    if let stackView = element as? StackView {
        results.append(contentsOf: parseStackViewAttributes(stackView))
    }
    if let textField = element as? TextField {
        results.append(contentsOf: parseTextField(of: textField))
    }
    if let tableView = element as? TableView {
        //TODO: Add parsing for TableView subclass attributes
    }
    if let uiswitch = element as? Switch {
        results.append(contentsOf: parseSwitch(of: uiswitch))
    }
    if let scrollView = element as? ScrollView {
        results.append(contentsOf: parseScrollView(of: scrollView))
    }
    if let collectionViewcell = element as? CollectionViewCell {
        //TODO: Add parsing for UICollectionViewCell
    }
    if let datePicker = element as? DatePicker {
        results.append(contentsOf: parseDatePicker(of: datePicker))
    }
    if let textView = element as? TextView {
        results.append(contentsOf: parseUITextView(of: textView))
    }
    if let pageControl = element as? PageControl {
        results.append(contentsOf: parsePageControl(of: pageControl))
    }
    if let collectionView = element as? CollectionView {
        //TODO: Add parsing for UICollectionView
    }
    if let pickerView = element as? PickerView {
        results.append(contentsOf: parsePickerView(of: pickerView))
    }
    if let activityIndicatorView = element as? ActivityIndicatorView {
        results.append(contentsOf: parseActivityIndicatorView(of: activityIndicatorView))
    }
    // UserDefinedRuntimeAttributes
    results.append(contentsOf: parseUserDefinedRuntimeAttributes(of: element))
    // Inversed Outlets
    let outletsToApplyHere = ctx.referencingOutletsMgr.outletsToApplyLater.filter { $0.destination == element.id }
    outletsToApplyHere.forEach { outlet in
        results.append("\(outlet.ownerId).\(outlet.property) = $0" + G.logLiteral + "Inversed Outlet")
    }
    // Outlets
    _ = {
        guard let connections = (element.connections?.compactMap { $0.connection as? Outlet }) else { return }
        connections.forEach { connection in
            if ctx.visitedIBIdentifiables.contains(where: { $0 == connection.destination }) {
                results.append("$0.\(connection.property) = \(connection.destination)" + G.logLiteral + "Outlet")
            } else {
                ctx.referencingOutletsMgr.outletsToApplyLater.append(
                    .init(
                        ownerId: element.id,
                        property: connection.property,
                        destination: connection.destination,
                        isOutletToDestination: true,
                    )
                )
            }
        }
    }() as Void
    // Actions
    _ = {
        ctx.actions.filter { $0.ownerId == element.id }.forEach { viewAction in
            results.append(viewAction.code)
            ctx.actions.removeAll(where: { $0 == viewAction })
        }
    }() as Void
    // Gestures
    _ = {
        guard let outletCollections = (element.connections?.compactMap { $0.connection as? OutletCollection }), !outletCollections.isEmpty else { return }
        let refToGestureRecognizers = outletCollections.filter { $0.property == "gestureRecognizers" }
        var foundGestures: [AnyGestureRecognizer] = []
        refToGestureRecognizers.forEach { refToGesture in
            guard let gesture = ctx.gestures.first(where: { gesture in
                refToGesture.destination == gesture.gestureRecognizer.id
            }) else { return }
            foundGestures.append(gesture)
        }
        foundGestures.map {
            results.append(contentsOf: parseTapGestureRecognizer($0, ctx: ctx))
        }
    }() as Void
    return results
}
