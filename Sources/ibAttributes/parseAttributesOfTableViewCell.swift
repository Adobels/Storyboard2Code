//
//  parseAttributesOfTableViewCell.swift
//  story2code
//
//  Created by Blazej Sleboda on 19/08/2025.
//

import StoryboardDecoder

func parseAttributes(of cell: TableViewCell) -> [String] {
    var results = [String]()
    results.append(contentsOf: parseViewProtocol(of: cell))
    if let value = cell.style {
        results.append("$0.style = .\(value)")
    }
    if let value = cell.reuseIdentifier {
        results.append("$0.reuseIdentifier = \"\(value)\"")
    }
    if let value = cell.selectionStyle, value != "default" {
        results.append("$0.selectionStyle = .\(value)")
    }
    if let value = cell.accessoryType {
        results.append("$0.accessoryType = .\(value)")
    }
    if let value = cell.editingAccessoryType {
        results.append("$0.editingAccessoryType = .\(value)")
    }
    if let value = cell.focusStyle {
        results.append("$0.focusStyle = .\(value)")
    }
    if let value = cell.indentationLevel {
        results.append("$0.indentationLavel = \(value)")
    }
    if let value = cell.indentationWidth, value != 10 {
        results.append("$0.indentationWidth = \(value)")
    }
    if let value = cell.shouldIndentWhileEditing {
        results.append("$0.shouldIndentWhileEditing = \(value)")
    }
    if let value = cell.showsReorderControl {
        results.append("$0.showsReorderControl = \(value)")
    }
    if let value = cell.separatorInset {
        results.append("$0.separatorInsets = \(parseInset(value))")
    }
    if let value = cell.rowHeight {
        results.append("$0.rowHeight = \(value)")
    }
    return results
}
