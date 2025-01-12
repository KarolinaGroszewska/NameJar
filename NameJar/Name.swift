//
//  Name.swift
//  NameJar
//
//  Created by Kari Groszewska on 1/11/25.
//

import Foundation
import SwiftData

@Model
final class Name {
    var firstName: String
    
    init(firstName: String) {
        self.firstName = firstName
    }
}
