//
//  parseImageView.swift
//  story2code
//
//  Created by Blazej Sleboda on 06/06/2025.
//

import StoryboardDecoder

func parseImageView(of imageView: ImageView) -> [String] {
    var attr = [String]()
    if let image = imageView.image {
        attr.append("image = .\(image)")
    }
    if let highlightedImage = imageView.highlightedImage {
        attr.append("highlightedImage = .\(highlightedImage)")
    }
    if let highlighted = imageView.highlighted {
        attr.append("highlighted = \(highlighted)")
    }
    if let adjustsImageSizeForAccessibilityContentSizeCategory = imageView.adjustsImageSizeForAccessibilityContentSizeCategory {
        attr.append("adjustsImageSizeForAccessibilityContentSizeCategory = \(adjustsImageSizeForAccessibilityContentSizeCategory)")
    }
    return attr
}
