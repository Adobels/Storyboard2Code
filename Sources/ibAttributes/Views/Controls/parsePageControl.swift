//
//  parsePageControl.swift
//  story2code
//
//  Created by Blazej Sleboda on 26/06/2025.
//

import StoryboardDecoder

func parsePageControl(of pageControl: PageControl) -> [String] {
    var output: [String] = .init()
    output.append(contentsOf: parseView(of: pageControl))
    output.append(contentsOf: parseControl(of: pageControl))
    if let numberOfPages = pageControl.numberOfPages {
        output.append("$0.numberOfPages = \(numberOfPages)")
    }
    if let pageIndicatorTintColor = pageControl.pageIndicatorTintColor {
        output.append("$0.pageIndicatorTintColor = \(colorToCode(pageIndicatorTintColor))")
    }
    if let currentPageIndicatorTintColor = pageControl.currentPageIndicatorTintColor {
        output.append("$0.currentPageIndicatorTintColor = \(colorToCode(currentPageIndicatorTintColor))")
    }
    return output
}
