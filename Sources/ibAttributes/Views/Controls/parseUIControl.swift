//
//  parseUIControl.swift
//  story2code
//
//  Created by Blazej Sleboda on 01/07/2025.
//
import StoryboardDecoder

func parseUIControl(of control: ControlProtocol) -> [String] {
    var result = [String]()
    if let value = control.contentHorizontalAlignment {
        result.append("$0.contentHorizontalAlignment = .\(value)")
    }
    if let value = control.contentVerticalAlignment {
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
