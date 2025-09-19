//
//  ContentView.swift
//  Bookworm
//
//  Created by Gregory Randolph on 9/12/25.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: [
        SortDescriptor(\Book.author), // ascending
        SortDescriptor(\Book.title) // ascending
    ]) var books: [Book]
    
    @State private var showingAddBooks = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(books) { book in
                    NavigationLink(value: book) {
                        HStack {
                            EmojiRatingView(rating: book.rating)
                                .font(.largeTitle)
                            
                            VStack(alignment: .leading) {
                                Text(book.title)
                                    .font(.headline)
                                Text(book.author)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                } // ForEach
                .onDelete(perform: deleteBooks)
            } // List
            .navigationTitle(Text("Bookworm"))
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add Book", systemImage: "plus") {
                        showingAddBooks.toggle()
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
            }
            .sheet(isPresented: $showingAddBooks) {
                AddBookView()
            }
            .navigationDestination (for: Book.self) { book in
                DetailView(book: book)
            }
        } // NavigationStack
    } // body
    
    
    func deleteBooks(at offsets: IndexSet) {
        for offset in offsets {
            let book = books[offset]
            modelContext.delete(book)
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(PreviewContainer().container)
}
