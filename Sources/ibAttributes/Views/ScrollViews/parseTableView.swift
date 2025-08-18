//
//  parseUITableView.swift
//  story2code
//
//  Created by Blazej Sleboda on 01/07/2025.
//

import StoryboardDecoder

func parseTableView(_ view: TableView) -> [String] {
    var result = [String]()
    result.append(contentsOf: parseViewProtocol(of: view))
    result.append(contentsOf: parseScrollViewProtocol(of: view))
    //public let dataMode: TableView.DataMode?
    if let value = view.dataMode {
        result.append("// dataMode: \(value)")
    }
    if let value = view.style {
        result.append("$0.style = .\(value)")
    }
    if let value = view.separatorStyle {
        result.append("$0.separatorStyle = .\(value)")
    }
    if let value = view.separatorColor {
        result.append("$0.separatorColor = \(colorToCode(value))")
    }
    if let value = view.separatorInset {
        result.append("$0.separatorInset = \(parseInset(value))")
    }
    if let value = view.separatorInsetReference {
        result.append("$0.separatorInsetReference = \(value)")
    }
    if let value = view.allowsSelection {
        result.append("$0.allowsSelection = \(value)")
    }
    if let value = view.allowsMultipleSelection {
        result.append("$0.allowsMultipleSelection = \(value)")
    }
    if let value = view.allowsSelectionDuringEditing {
        result.append("$0.allowsSelectionDuringEditing = \(value)")
    }
    if let value = view.allowsMultipleSelectionDuringEditing {
        result.append("$0.allowsMultipleSelectionDuringEditing = \(value)")
    }
    if let value = view.springLoaded {
        result.append("$0.springLoaded = \(value)")
    }
    if let value = view.sectionIndexMinimumDisplayRowCount {
        result.append("$0.sectionIndexMinimumDisplayRowCount = \(value)")
    }
    if let value = view.sectionIndexColor {
        result.append("$0.sectionIndexColor = \(colorToCode(value))")
    }
    if let value = view.sectionIndexBackgroundColor {
        result.append("$0.sectionIndexBackgroundColor = \(colorToCode(value))")
    }
    if let value = view.sectionIndexTrackingBackgroundColor {
        result.append("sectionIndexTrackingBackgroundColor = \(colorToCode(value))")
    }
    if let value = view.rowHeight {
        result.append("$0.rowHeight = \(value)")
    }
    if let value = view.estimatedRowHeight {
        result.append("$0.estimatedRowHeight = \(value)")
    }
    if let value = view.sectionHeaderHeight {
        result.append("$0.estimatedRowHeight = \(value)")
    }
    if let value = view.estimatedSectionHeaderHeight {
        result.append("$0.estimatedSectionHeaderHeight = \(value)")
    }
    if let value = view.sectionFooterHeight {
        result.append("$0.sectionFooterHeight = \(value)")
    }
    if let value = view.estimatedSectionFooterHeight {
        result.append("$0.estimatedSectionFooterHeight = \(value)")
    }
    if let value = view.contentViewInsetsToSafeArea {
        result.append("$0.insetsContentViewsToSafeArea = \(value)")
    }
    return result
}
