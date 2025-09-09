//
//  ContentView.swift
//  Conversions
//
//  Created by Gregory Randolph on 3/22/25.
//

import SwiftUI


/*
 ✓ Temperature conversion: users choose Celsius, Fahrenheit, or Kelvin.
 ✓ Length conversion: users choose meters, kilometers, feet, yards, or miles.
 Time conversion: users choose seconds, minutes, hours, or days.
 Volume conversion: users choose milliliters, liters, cups, pints, or gallons.
 If you were going for length conversion you might have:

 A segmented control for meters, kilometers, feet, yard, or miles, for the input unit.
 A second segmented control for meters, kilometers, feet, yard, or miles, for the output unit.
 A text field where users enter a number.
 A text view showing the result of the conversion.
 */


struct ContentView: View {
//    @FocusState private var amountIsFocused: Bool // TODO: figure out how to make this available to subviews
    
    var body: some View {
        ScrollView {
            VStack {
//                TemperatureView()
                ConversionView<Temperature>(initalIndex: 0, title: "Temperature", isSegmented: true)
                ConversionView<Duration>(initalIndex: 0, title: "Duration", isSegmented: false)
                ConversionView<Length>(initalIndex: 0, title: "Lengths", isSegmented: false)
            } // ScrollView
            .navigationBarTitle("Conversions")
            .navigationBarTitleDisplayMode(.inline)
            //                .toolbar {
            //                    if textFieldFocused {
            //                        Button("Done") {
            //                            amountIsFocused = false
            //                        }
            //                    }
            //                }
        } // ScrollView
        .scrollBounceBehavior(.basedOnSize)
        .preferredColorScheme(.dark)
    } // body
}

#Preview {
    ContentView()
}
