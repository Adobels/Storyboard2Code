//
//  parseControlProtocol.swift
//  story2code
//
//  Created by Blazej Sleboda on 01/07/2025.
//
import StoryboardDecoder

func parseControlProtocol(of control: ViewProtocol) -> [String] {
    guard let control = control as? ControlProtocol else { fatalError() }
    var result = [String]()
    if let value = control.contentHorizontalAlignment, value != "center" {
        result.append("$0.contentHorizontalAlignment = .\(value)")
    }
    if let value = control.contentVerticalAlignment, value != "center" {
        result.append("$0.contentVerticalAlignment = .\(value)")
    }
    if let value = control.showsMenuAsPrimaryAction {
        result.append("$0.showsMenuAsPrimaryAction = \(value)")
    }
    if let value = control.selected {
        result.append("$0.isSelected = \(value)")
    }
    if let value = control.enabled {
        result.append("$0.isEnabled = \(value)")
    }
    if let value = control.highlighted {
        result.append("$0.isHighlighted = \(value)")
    }
    if let value = control.toolTip {
        result.append("$0.toolTip = \(value)")
    }
    return result
}
