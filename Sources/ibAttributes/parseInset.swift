//
//  parseInset.swift
//  story2code
//
//  Created by Blazej Sleboda on 15/07/2025.
//

import StoryboardDecoder

func parseInset(_ inset: Inset?) -> String? {
    guard let inset else { return nil }
    return if inset.minY == 0, inset.minX == 0, inset.maxY == 0, inset.maxX == 0 {
        ".zero"
    } else {
        ".init(top: \(inset.minY ?? 0), left: \(inset.minX ?? 0), bottom: \(inset.maxY ?? 0), right: \(inset.maxX ?? 0))"
    }
}

// In InterfaceBuilder: Left -> 1, Top -> 2, Bottom -> 3, Right -> 4
// In Storyboard Source Code: MinX = 1, MinY = 2, MaxY  = 3, MaxX = 4
