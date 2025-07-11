//
//  parseUIScrollView.swift
//  story2code
//
//  Created by Blazej Sleboda on 27/06/2025.
//

import StoryboardDecoder

func parseUIScrollView(of scrollView: ScrollView) -> [String] {
    var result = [String]()
    let scrollView = UIKitUIScrollView(scrollView: scrollView)
    if let value = scrollView.indicatorStyle {
        result.append("$0.indicatorStyle = .\(value)")
    }
    if let value = scrollView.showsHorizontalScrollIndicator {
        result.append("$0.showsHorizontalScrollIndicator = \(value)")
    }
    if let value = scrollView.showsVerticalScrollIndicator {
        result.append("$0.showsVerticalScrollIndicator = \(value)")
    }
    if let value = scrollView.isScrollEnabled {
        result.append("$0.isScrollEnabled = \(value)")
    }
    if let value = scrollView.isPagingEnabled {
        result.append("$0.isPagingEnabled = \(value)")
    }
    if let value = scrollView.isDirectionalLockEnabled {
        result.append("$0.isDirectionalLockEnabled = \(value)")
    }
    if let value = scrollView.bounces {
        result.append("$0.bounces = \(value)")
    }
    if let value = scrollView.bouncesZoom {
        result.append("$0.bouncesZoom = \(value)")
    }
    if let value = scrollView.alwaysBounceHorizontal {
        result.append("$0.alwaysBounceHorizontal = \(value)")
    }
    if let value = scrollView.alwaysBounceVertical {
        result.append("$0.alwaysBounceVertical = \(value)")
    }
    if let value = scrollView.minimumZoomScale {
        result.append("$0.minimumZoomScale = \(value)")
    }
    if let value = scrollView.maximumZoomScale {
        result.append("$0.maximumZoomScale = \(value)")
    }
    if let value = scrollView.delaysContentTouches {
        result.append("$0.delaysContentTouches = \(value)")
    }
    if let value = scrollView.canCancelContentTouches {
        result.append("$0.canCancelContentTouches = \(value)")
    }
    if let value = scrollView.keyboardDismissMode {
        result.append("$0.keyboardDismissMode = .\(value)")
    }
    return result
}

private struct UIKitUIScrollView {

    let scrollView: ScrollView

    var indicatorStyle: IndicatorStyle? { scrollView.indicatorStyle }
    var showsHorizontalScrollIndicator: Bool? { scrollView.showsHorizontalScrollIndicator }
    var showsVerticalScrollIndicator: Bool? { scrollView.showsVerticalScrollIndicator }
    var isScrollEnabled: Bool? { scrollView.scrollEnabled }
    var isPagingEnabled: Bool? { scrollView.pagingEnabled }
    var isDirectionalLockEnabled: Bool? { scrollView.directionalLockEnabled }
    var bounces: Bool? { scrollView.bounces }
    var bouncesZoom: Bool? { scrollView.bouncesZoom }
    var alwaysBounceHorizontal: Bool? { scrollView.alwaysBounceHorizontal }
    var alwaysBounceVertical: Bool? { scrollView.alwaysBounceVertical }
    var minimumZoomScale: Float? { scrollView.minimumZoomScale }
    var maximumZoomScale: Float? { scrollView.maximumZoomScale }
    var delaysContentTouches: Bool? { scrollView.delaysContentTouches }
    var canCancelContentTouches: Bool? { scrollView.canCancelContentTouches }
    var keyboardDismissMode: String? { scrollView.keyboardDismissMode }
}
