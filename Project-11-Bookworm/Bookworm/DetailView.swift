//
//  DetailView.swift
//  Bookworm
//
//  Created by Gregory Randolph on 9/17/25.
//

import SwiftUI
import SwiftData

/**
 From: https://www.hackingwithswift.com/books/ios-swiftui/showing-book-details
 
 "Unsplash has a license that allows us to use pictures commercially or non-commercially, with or without attribution, although attribution is appreciated. The pictures I’ve added are by Ryan Wallace, Eugene Triguba, Jamie Street, Alvaro Serrano, Joao Silas, David Dilbert, and Casey Horner – you can get the originals from https://unsplash.com if you want."
 */

struct DetailView: View {
    let book: Book
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @State private var showingDeleteAlert = false
    
    var body: some View {
        ScrollView {
            ZStack(alignment: .bottomTrailing) {
                Image(book.genre)
                            .resizable()
                            .scaledToFit()

                        Text(book.genre.uppercased())
                            .font(.caption)
                            .fontWeight(.black)
                            .padding(8)
                            .foregroundStyle(.white)
                            .background(.black.opacity(0.75))
                            .clipShape(.capsule)
                            .offset(x: -5, y: -5)
            } // ZStack
        } // ScrollView
        .navigationTitle(book.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button("Delete this book", systemImage: "trash") {
                showingDeleteAlert = true
            }
        }
        .scrollBounceBehavior(.basedOnSize)
        .alert("Delete book", isPresented: $showingDeleteAlert) {
            Button("Delete", role: .destructive, action: deleteBook)
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Are you sure?")
        }
        
        Text(book.author)
            .font(.title)
            .foregroundStyle(.secondary)

        Text(book.review)
            .padding()

        RatingView(rating: .constant(book.rating))
            .font(.largeTitle)
    } // body
    
    func deleteBook() {
        modelContext.delete(book)
        dismiss()
    }
}


#Preview {
    do {
        let container = PreviewContainer().container
        let descriptor = FetchDescriptor<Book>()
        let books = try container.mainContext.fetch(descriptor)
        
        let firstBook = books.first!
        
        return DetailView(book: firstBook)
            .modelContainer(container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")

    }
}
