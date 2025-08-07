//
//  File.swift
//  story2code
//
//  Created by Blazej Sleboda on 15/07/2025.
//

import StoryboardDecoder

func parseTableViewController(_ viewController: TableViewController) -> [String] {
    var result = [String]()
    if let value = viewController.storyboardIdentifier {
        result.append("storyboardIdentifier = \(value)")
    }
    // No need of sceneMemberID in code
    if let value = viewController.tabBarItem {
        result.append("tabBarItem = \(value)")
    }
    if let value = viewController.automaticallyAdjustsScrollViewInsets {
        result.append("automaticallyAdjustsScrollViewInsets = \(value)")
    }
    if let value = viewController.hidesBottomBarWhenPushed {
        result.append("hidesBottomBarWhenPushed = \(value)")
    }
    // No need of autoresizesArchivedViewToFullSize in code
    // No need of wantsFullScreenLayout
    if let value = viewController.extendedLayoutIncludesOpaqueBars {
        result.append("extendedLayoutIncludesOpaqueBars = \(value)")
    }
    return result
}
