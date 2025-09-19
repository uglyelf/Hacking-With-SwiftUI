//
//  Book.swift
//  Bookworm
//
//  Created by Gregory Randolph on 9/14/25.
//

import Foundation
import SwiftData

enum Genres: String, CaseIterable {
    case fantasy, horror, kids, mystery, poetry, romance, scifi, thriller
    
    var description: String {
        if self == .scifi {
            return "Science Fiction"
        }
        return self.rawValue.capitalized
    }
}

@Model
class Book {
    var title: String
    var author: String
    var genre: String
    var review: String
    var rating: Int
    
    init(title: String, author: String, genre: String, review: String, rating: Int) {
        self.title = title
        self.author = author
        self.genre = genre
        self.review = review
        self.rating = rating
    }
    
    
}
