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
    // missing support for Menu : Shows as Primary Action
    if let value = control.isSelected {
        result.append("$0.isSelected = \(value)")
    }
    if let value = control.isEnabled {
        result.append("$0.isEnabled = \(value)")
    }
    if let value = control.isHighlighted {
        result.append("$0.isHighlighted = \(value)")
    }
    // missing support for Tooltip
    return result
}
