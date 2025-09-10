//
//  ContentView.swift
//  BetterRest
//
//  Created by Gregory Randolph on 4/21/25.
//

import CoreML
import SwiftUI

struct ContentView: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? .now
    }
    
    let now = Date.now
    let tomorrow = Date.now.addingTimeInterval(86400)
    lazy var range = now...tomorrow
    
    let itNow = Text(Date.now, format: .dateTime.hour().minute())
    
    var body: some View {
        NavigationStack {
            Form {
                Section() {
                    Text("When do you want to wake up?")
                        .font(.headline)
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }
                
                Section() {
                    Text("Desired amount of sleep")
                        .font(.headline)
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, step: 0.25)
                }
                
                Section() {
                    Text("Daily coffee intake")
                        .font(.headline)

                    Picker("Daily coffee intake", selection: $coffeeAmount) {
                        ForEach(1...20, id: \.self) {
                            Text("^[\($0) cup](inflect: true)")
                        }
                    }
                    .labelsHidden()
                }
                
                Section() {
                    Text("Your ideal bedtime is...")
                        .font(.headline)
                    Text("\(calculateBedTime().formatted(date: .omitted, time: .shortened))")
                        .font(.largeTitle)
                }
            } // Body VStack
            .navigationTitle("BetterRest")
        }
    }
    
    private func calculateBedTime() -> Date {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = Double(components.hour ?? 0) * 60 * 60
            let minute = Double(components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            let sleepTime = wakeUp - prediction.actualSleep
            return sleepTime
        } catch {
            return .now
        }
    }
}

#Preview {
    ContentView()
}
