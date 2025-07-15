//
//  parseScrollView.swift
//  story2code
//
//  Created by Blazej Sleboda on 27/06/2025.
//

import StoryboardDecoder

func parseScrollView(of scrollView: ScrollViewProtocol) -> [String] {
    var result = [String]()
    result.append(contentsOf: parseViewProtocol(of: scrollView))
    result.append(contentsOf: parseScrollViewProtocol(of: scrollView))
    return result
}

private struct UIKitUIScrollView {

    let scrollView: ScrollViewProtocol

    var contentInsetAdjustmentBehavior: String? { scrollView.contentInsetAdjustmentBehavior}
    var scrollIndicatorInsets: Inset? { scrollView.scrollIndicatorInsets }
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
