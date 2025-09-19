//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Gregory Randolph on 9/12/25.
//

import SwiftUI
import SwiftData

/**
 To set up SwiftData by hand. It takes three steps,
 
 starting with us defining the data we want to use in our app.
 `
 `import SwiftData
 `@Model
 `class Student {
     `var id: UUID
     `var name: String

     `init(id: UUID, name: String) {
         `self.id = id
         `self.name = name
     `}
 `}
 `
 
 Now that we've defined the data we want to work with, we can proceed to the second step of setting up SwiftData: writing a little Swift code to load that model. This code will tell SwiftData to prepare some storage for us on the iPhone, which is where it will read and write  objects.
 
 1) add import SwiftData to the App (this file)
 2) add a model container
    `.modelContainer(for: Student.self)`
 
 
 The third part of the puzzle is called the model context, which is effectively the “live” version of your data – when you load objects and change them, those changes only exist in memory until they are saved. So, the job of the model context is to let us work with all our data in memory, which is much faster than constantly reading and writing data to disk.

 Every SwiftData app needs a model context to work with, and we've already created ours – it's created automatically when we use the modelContainer() modifier. SwiftData automatically creates one model context for us, called the main context, and stores it in SwiftUI's environment,

 That completes all our SwiftData configuration, so now it's time for the fun part: reading data, and writing it too.
 
 Those bits are copied from the tutorial. You actually need a couple more things.
 In Views accessing the data, you need the data context. Add an environment property to the View
 `@Environment(\.modelContext) var modelContext`
 
 And you need to actually query the data. Same place:
 `@Query var students: [Student]`
 
 
 Example adding data:
 `let student = Student(id: UUID(), name: "\(chosenFirstName) \(chosenLastName)")
 `modelContext.insert(student)`
 */

@main
struct BookwormApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Book.self)
    }
}
