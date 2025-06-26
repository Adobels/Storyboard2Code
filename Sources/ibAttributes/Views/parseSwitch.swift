//
//  parseSwitch.swift
//  story2code
//
//  Created by Blazej Sleboda on 26/06/2025.
//

import Foundation
import StoryboardDecoder

func parseSwitch(of switchView: Switch) -> [String] {
    var attr = [String]()
    if switchView.on {
        attr.append("$0.setOn(true, animated: false)")
    }
    if let color = switchView.onTintColor {
        attr.append("$0.onTintColor = .\(color)")
    }
    if let color = switchView.thumbTintColor {
        attr.append("$0.thumbTintColor")
    }
    return attr
}
