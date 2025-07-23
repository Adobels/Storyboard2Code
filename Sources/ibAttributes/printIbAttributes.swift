//
//  printIbAttributes.swift
//  story2code
//
//  Created by Blazej Sleboda on 11/06/2025.
//

import StoryboardDecoder

func printIbAttributes(of element: AnyView) {
    Context.shared.output.append(".ibAttributes {")
    Context.shared.output.append(contentsOf: printIbAttributes(element))
    Context.shared.output.append("}")
}

private func printIbAttributes(_ element: AnyView) -> [String] {
    let viewId = element.view.id
    var attributes = [String]()
    // Constraints
    _ = {
        let constraintsFound = Context.shared.arrayConstrains.filter { $0.viewId == viewId }.forEach { constraint in
            attributes.append(constraint.code)
            Context.shared.arrayConstrains.removeAll(where: { $0 == constraint })
        }
    }() as Void
    attributes.append(contentsOf: convertOutletsToCode(of: element.view))
    if let view = element.view as? View {
        attributes.append(contentsOf: parseView(of: view))
    }
    if let label = element.view as? Label {
        attributes.append(contentsOf: parseIbAttributes(of: label))
    }
    if let button = element.view as? Button {
        attributes.append(contentsOf: parseButton(of: button))
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
        attributes.append(contentsOf: parseTextField(of: textField))
    }
    if let tableView = element.view as? TableView {
        //TODO: Add parsing for TableView subclass attributes
    }
    if let uiswitch = element.view as? Switch {
        attributes.append(contentsOf: parseSwitch(of: uiswitch))
    }
    if let scrollView = element.view as? ScrollView {
        attributes.append(contentsOf: parseScrollView(of: scrollView))
    }
    if let collectionViewcell = element.view as? CollectionViewCell {
        //TODO: Add parsing for UICollectionViewCell
    }
    if let datePicker = element.view as? DatePicker {
        attributes.append(contentsOf: parseDatePicker(of: datePicker))
    }
    if let textView = element.view as? TextView {
        attributes.append(contentsOf: parseUITextView(of: textView))
    }
    if let pageControl = element.view as? PageControl {
        attributes.append(contentsOf: parsePageControl(of: pageControl))
    }
    if let collectionView = element.view as? CollectionView {
        //TODO: Add parsing for UICollectionView
    }
    if let pickerView = element.view as? PickerView {
        attributes.append(contentsOf: parsePickerView(of: pickerView))
    }
    if let activityIndicatorView = element.view as? ActivityIndicatorView {
        attributes.append(contentsOf: parseActivityIndicatorView(of: activityIndicatorView))
    }
    attributes.append(contentsOf: parseUserDefinedRuntimeAttributes(of: element.view))
    // Actions
    _ = {
        Context.shared.actions.filter { $0.ownerId == element.view.id }.forEach { viewAction in
            attributes.append(viewAction.code)
            Context.shared.actions.removeAll(where: { $0 == viewAction })
        }
    }() as Void
    return attributes
}
