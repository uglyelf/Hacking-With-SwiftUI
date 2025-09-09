//
//  SheetView.swift
//  LearnTimesTables
//
//  Created by Gregory Randolph on 7/17/25.
//

import SwiftUI

struct SheetView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var timesTable: Int
    @Binding var numberOfQuestions: Int
    @Binding var showTextField: Bool
    
    var body: some View {
        VStack {
            Spacer()
            
            Form {
                Section("Which multiplication table\nwould you like?:") {
                    Picker("Multiplication Table", selection: $timesTable) {
                        ForEach(2...5, id: \.self) {
                            Text("\($0)").tag($0)
                        }
                    }
                    .pickerStyle(.segmented)
                    Picker("Multiplication Table", selection: $timesTable) {
                        ForEach(6...9, id: \.self) {
                            Text("\($0)").tag($0)
                        }
                    }
                    .pickerStyle(.segmented)
                    Picker("Multiplication Table", selection: $timesTable) {
                        ForEach(10...12, id: \.self) {
                            Text("\($0)").tag($0)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                Section("How many questions would\nyou like in this set?") {
                    Picker("Number of Questions:", selection: $numberOfQuestions) {
                        Text("5").tag(5)
                        Text("10").tag(10)
                        Text("20").tag(20)
                    }
                    .pickerStyle(.segmented)
                }
                Section("Difficulty:") {
                    Picker("Difficulty", selection: $showTextField) {
                        Text("Easy").tag(false)
                        Text("Hard").tag(true)
                    }
                    .pickerStyle(.segmented)
                }
            }
            
            Spacer()
            HStack {
                Spacer()
                Button("Done") {
                    dismiss()
                }
                .font(.title3)
                .padding()
            }
        }
    }
}

#Preview {
    ContentView()
}

