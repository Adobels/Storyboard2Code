//
//  printIbAttributes.swift
//  story2code
//
//  Created by Blazej Sleboda on 11/06/2025.
//

import StoryboardDecoder

func printIbAttributes(of element: ViewProtocol) {
    Context.shared.output.append(".ibAttributes {")
    Context.shared.output.append(contentsOf: printIbAttributes(element))
    Context.shared.output.append("}")
}

private func printIbAttributes(_ element: ViewProtocol) -> [String] {
    let viewId = element.id
    var attributes = [String]()
    // Constraints
    _ = {
        let constraintsFound = Context.shared.constraints.filter { $0.viewId == viewId }.forEach { constraint in
            attributes.append(constraint.code)
            Context.shared.constraints.removeAll(where: { $0 == constraint })
        }
    }() as Void
    attributes.append(contentsOf: convertOutletsToCode(of: element))
    if let view = element as? View {
        attributes.append(contentsOf: parseView(of: view))
    }
    if let label = element as? Label {
        attributes.append(contentsOf: parseIbAttributes(of: label))
    }
    if let button = element as? Button {
        attributes.append(contentsOf: parseButton(of: button))
    }
    if let imageView = element as? ImageView {
        attributes.append(contentsOf: parseImageView(of: imageView))
    }
    if let tableViewCell = element as? TableViewCell {
        //TODO: Add parsing for UITableViewCell subclass attributes
    }
    if let stackView = element as? StackView {
        attributes.append(contentsOf: parseStackViewAttributes(stackView))
    }
    if let textField = element as? TextField {
        attributes.append(contentsOf: parseTextField(of: textField))
    }
    if let tableView = element as? TableView {
        //TODO: Add parsing for TableView subclass attributes
    }
    if let uiswitch = element as? Switch {
        attributes.append(contentsOf: parseSwitch(of: uiswitch))
    }
    if let scrollView = element as? ScrollView {
        attributes.append(contentsOf: parseScrollView(of: scrollView))
    }
    if let collectionViewcell = element as? CollectionViewCell {
        //TODO: Add parsing for UICollectionViewCell
    }
    if let datePicker = element as? DatePicker {
        attributes.append(contentsOf: parseDatePicker(of: datePicker))
    }
    if let textView = element as? TextView {
        attributes.append(contentsOf: parseUITextView(of: textView))
    }
    if let pageControl = element as? PageControl {
        attributes.append(contentsOf: parsePageControl(of: pageControl))
    }
    if let collectionView = element as? CollectionView {
        //TODO: Add parsing for UICollectionView
    }
    if let pickerView = element as? PickerView {
        attributes.append(contentsOf: parsePickerView(of: pickerView))
    }
    if let activityIndicatorView = element as? ActivityIndicatorView {
        attributes.append(contentsOf: parseActivityIndicatorView(of: activityIndicatorView))
    }
    attributes.append(contentsOf: parseUserDefinedRuntimeAttributes(of: element))
    // Actions
    _ = {
        Context.shared.actions.filter { $0.ownerId == element.id }.forEach { viewAction in
            attributes.append(viewAction.code)
            Context.shared.actions.removeAll(where: { $0 == viewAction })
        }
    }() as Void
    return attributes
}
