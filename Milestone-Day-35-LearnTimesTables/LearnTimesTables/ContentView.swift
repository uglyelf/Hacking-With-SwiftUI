//
//  ContentView.swift
//  LearnTimesTables
//
//  Created by Gregory Randolph on 7/8/25.
//

import SwiftUI

struct ContentView: View {
    @State private var timesTable = 2 // 2...10 times table
    @State private var numberOfQuestions = 10 // 5, 10, 20
    
    @State private var questionSet = Array(2..<13).shuffled()
    @State private var score = 0
    @State private var roundNumber = 1
    @State private var answerText = ""
    @State private var answerFieldText = ""
    
    @State private var showingFinal = false
    @State private var showTextField = false // else buttons
    @State private var showingSheet = true
    
    @State private var disabled = false
    @State private var easyAnswers: [Int] = []
    
    private var multiplier: Int { questionSet[roundNumber - 1] }
    private var correctAnswer: Int { timesTable * questionSet[roundNumber - 1] }
    
    
    var body: some View {
        VStack {
            
            Text("Round \(roundNumber)")
                .font(.largeTitle)
            Text("Score: \(score)/\(numberOfQuestions)")
            Spacer()
            Form {
                Section {
                    Text("\(timesTable) * \(multiplier) = ?")
                        .font(.title)
                }
                Section {
                    if showTextField {
                        TextField("\(timesTable) * \(multiplier) =", text: $answerText)
                            .keyboardType(.decimalPad)
                            .disableAutocorrection(true)
                            .padding(60)
                            .disabled(disabled)
                    } else {
                        Picker("Choose an answer", selection: $answerText) {
                            ForEach(easyAnswers, id: \.self) { answer in
                                Text("\(answer)").tag(String(answer))
                            }
                        }
                        .pickerStyle(.segmented)
                        .disabled(disabled)
                    }
                } header: {
                    Text(showTextField ? "Type your answer" : "Choose an answer")
                }
                Section {
                    HStack {
                        Spacer()
                        Button("Enter") {
                            answerQuestion()
                        }
                        .frame(maxWidth: 150, maxHeight: .leastNonzeroMagnitude)
                        .padding(.vertical, 20)
                        .background(.regularMaterial)
                        .clipShape(.rect(cornerRadius: 20))
                        .disabled(disabled || (answerText.isEmpty))
                    }
                }
                Section {
                    Text(answerFieldText)
                }
            }
            Spacer()
            Button("Change Settings") {
                showingSheet.toggle()
            }
            .sheet(isPresented: $showingSheet) {
                SheetView(timesTable: $timesTable, numberOfQuestions: $numberOfQuestions, showTextField: $showTextField)
            }
            .onChange(of: showingSheet) {
                guard !showingSheet else { return }
                newGame()
            }
        }
        .padding(10)
        .alert("Set Finished!", isPresented: $showingFinal) {
            Button("Cancel") {}
        } message: {
            Text("Final Score: \(score)\nNice Job!") // randomize the compliment or suggest encouragement based on less than half, above, or perfect
        }
    }
    
    private func getEasyAnswers() -> [Int] {
        let onlyWrongAnswers = questionSet.filter { $0 != multiplier }
        var possibleAnswers = onlyWrongAnswers.prefix(2).map { $0 * timesTable }
        possibleAnswers.append(correctAnswer)
        return possibleAnswers.shuffled()
    }
    
    private func newGame() {
        print("New Game")
        questionSet = Array(2..<13).shuffled()
        roundNumber = 1
        answerText = ""
        score = 0
        disabled = false
        answerFieldText = ""
        easyAnswers = getEasyAnswers()
    }
    
    private func answerQuestion() {
        if Int(answerText) == timesTable * questionSet[roundNumber - 1] {
            score += 1
        }
        let correct = correctAnswer
        let previousQuestion = "Previous Question: \(timesTable) * \(questionSet[roundNumber - 1]) =\n"
        let userAnswer = Int(answerText) ?? 0
        
        guard roundNumber < numberOfQuestions else {
            answerText = "Nice Job!"
            answerFieldText = "\(previousQuestion)Your Answer \(userAnswer) \(userAnswer == correct ? "🎉" : "😕\nCorrect Answer \(correct)")\nFinal Score: \(score) out of \(numberOfQuestions)\nSet Finished!"
            disabled = true
            return
        }
        
        roundNumber += 1
        answerText = ""
        easyAnswers = getEasyAnswers()
        
        answerFieldText = "\(previousQuestion)Your Answer \(userAnswer) \(userAnswer == correct ? "🎉" : "😕\nCorrect Answer \(correct)")"
    }
}

extension Collection {
    func choose(_ n: Int) -> ArraySlice<Element> { shuffled().prefix(n) }
}

#Preview {
    ContentView()
}
