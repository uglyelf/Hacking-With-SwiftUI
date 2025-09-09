//
//  ContentView.swift
//  WordScramble
//
//  Created by Gregory Randolph on 4/30/25.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    @State private var score = 0
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    TextField("Enter your word", text: $newWord)
                        .textInputAutocapitalization(.never)
                }
                Section("Score") {
                    Text("\(score)")
                }
                Section {
                    ForEach(usedWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                    }
                }
            } // List
            .navigationTitle(rootWord)
            .onSubmit(addNewWord)
            .onAppear(perform: startGame)
            .alert(errorTitle, isPresented: $showingError) { }
            message: {
                Text(errorMessage)
            }
            .toolbar {
                Button("New Word") {
                    startGame()
                }
            }
        }
    }
    
    func startGame() {
        // 1. Find the URL for start.txt in our app bundle
        guard let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt"),
              // 2. Load start.txt into a string
              let startWords = try? String(contentsOf: startWordsURL, encoding: .ascii) else {
            // If were are *here* then there was a problem – trigger a crash and report the error
            fatalError("Could not load start.txt from Bundle.")
        }
        let allWords = startWords.components(separatedBy: "\n")
        
        // 4. Pick one random word, or use "silkworm" as a sensible default
        rootWord = allWords.randomElement() ?? "silkworm"
        
        score = 0
        usedWords = []
        
        // If we are here everything has worked, so we can exit
    }
    
    func addNewWord() {
        // lowercase and trim the word, to make sure we don't add duplicate words with case differences
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        // exit if the remaining string is empty
        guard answer.count > 0 else { return }
        
        // extra validation to come
        guard isOrginal(word: answer) else {
            wordError(title: "Word already used.", message: "Be more original.")
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "Word not possible", message: "You can't spell that word from \(rootWord)!")
            return
        }
        
        guard isReal(word: answer) else {
            wordError(title: "Word not recognized", message: "You can't just make them up, you know.")
            return
        }
        
        guard isNotRootWord(word: answer) else {
            wordError(title: "Word is identical", message: "No, you can't just copy the word you're looking at.")
            return
        }
        
        guard isLongEnough(word: answer) else {
            wordError(title: "Too short", message: "Words need to be at least 3 letters long.")
            return
        }
        
        withAnimation {
            usedWords.insert(answer, at: 0)
            score += answer.count
        }
        newWord = ""
    }
    
    func isOrginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        
        for letter in word {
            guard let positive = tempWord.firstIndex(of: letter) else { return false }
            tempWord.remove(at: positive)
        }
        return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    
    func isNotRootWord(word: String) -> Bool {
        return !(word == rootWord)
    }
    
    func isLongEnough(word: String) -> Bool {
        return word.count >= 3
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
}

#Preview {
    ContentView()
}
