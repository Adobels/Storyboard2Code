//
//  Default.swift
//  story2code
//
//  Created by Blazej Sleboda on 10/06/2025.
//
import story2code
import Foundation
import StoryboardDecoder
import Testing

@Test func test1() {
    let url = Bundle.module.url(forResource: "Biometrics", withExtension: "xml")!
    let sb = try! StoryboardFile(url: url)
    let initialScene = sb.document.scenes!.first!
    let vc: AnyViewController = initialScene.viewController!
    //vc.children
    //printViewControllerRootView(initialScene.viewController!)
}
