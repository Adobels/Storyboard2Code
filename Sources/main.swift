//
//  main.swift
//  story2code
//
//  Created by Blazej Sleboda on 20/03/2025.
//

import Foundation
import StoryboardDecoder

let url = Bundle.module.url(forResource: "Login", withExtension: "xml")!
let sb = try! StoryboardFile(url: url)
let initialScene = sb.document.scenes!.first!
let result = convertStoryboard2Code(initialScene.viewController!)

@MainActor
@discardableResult
func convertStoryboard2Code(_ anyViewController: AnyViewController) -> [String] {
    printViewControllerRootView(anyViewController)
    print(Context.shared.output.joined(separator: "\n"))
    return Context.shared.output
}
