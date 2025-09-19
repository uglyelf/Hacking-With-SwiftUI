//
//  AddBookView.swift
//  Bookworm
//
//  Created by Gregory Randolph on 9/14/25.
//

import SwiftUI
import SwiftData

struct AddBookView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = "Fantasy"
    @State private var review = ""
    
    let genres = Genres.allCases.map {$0.description}
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Book Title", text: $title)
                    TextField("Author's name", text: $author)
                    
                    // TODO use the enum
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section("Write a review") {
                    TextEditor(text: $review)
                    RatingView(rating: $rating)
                }
                
                Section {
                    Button("Save") {
                        // add the book.
                        let newBook = Book(title: title, author: author, genre: genre, review: review, rating: rating)
                        modelContext.insert(newBook)
                        dismiss()
                    }
                }
            }
            .navigationTitle(Text("Add Book"))
        }
    } // body
}

#Preview {
    AddBookView()
}
