//
//  Extensions.swift
//  Bookworm
//
//  Created by Gregory Randolph on 9/19/25.
//

import Foundation

extension String {
    var isAllWhitespace: Bool {
        return reduce(true) { (result, character) in
            result && character.isWhitespace
        }
    }
}
