//
//  parseImageView.swift
//  story2code
//
//  Created by Blazej Sleboda on 06/06/2025.
//

import StoryboardDecoder

func parseImageView(of imageView: ImageView) -> [String] {
    var attr = [String]()
    attr.append(contentsOf: parseViewProtocol(of: imageView))
    if let value = imageView.contentMode {
        attr.append("$0.contentMode = .\(value)")
    }
    if let image = imageView.image {
        attr.append("$0.image = .\(snakeToCamelCase(image))")
    }
    if let highlightedImage = imageView.highlightedImage {
        attr.append("$0.highlightedImage = .\(snakeToCamelCase(highlightedImage))")
    }
    if let highlighted = imageView.highlighted {
        attr.append("$0.highlighted = \(highlighted)")
    }
    if let adjustsImageSizeForAccessibilityContentSizeCategory = imageView.adjustsImageSizeForAccessibilityContentSizeCategory {
        attr.append("$0.adjustsImageSizeForAccessibilityContentSizeCategory = \(adjustsImageSizeForAccessibilityContentSizeCategory)")
    }
    return attr
}
