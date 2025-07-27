//
//  File.swift
//  story2code
//
//  Created by Blazej Sleboda on 26/07/2025.
//

import Testing
@testable import story2code
import Foundation
import StoryboardDecoder

@MainActor
struct GenerateListOfIBIdentifiableTests {
    
    @Test func `default`() throws {
        let url = Bundle.module.url(forResource: "Biometrics", withExtension: "xml")!
        let sb = try! StoryboardFile(url: url)
        let scene = try #require(sb.document.scenes?.first)
        let results = generateListOfIBIdentifiable(of: scene)
        let expectedResults = ["o22-gh-Hhu", "PER-y7-qQK", "Q9F-Uh-SHm", "mQC-PI-eMm", "JgL-1v-l7T", "omo-0k-py9", "M2X-Da-OBu", "mE8-I2-iTF", "HIC-nu-f3k", "Jwo-wd-1Zm", "MLi-jY-msw", "Rxg-VU-fWy", "a1f-a5-J3Z", "c9f-ip-FeP", "dri-Pm-1Kx", "flO-bt-Nal", "k2t-O8-Cyf", "rwb-gR-zEd", "xBr-PU-J84", "cOz-oz-7WC", "go4-XY-s4N", "Eny-iP-0M8", "wzD-rD-jxu", "3cS-sv-O0e", "9Yo-en-8O2", "kWd-mR-uJf", "sUV-DS-kWx", "uzW-Bl-viM", "OHi-Ag-V1y", "a0a-Uk-hPz", "Zd5-6y-JDW", "JAj-m8-VuO", "ck7-zr-Zuc", "el0-J1-Qx1", "wZY-j4-ygi", "Fnc-eh-aCS", "HoM-Sg-2BW", "P0g-o0-OYZ", "bhD-9X-vn2", "DnY-wV-ZhQ", "3a3-o2-qAs", "5X5-x7-3Td", "9bo-zQ-JLb", "N6f-Zc-Pmv", "Vs7-GQ-lJ7", "Wuk-JQ-quH", "YMS-OG-r4O", "azL-u6-fXZ", "cZZ-r4-Pbv", "gga-Fm-cdz", "lbd-a3-xW1", "oaq-H4-TvR", "p6m-3V-qV9", "tw6-Ta-hEY", "yeO-9X-8xR", "egX-mo-zzw", "D43-Zc-4DP", "GhR-0A-4dh", "Cxm-a5-CDy", "kul-XI-M71", "4CV-Ro-no8"]
        #expect(results == expectedResults)
    }
}
