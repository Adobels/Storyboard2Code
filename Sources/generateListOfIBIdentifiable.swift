//
//  generateListOfIBIdentifiable.swift
//  story2code
//
//  Created by Blazej Sleboda on 26/07/2025.
//

import StoryboardDecoder

@MainActor
func generateListOfIBIdentifiable(of scene: Scene) -> [String] {
    var strings = [String]()
    scene.browse {  element in
        guard let ibIdentifiable = element as? IBIdentifiable else { return true }
        strings.append(ibIdentifiable.id)
        return true
    }
//    
//    scene.flattened.forEach { element in
//        guard let ibIdentifiable = element as? IBIdentifiable else { return }
//        strings.append(ibIdentifiable.id)
//    }
    return strings
}
