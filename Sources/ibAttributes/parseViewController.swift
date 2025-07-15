//
//  File.swift
//  story2code
//
//  Created by Blazej Sleboda on 15/07/2025.
//

import StoryboardDecoder

func parseViewController(_ viewController: ViewController) -> [String] {
    var result = [String]()
    result.append("let vc = \(viewController.customClass ?? viewController.elementClass)()")
    if let value = viewController.modalPresentationStyle {
        result.append("vc.modalPresentationStyle = \(value)")
    }
    if let value = viewController.storyboardIdentifier {
        result.append("vc.storyboardIdentifier = \(value)")
    }
    // No need of sceneMemberID in code
    if let value = viewController.tabBarItem {
        result.append("vc.tabBarItem = \(value)")
    }
    if let value = viewController.automaticallyAdjustsScrollViewInsets {
        result.append("vc.automaticallyAdjustsScrollViewInsets = \(value)")
    }
    if let value = viewController.hidesBottomBarWhenPushed {
        result.append("vc.hidesBottomBarWhenPushed = \(value)")
    }
    // No need of autoresizesArchivedViewToFullSize in code
    // No need of wantsFullScreenLayout
    if let value = viewController.extendedLayoutIncludesOpaqueBars {
        result.append("vc.extendedLayoutIncludesOpaqueBars = \(value)")
    }
    return result
}
