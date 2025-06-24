//
//  colorToCode.swift
//  story2code
//
//  Created by Blazej Sleboda on 24/06/2025.
//

import Foundation
import StoryboardDecoder

func colorToCode(_ color: Color) -> String {
    switch color {
    case .calibratedWhite(let calibratedWhite):
        return ".init(white: \(calibratedWhite.white), alpha: \(calibratedWhite.alpha))"
    case .calibratedRGB(let calibratedRGB):
        //UIColor(cgColor: .init(red: 0.333, green: 0.333, blue: 0.333, alpha: 1))
        return ".init(cgColor: .init(red: \(calibratedRGB.red), green: \(calibratedRGB.green), blue: \(calibratedRGB.blue), alpha: \(calibratedRGB.alpha)))"
    case .sRGB(let sRGB):
        return ".init(red: \(sRGB.red), green: \(sRGB.green), blue: \(sRGB.blue), alpha: \(sRGB.alpha)"
    case .gamma22Gray(let gamma22Gray):
        return ".init(cgColor: .init(genericGrayGamma2_2Gray: \(gamma22Gray.white), alpha: \(gamma22Gray.alpha)))"
    case .name(let named):
       return  ".init(named: \(named))"
    case .systemColor(let named):
        return ".init(named: \(named)"
    }
}
