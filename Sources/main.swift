//
//  main.swift
//  story2code
//
//  Created by Blazej Sleboda on 20/03/2025.
//

import Foundation
import StoryboardDecoder

let url = Bundle.module.url(forResource: "Biometrics", withExtension: "xml")!
let sb = try! StoryboardFile(url: url)
let initialScene = sb.document.scenes!.first!
convertStoryboard2Code(initialScene.viewController!)

@MainActor
func convertStoryboard2Code(_ anyViewController: AnyViewController) {
    printViewControllerRootView(anyViewController)
    print(Context.shared.output.joined(separator: "\n"))
}
