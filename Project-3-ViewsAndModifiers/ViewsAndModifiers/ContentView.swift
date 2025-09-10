//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Gregory Randolph on 3/25/25.
//

import SwiftUI

/**
 This just plays with some views and stuff. Not a real project.
 */

struct ContentView: View {
//    @State private var agreedToTerms = false
//        @State private var agreedToPrivacyPolicy = false
//        @State private var agreedToEmails = false
//
//        var body: some View {
//            let agreedToAll = Binding<Bool>(
//                get: {
//                    agreedToTerms && agreedToPrivacyPolicy && agreedToEmails
//                },
//                set: {
//                    agreedToTerms = $0
//                    agreedToPrivacyPolicy = $0
//                    agreedToEmails = $0
//                }
//            )
//
//            return VStack {
//                Toggle("Agree to terms", isOn: $agreedToTerms)
//                Toggle("Agree to privacy policy", isOn: $agreedToPrivacyPolicy)
//                Toggle("Agree to receive shipping emails", isOn: $agreedToEmails)
//                Toggle("Agree to all", isOn: agreedToAll)
//            }
//        }
    @ViewBuilder var spells: some View {
        Text("Lumos")
        Text("Obliviate")
    }
    
    var body: some View {
        VStack {
            GridStack(rows: 4, columns: 4) { row, col in
                Image(systemName: "\(row * 4 + col).circle")
                Text("R\(row) C\(col)")
            }
            Text("Gryffindor")
                .blur(radius: 1)
            Text("Hufflepuff")
            Text("Ravenclaw")
                .modifier(Title())
            Text("Slytherin")
                .blueTitle()
        }
//        .blur(radius: 5)
    }
}

struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    @ViewBuilder let content: (Int, Int) -> Content

    var body: some View {
        VStack {
            ForEach(0..<rows, id: \.self) { row in
                HStack {
                    ForEach(0..<columns, id: \.self) { column in
                        content(row, column)
                    }
                }
            }
        }
    }
}

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundStyle(.blue)
            .padding()
//            .background(.blue)
//            .clipShape(.rect(cornerRadius: 10))
    }
}

extension View {
    func blueTitle() -> some View {
        modifier(Title())
    }
}

#Preview {
    ContentView()
}
