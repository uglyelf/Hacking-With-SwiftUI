//
//  PathStore.swift
//  Navigation
//
//  Created by Gregory Randolph on 7/29/25.
//

import SwiftUI

@Observable
class PathStore {
    var path: [Int] {
        didSet {
            save()
        }
    }
    
    private let savePath = URL.documentsDirectory.appending(path: "SavedPath")
    
    init() {
        guard let data = try? Data(contentsOf: savePath),
        let decoded = try? JSONDecoder().decode([Int].self, from: data) else {
            path = [] // start with an empty path
            return
        }

        self.path = decoded
    }
    
    func save() {
        do {
            let data = try JSONEncoder().encode(path)
            try data.write(to: savePath)
        } catch {
            fatalError("Failed to save navigation data.")
        }
    }
    
    func clear() {
        path.removeAll()
    }
}
