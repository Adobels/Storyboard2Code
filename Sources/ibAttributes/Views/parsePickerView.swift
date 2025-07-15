//
//  parsePickerView.swift
//  story2code
//
//  Created by Blazej Sleboda on 27/06/2025.
//

import StoryboardDecoder

func parsePickerView(of pickerView: PickerView) -> [String] {
    var result = [String]()
    result.append(contentsOf: parseViewProtocol(of: pickerView))
    return result
}
