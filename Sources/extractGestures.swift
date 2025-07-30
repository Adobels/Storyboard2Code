//
//  extractGestures.swift
//  story2code
//
//  Created by Blazej Sleboda on 30/07/2025.
//

import StoryboardDecoder

func extractGestures(of scene: Scene) -> [AnyGestureRecognizer] {
    var results: [AnyGestureRecognizer] = []
    scene.browse { element in
        guard let gesture = element as? AnyGestureRecognizer else { return true }
        results.append(gesture)
        return true
    }
    return results
}
