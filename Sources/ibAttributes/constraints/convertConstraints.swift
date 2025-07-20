//
//  convertConstraints.swift
//  story2code
//
//  Created by Blazej Sleboda on 04/06/2025.
//

import StoryboardDecoder

func storyboardLayoutGuideKeyToCode(required layoutGuideKey: String) -> String {
    switch layoutGuideKey {
    case "safeArea": "safeAreaLayoutGuide"
    case "keyboard": "keyboardLayoutGuide"
    default: fatalError()
    }
}

func storyboardLayoutGuideKeyToCode(_ layoutGuideKey: String?) -> String? {
    guard let layoutGuideKey else { return nil }
    guard !layoutGuideKey.isEmpty else { return nil }
    return storyboardLayoutGuideKeyToCode(required: layoutGuideKey)
}
