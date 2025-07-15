//
//  parseUITableView.swift
//  story2code
//
//  Created by Blazej Sleboda on 01/07/2025.
//

import StoryboardDecoder

func parseTableView(_ view: TableView) -> [String] {
    var result = [String]()
    result.append(contentsOf: parseViewProtocol(of: view))
    result.append(contentsOf: parseScrollViewProtocol(of: view))
    return result
}
