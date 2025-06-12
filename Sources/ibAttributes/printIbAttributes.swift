//
//  printIbAttributes.swift
//  story2code
//
//  Created by Blazej Sleboda on 11/06/2025.
//

import StoryboardDecoder

func printIbAttributes(_ attributes: [String]) {
    Context.shared.output.append(".ibAttributes {")
    Context.shared.output.append(contentsOf: attributes)
    Context.shared.output.append("}")
}

@MainActor
func printIbAttributes(of element: AnyView) {
    var attributes = [String]()
    let constraints = getIBConstraints(of: element.view).sorted()
    if !constraints.isEmpty {
        attributes.append("// ibOutlet: \(sanitizedOutletName(from: (element.view as! IBIdentifiable).id)!)")
        attributes.append(contentsOf: getIBConstraints(of: element.view).sorted())
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
    attributes.append(contentsOf: parseUserDefinedRuntimeAttributes(of: element.view))
    printIbAttributes(attributes)
}
