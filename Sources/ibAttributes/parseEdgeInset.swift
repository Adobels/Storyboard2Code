//
//  parseEdgeInset.swift
//  story2code
//
//  Created by Blazej Sleboda on 15/07/2025.
//

import StoryboardDecoder

func parseEdgeInset(_ edgeInset: EdgeInset?) -> String? {
    guard let edgeInset else { return nil }
    return ".init(top: \(edgeInset.top ?? 0), left: \(edgeInset.left ?? 0), bottom: \(edgeInset.bottom ?? 0), right: \(edgeInset.right ?? 0)"
}
