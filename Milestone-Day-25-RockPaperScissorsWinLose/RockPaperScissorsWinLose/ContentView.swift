//
//  ContentView.swift
//  RockPaperScissorsWinLose
//
//  Created by Gregory Randolph on 4/18/25.
//

import SwiftUI

enum Move: String {
    case rock
    case paper
    case scissors
    
    var imageName: String {
        switch self {
        case .rock:
            return "diamond"
        case .paper:
            return "rectangle.and.paperclip"
        case .scissors:
            return "scissors"
        }
    }
    
    static func random() -> Move {
        let index = Int.random(in: 0..<3)
        return Move.allCases[index]
    }
}

extension Move: Identifiable, CaseIterable {
    var id: RawValue { rawValue }
}

struct ContentView: View {
    @State private var showingFinal = false
    @State private var appMove: Move = Move.random()
    @State private var shouldWin = Bool.random()
    @State private var score = 0
    @State private var round = 0
    
    var body: some View {
        VStack {
            Spacer()
            Spacer()
            Group {
                Text("Round \(round + 1)")
                Text("Players score: \(score)")
            }
            .font(.title)
            
            Spacer()
            Group {
                Image(systemName: appMove.imageName)
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("Computer chooses \(appMove)")
            }
            .font(.title)
            Spacer()
            Text("You should choose a \(shouldWin ? "winning" : "losing") move")
                .font(.title)
            HStack {
                ForEach(Move.allCases) { move in
                    Button(move.rawValue, systemImage: move.imageName) {
                        playerMove(move)
                    }
                    .disabled(move == appMove)
                    .padding()
                    .background((move == appMove) ? .gray : .indigo)
                    .foregroundColor(.primary)
                    .clipShape(.rect(cornerRadius: 10))
                }
            }
            Spacer()
            Spacer()
        }
        .padding()
        .alert("Game Over", isPresented: $showingFinal) {
            Button("Reset?" , action: resetGame)
            Button("Cancel") {}
        } message: {
            Text("Final Score: \(score) / 10\nWould you like to play again?")
        }
    }
    
    private func playerMove(_ playerMove: Move) {
        round += 1
     
        let winning: Bool
        switch appMove {
        case .rock:
            winning = playerMove == .paper ? true : false
        case .paper:
            winning = playerMove == .scissors ? true : false
        case .scissors:
            winning = playerMove == .rock ? true : false
        }
        
            score += (shouldWin && winning) || !(shouldWin || winning) ? 1 : 0
        
        if round == 10 {
            showingFinal = true
        } else {
            appMove = Move.random()
            shouldWin.toggle()
        }
    }
    
    private func resetGame() {
        round = 0
        score = 0
        appMove = Move.random()
        shouldWin = Bool.random()
    }
}

#Preview {
    ContentView()
}
