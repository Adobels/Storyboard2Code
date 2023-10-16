import ArgumentParser
import IBDecodable
import Foundation
import Stencil

@main
struct Storyboard2Code: ParsableCommand {
    
    @Argument(help: "Path to the storyboard file.")
    var path: String
    
    mutating func run() throws {
        
        let url = URL(fileURLWithPath: path)
        do {
            let document = try StoryboardFile(url: url).document
            let result = try? generateCode(from: document)
            print("Successfully decoded the storyboard at path: \(path)")
            print(result ?? "nil")
            let outputPath = FileManager.default.currentDirectoryPath + "/RootView.swift"
            do {
                try result?.write(toFile: outputPath, atomically: true, encoding: .utf8)
                print("File successfully saved at \(outputPath)")
            } catch {
                print("Error writing to file: \(error)")
            }
        } catch {
            print("Error decoding storyboard: \(error)")
        }
    }
    
    func generateCode(from document: IBDecodable.StoryboardDocument) throws -> String {
        let loader = FileSystemLoader.init(paths: [.init(FileManager.default.currentDirectoryPath)])
        let environment = Environment(loader: loader)
        guard let rootView = document.scenes?.first?.viewController?.viewController.rootView else {
            throw fatalError()
        }
        
        var counter = 0
        
        rootView.subviews?.first?.children(of: View.self)
        
        let views = rootView.children(of: IBDecodable.AnyView.self, recursive: true).compactMap { anyView -> [String: Any]? in
            
            counter += 1
            return [
                "rootview": "view\(counter)",
                "class": anyView.view.elementClass,
            ]
        }
        
        let rendered = try environment.renderTemplate(name: "RootViewTemplate.stencil", context: ["views": views])
        return rendered
    }
    
}
