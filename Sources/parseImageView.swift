//
//  parseImageView.swift
//  story2code
//
//  Created by Blazej Sleboda on 06/06/2025.
//

import StoryboardDecoder

func parseImageView(of imageView: ImageView) -> [String] {

    func snakeToCamelCase(_ string: String) -> String {
        let components = string.split(separator: "_")
        guard let first = components.first?.lowercased() else { return "" }
        let rest = components.dropFirst().map { $0.capitalized }
        return ([first] + rest).joined()
    }

    var attr = [String]()
    if let image = imageView.image {
        attr.append("image = .\(snakeToCamelCase(image))")
    }
    if let highlightedImage = imageView.highlightedImage {
        attr.append("highlightedImage = .\(snakeToCamelCase(highlightedImage))")
    }
    if let highlighted = imageView.highlighted {
        attr.append("highlighted = \(highlighted)")
    }
    if let adjustsImageSizeForAccessibilityContentSizeCategory = imageView.adjustsImageSizeForAccessibilityContentSizeCategory {
        attr.append("adjustsImageSizeForAccessibilityContentSizeCategory = \(adjustsImageSizeForAccessibilityContentSizeCategory)")
    }
    return attr
}
