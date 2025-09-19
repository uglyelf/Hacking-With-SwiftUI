//
//  PreviewContainer.swift
//  Bookworm
//
//  Created by Gregory Randolph on 9/16/25.
//

import Foundation
import SwiftData

@MainActor
struct PreviewContainer {
    let container: ModelContainer
    init() {
        do {
            container = try ModelContainer(for: Book.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
            // Insert sample data here
            let book1 = Book(title: "Book One!", author: "Bip Dieharde", genre: "Science Fiction", review: "Here is a poorly written review of a non-existent book", rating: 4)
            let book2 = Book(title: "Book Two!", author: "Team maeT", genre: "Horror", review: "Basically some words printed next to each other.", rating: 2)
            container.mainContext.insert(book1)
            container.mainContext.insert(book2)
        } catch {
            fatalError("Failed to create preview container: \(error.localizedDescription)")
        }
    }
}
