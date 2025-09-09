//
//  Astronauts.swift
//  Moonshot
//
//  Created by Gregory Randolph on 7/21/25.
//

import Foundation

struct Astronaut: Codable, Hashable, Identifiable {
    let id: String
    let name: String
    let description: String
}
