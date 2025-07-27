//
//  convertStoryboard2Code.swift
//  story2code
//
//  Created by Blazej Sleboda on 26/07/2025.
//

import StoryboardDecoder

@discardableResult
@MainActor
public func convertStoryboard2Code(_ anyViewController: AnyViewController) -> [String] {
    if let viewController = anyViewController.viewController as? ViewController {
        printViewControllerRootView(anyViewController)
        Context.shared.output.append(contentsOf: parseViewController(viewController))
    }
    if let vc = anyViewController.viewController as? TableViewController {
        printTableViewControllerRootView(anyViewController)
        Context.shared.output.append(contentsOf: parseTableViewController(vc))
    }
    return Context.shared.output
}
