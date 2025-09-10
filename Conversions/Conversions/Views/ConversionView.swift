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
    
    
    init(initalInUnitIndex: Int, initialOutUnitIndex: Int, title: String, isSegmented: Bool) {
        inputType = T.allTitles[initalInUnitIndex]
        outputType = T.allTitles[initialOutUnitIndex]
        self.title = title
        self.isSegmented = isSegmented
    }
    
    func convert(value: Double, from: T, to: T) -> Double {
        let inMeasurement = Measurement(value: value, unit: from.unit)
        let outMeasurement = inMeasurement.converted(to: to.unit)
        return outMeasurement.value
    }
    
    /**
     TODO: I'm not the happiest with this. I think it could be laid out better.
     */
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .padding(.leading)
            HStack {
                Form {
                    TextField("Input", value: $inputValue, format: .number)
                }
                .containerRelativeFrame(.horizontal) { size, axis in
                    size * 2.5 / 7.0
                }
                Form {
                    Picker("Unit", selection: $inputType) {
                        ForEach(T.allTitles, id: \.self) {
                            Text($0)
                        }
                    }
                    .conditionalPickerStyle(isSegmented: isSegmented)
                    .labelsHidden()
                } // form
            } // hstack
            HStack {
                Form {
                    Text("\(convert(value: inputValue, from: T(rawValue: inputType)!, to: T(rawValue: outputType)!), specifier: "%.2f")")
                }
                .containerRelativeFrame(.horizontal) { size, axis in
                    size * 2.5 / 7.0
                }
                Form {
                    Picker("Units", selection: $outputType) {
                        ForEach(T.allTitles, id: \.self) {
                            Text($0)
                        }
                    }
                    .conditionalPickerStyle(isSegmented: isSegmented)
                    .labelsHidden()
                } // form
            } // hstack
        } //  VStack
        .frame(height: 230)
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

#Preview {
    NavigationStack {
        ConversionView<Length>(initalInUnitIndex: 1, initialOutUnitIndex: 0, title: "Lengths", isSegmented: false)
    }
}
