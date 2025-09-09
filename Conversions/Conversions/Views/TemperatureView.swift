//
//  Temperatures.swift
//  Conversions
//
//  Created by Gregory Randolph on 3/22/25.
//

/*
 Note using this anymore. Keeping it as a reference before I generalized it.
 I wouldn't leave dead code in something for production like this, but it's useful for learning
 */


import SwiftUI

struct TemperatureView: View {
    // Temperature state
    let temperatureUnits = ["celsius", "fahrenheit", "kelvin"]
    @State private var temperatureInput = 0.0
    @State private var temperatureInputUnit = "celsius"
    @State private var temperatureOutputUnit = "fahrenheit"
    
    var temperatureOutput: Double {
        var input: Measurement<UnitTemperature>
        switch temperatureInputUnit {
        case "celsius":
            input = Measurement(value: temperatureInput, unit: UnitTemperature.celsius)
        case "fahrenheit":
            input = Measurement(value: temperatureInput, unit: UnitTemperature.fahrenheit)
        default: // kelvin
            input = Measurement(value: temperatureInput, unit: UnitTemperature.kelvin)
        }
        
        var output: Measurement<UnitTemperature>
        switch temperatureOutputUnit {
        case "celsius":
            output = input.converted(to: .celsius)
        case "fahrenheit":
            output = input.converted(to: .fahrenheit)
        default:
            output = input.converted(to: .kelvin)
        }
        
        return output.value
        
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Temperature")
            GeometryReader { geometry in
                HStack(spacing: 0) {
                    Form {
                        Section("input") {
                            TextField("Temperature Input", value: $temperatureInput, format: .number)
                        }
                    }
                    .frame(maxWidth: geometry.size.width * 2 / 7)
                    
                    Form {
                        Section("unit") {
                            Picker("Input", selection: $temperatureInputUnit) {
                                ForEach(temperatureUnits, id: \.self) {
                                    Text($0)
                                }
                            }
                            .pickerStyle(.segmented)
                            .labelsHidden()
                        }
                    }
                    .frame(minWidth: geometry.size.width * 4 / 7)
                    
                } // Input HStack
            }
            GeometryReader { geometry in
                HStack(spacing: 0) {
                    Form {
                        Section("out") {
                            //                                    Text(temperatureOutput, format: .number)
                            Text("\(temperatureOutput, specifier: "%.1f")")
                        }
                    }
                    
                    Form {
                        Section("unit") {
                            Picker("Input", selection: $temperatureOutputUnit) {
                                ForEach(temperatureUnits, id: \.self) {
                                    Text($0)
                                }
                            }
                            .pickerStyle(.segmented)
                            .labelsHidden()
                        }
                    }
                    .frame(minWidth: geometry.size.width * 8 / 11)
                    
                } // output HStack
            }
            
            Spacer().frame(height: .infinity)
        } // Temperature VStack
        .frame(height: 300)
    }
}

#Preview {
    TemperatureView()
}
