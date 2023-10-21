import ArgumentParser
import IBDecodable
import Foundation
import Stencil

@main
struct Storyboard2Code: ParsableCommand {
    
    @Argument(help: "Path to the storyboard file.")
    var path: String
    
    mutating func run() throws {
        
        var pathD = Bundle.module.url(forResource: "Main", withExtension: "storyboardd")!
        var pathTemplate = Bundle.module.url(forResource: "RootViewTemplate", withExtension: "stencil")!
        let data = try! Data.init(contentsOf: pathD)
        let desktopURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = desktopURL.appendingPathComponent("Main.storyboard") // replace "extension" with your file's actual extension

        
        try! data.write(to: fileURL)
        do {
            let document = try StoryboardFile(url: fileURL).document
            document.children(of: View.self, recursive: true).forEach {
                print($0)
            }
            var result = printViewHierarchy(document.scenes!.first!.viewController!.viewController.rootView!)
            
            print("Successfully decoded the storyboard at path: \(path)")
            print(result ?? "nil")
            let outputPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.absoluteString + "RootView.swift"
            do {
                //try result?.write(toFile: outputPath, atomically: true, encoding: .utf8)
                print("File successfully saved at \(outputPath)")
            } catch {
                print("Error writing to file: \(error)")
            }
        } catch {
            print("Error decoding storyboard: \(error)")
        }
    }
    
    var output: [String] = []
    
    mutating func printViewHierarchy(_ view: IBDecodable.ViewProtocol, indentation: String = "") {
        
        guard let subviews = view.subviews else {
            output.append("\(indentation)\(view.elementClass)()")
            return
        }
        output.append("\(indentation)\(view.elementClass)().ibSubviews {")
        for subview in subviews {
            printViewHierarchy(subview.view, indentation: indentation + "  ")
        }
        let result = view.ibAttributes()
        if !result.isEmpty {
            output.append("\(indentation)}.ibAttributes {")
            output.append("\(result.joined(separator: "\n"))")
            output.append("\(indentation)}")
        } else {
            output.append("\(indentation)}")
        }
    }
}

extension ViewProtocol {
    func ibAttributes() -> [String] {
        var attributes = [String]()
        if let userInteractionEnabled {
            attributes.append("isUserInteractionEnabled = \(userInteractionEnabled.description)")
        }
        if let contentMode {
            attributes.append("contentMode = \(contentMode.description)")
        }
        if let clipsSubviews {
            attributes.append("clipsSubViews = \(clipsSubviews.description)")
        }
        return attributes
    }
}
