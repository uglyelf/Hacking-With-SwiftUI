//
//  LengthView.swift
//  Conversions
//
//  Created by Gregory Randolph on 3/22/25.
//

import SwiftUI

struct ConversionView<T: MeasureableUnit>: View {
    private let title: String
    private let isSegmented: Bool // else is menu
    @State private var inputType: String
    @State private var outputType: String
    @State private var inputValue: Double = 1.0
    
    
    init(initalIndex: Int, title: String, isSegmented: Bool) {
        inputType = T.allTitles[initalIndex]
        outputType = T.allTitles[initalIndex]
        self.title = title
        self.isSegmented = isSegmented
    }
    
    func convert(value: Double, from: T, to: T) -> Double {
        let inMeasurement = Measurement(value: value, unit: from.unit)
        let outMeasurement = inMeasurement.converted(to: to.unit)
        return outMeasurement.value
    }
    
    var body: some View {
        /*
         TODO: convert GeometryReader to using
         .containerRelativeFrame(.horizontal) { width, axis in
             width * 0.6
         }
         */
        VStack(alignment: .leading, spacing: 0) {
            Text(title)
            GeometryReader { geometry in
                HStack {
                    Form {
                        Section("Input") {
                            TextField("Input", value: $inputValue, format: .number) // TODO: fix the formatting
                        }
                    }
                    .frame(width: geometry.size.width * 3 / 7)
                    Form {
                        Section("Unit") {
                            // emptyview is an antipattern, but navigationLink pickers don't respect labelshidden
                            Picker(selection: $inputType, label: EmptyView()) {
                                ForEach(T.allTitles, id: \.self) {
                                    Text($0)
                                }
                            }
                            .conditionalPickerStyle(isSegmented: isSegmented)
                            .frame(alignment: .leading)
                        } // section
                    } // form
                    .frame(width: geometry.size.width * 4 / 7)
                } // hstack
            } // GeometryReader
            
            GeometryReader { geometry in
                HStack {
                    Form {
                        Section("Out") {
                            Text("\(convert(value: inputValue, from: T(rawValue: inputType)!, to: T(rawValue: outputType)!), specifier: "%.2f")")
                        }
                    }
                    .frame(width: geometry.size.width * 3 / 7)
                    Form {
                        Section("Unit") {
                            Picker(selection: $outputType, label: EmptyView()) {
                                ForEach(T.allTitles, id: \.self) {
                                    Text($0)
                                }
                            }
                            .conditionalPickerStyle(isSegmented: isSegmented)
                            .frame(alignment: .leading)
                        } // section
                    } // form
                    .frame(width: geometry.size.width * 4 / 7)
                } // hstack
            } // GR
            Spacer().frame(height: .infinity)
        } //  VStack
        .frame(height: 300)
    }
}

#Preview {
    NavigationStack {
        ConversionView<Length>(initalIndex: 0, title: "Lengths", isSegmented: false)
    }
}

struct ConditionalPickerStyle: ViewModifier {
    let isSegmented: Bool

    func body(content: Content) -> some View {
        if isSegmented {
            content.pickerStyle(.segmented)
        } else {
            content.pickerStyle(.menu)
        }
    }
}

// Extension to make it easy to apply
extension View {
    func conditionalPickerStyle(isSegmented: Bool) -> some View {
        modifier(ConditionalPickerStyle(isSegmented: isSegmented))
    }
}
