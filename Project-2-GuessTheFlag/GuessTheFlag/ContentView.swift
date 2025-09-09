//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Gregory Randolph on 3/24/25.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var showingFinal = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var roundNumber = 1
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var animationAmount = 0.0
    @State private var opacity = 1.0
    @State private var scaleAmount = 1.0
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                    .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                    .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 700, endRadius: 200)
                .ignoresSafeArea()
            VStack {
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(.white)
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .font(.subheadline.weight(.bold))
                            .foregroundStyle(.white)
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            FlagImage(number: number, country: countries[number])
                        }
                        .rotation3DEffect(.degrees(number == correctAnswer ? animationAmount : (animationAmount * -1)), axis: (x:0, y:1, z:0))
                        .opacity(number == correctAnswer ? 1 : opacity)
                        .scaleEffect(number == correctAnswer ? 1 : scaleAmount)
                    }
                } // outer vstack
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                Spacer()
                Spacer()
                Text("Score: \(score)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                Spacer()
            } // outermost vstack
            .padding()
        } // ZStack
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score)")
        }
        .alert(scoreTitle, isPresented: $showingFinal) {
            Button("Reset?" , action: resetGame)
            Button("Cancel") {}
        } message: {
            Text("Final Score: \(score) / 8\nWould you like to play again?")
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Incorrect. That's the flag of \(countries[number])"
        }
        
        guard roundNumber != 8 else {
            showingFinal = true
            return
        }
        withAnimation {
            animationAmount += 360
            opacity = 0.25
            scaleAmount = 0.50
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            showingScore = true
        }
    }
    
    func resetGame() {
        score = 0
        roundNumber = 1
        askQuestion()
        showingFinal = false
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        roundNumber += 1
        animationAmount = 0
        scaleAmount = 1
        opacity = 1
    }
}

struct FlagImage: View {
    var number: Int
    var country: String
    var body: some View {
        Image(country)
            .clipShape(.capsule)
            .shadow(radius: 5)
    }
}

#Preview {
    ContentView()
}
