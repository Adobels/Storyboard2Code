//
//  parseSwitch.swift
//  story2code
//
//  Created by Blazej Sleboda on 26/06/2025.
//

import StoryboardDecoder

func parseUISwitch(of switchView: Switch) -> [String] {
    var attr = [String]()
    attr.append(contentsOf: parseUIControl(of: switchView))
    if let value = switchView.on {
        attr.append("$0.setOn(\(value), animated: false)")
    }
    if let color = switchView.onTintColor {
        attr.append("$0.onTintColor = .\(color)")
    }
    if let color = switchView.thumbTintColor {
        attr.append("$0.thumbTintColor")
    }
    return attr
}
