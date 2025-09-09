//
//  ConversionViewModel.swift
//  Conversions
//
//  Created by Gregory Randolph on 3/24/25.
//

import Foundation
import SwiftUI


protocol MeasureableUnit: CaseIterable, Identifiable, RawRepresentable where Self.RawValue == String  {
    static var allTitles : [String] { get }
    var unit: Dimension { get }
}

extension MeasureableUnit {
    var id: Self { self }
    static var allTitles: [String] { allCases.map( \.rawValue ) }
}

enum Length: String, MeasureableUnit {
    case millimeters, centimeters, meters, kilometers, inches, feet, yards, miles, lightYears = "light years"
    
    var unit: Dimension {
        switch self {
        case .millimeters: return UnitLength.millimeters
        case .centimeters: return UnitLength.centimeters
        case .meters: return UnitLength.meters
        case .kilometers: return UnitLength.kilometers
        case .inches: return UnitLength.inches
        case .feet: return UnitLength.feet
        case .yards: return UnitLength.yards
        case .miles: return UnitLength.miles
        case .lightYears: return UnitLength.lightyears
        }
    }
}

enum Temperature: String, MeasureableUnit {
    case celsius, fahrenheit, kelvin
    
    var unit: Dimension {
        switch self {
        case .celsius: return UnitTemperature.celsius
        case .fahrenheit: return UnitTemperature.fahrenheit
        case .kelvin: return UnitTemperature.kelvin
        }
    }
}

enum Duration: String, MeasureableUnit {
    case seconds, minutes, hours, days, weeks, months, years
    
    var unit: Dimension {
        switch self {
        case .seconds: return UnitDuration.seconds
        case .minutes: return UnitDuration.minutes
        case .hours: return UnitDuration.hours
        case .days: return UnitDuration.hours
        case .weeks: return UnitDuration.hours
        case .months: return UnitDuration.hours
        case .years: return UnitDuration.hours
        }
    }
}
