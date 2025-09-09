//
//  ContentView.swift
//  Navigation
//
//  Created by Gregory Randolph on 7/23/25.
//

import SwiftUI

struct ContentView: View {
    @State private var pathStore = PathStore()
    @State private var title = "SwiftUI"
    
    var body: some View {
        NavigationStack {
            Text("Hello, world!")
                .navigationTitle($title)
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ContentView()
}

struct DetailView: View {
    var number: Int
    @Binding var pathStore: PathStore
    
    var body: some View {
        NavigationLink("Go to Random Number", value: Int.random(in: 1...1000))
            .navigationTitle("Number: \(number)")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.blue)
            .toolbar {
                Button("Home") {
                    pathStore.clear()
                }
            }
    }
}
