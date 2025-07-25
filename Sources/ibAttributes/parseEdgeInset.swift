//
//  parseEdgeInset.swift
//  story2code
//
//  Created by Blazej Sleboda on 15/07/2025.
//

import StoryboardDecoder

func parseEdgeInset(_ edgeInset: EdgeInset?) -> String? {
    guard let edgeInset else { return nil }
    return if edgeInset.top == 0, edgeInset.left == 0, edgeInset.right == 0, edgeInset.bottom == 0 {
        ".zero"
    } else {
        ".init(top: \(edgeInset.top ?? 0), left: \(edgeInset.left ?? 0), bottom: \(edgeInset.bottom ?? 0), right: \(edgeInset.right ?? 0)"
    }
}
