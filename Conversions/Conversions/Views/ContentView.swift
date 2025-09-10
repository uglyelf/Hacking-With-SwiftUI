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
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    ConversionView<Temperature>(initalInUnitIndex: 1, initialOutUnitIndex: 0, title: "Temperature", isSegmented: true)
                    Divider()
                        .overlay(Color.accentColor)
                    ConversionView<Duration>(initalInUnitIndex: 1, initialOutUnitIndex: 0, title: "Duration", isSegmented: false)
                    Divider()
                        .overlay(Color.accentColor)
                    ConversionView<Length>(initalInUnitIndex: 1, initialOutUnitIndex: 0, title: "Lengths", isSegmented: false)
                } // VStack
            } // ScrollView
            .scrollBounceBehavior(.basedOnSize)
            .preferredColorScheme(.dark)
            .navigationBarTitle("Conversions")
            .navigationBarTitleDisplayMode(.inline)
        }
        //        }
    } // body
}

#Preview {
    ContentView()
}
