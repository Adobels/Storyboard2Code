//
//  printSceneCustomViewTableViewCell.swift
//  story2code
//
//  Created by Blazej Sleboda on 04/08/2025.
//

import StoryboardDecoder
/*
 class RejectCell: UITableViewCell {
    init(style: UITableViewCellStyle, identifier: String?) {
        super.init(style: style, identifier: identifier)
        self.apply {
            $0.identifier = "lalalCell"
            $0.backgroundColor = RootTheme().backgroundColor
        }
        contentView.ibSubviews {
            UILabel()
        }.ibAttributes {
            $0.backgroundColor = Colors.white
        }
    }
 }
 */

func printSceneCustomView(_ customView: TableViewCell, ctx: Context) {
    ctx.output.append(contentsOf: printViewDiagnostics(of: customView, ctx: ctx))
    ctx.output.append("class \(customView.userLabel ?? customView.id): \(customView.customClass ?? customView.elementClass) {")
    ctx.output.append("override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {")
    ctx.output.append("super.init(style: style, reuseIdentifier: reuseIdentifier)")
    ctx.visitedIBIdentifiables.append(customView.id)
    //printIbAttributes(of: customView, ctx: ctx)
    if let subviews = customView.subviews, subviews.hasContent {
        _ = {
            var outletsToEachView: [String] = []
            customView.browse(skipSelf: true) { element in
                guard let view = element as? ViewProtocol else { return true }
                let userLabel = view.id
                outletsToEachView.append("var \(userLabel): \(view.customClass ?? view.elementClass)!")
                return true
            }
            if !outletsToEachView.isEmpty {
                outletsToEachView.insert("// swiftlint:disable identifier_name", at: 0)
                outletsToEachView.append("// swiftlint:enable identifier_name")
            }
            ctx.output.append(contentsOf: outletsToEachView)
        }() as Void
        printSubviews(elements: subviews.map { $0.view }, ctx: ctx)
        ctx.output.append("}")
    }
    ctx.output.append("self")
    printIbAttributes(of: customView, ctx: ctx)
    ctx.output.append("}")
    ctx.output.append("}")
}
